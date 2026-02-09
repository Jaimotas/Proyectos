package es.gob.extranjeria.repository;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import es.gob.extranjeria.DTO.ColumnaDTO;
import es.gob.extranjeria.DTO.TablaDTO;

@Repository
public class GenericCrudRepository {
    
    private final JdbcTemplate jdbcTemplate;
    
    // ⚠️ Tablas permitidas para operaciones (whitelist de seguridad)
    private static final List<String> TABLAS_PERMITIDAS = List.of(
        "lga_modelos", "lga_permisos", "lga_via_acceso", "lga_autorizaciones"
        // Añade aquí todas tus tablas permitidas
    );
    
    public GenericCrudRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    /**
     * Valida que el nombre de tabla sea seguro
     */
    private void validarNombreTabla(String tabla) {
        if (tabla == null || tabla.trim().isEmpty()) {
            throw new IllegalArgumentException("Nombre de tabla no puede estar vacío");
        }
        
        // Solo permitir tablas de la whitelist
        if (!TABLAS_PERMITIDAS.contains(tabla.toLowerCase())) {
            throw new IllegalArgumentException("Tabla no permitida: " + tabla);
        }
        
        // Validar caracteres permitidos (solo letras, números y guión bajo)
        if (!tabla.matches("^[a-zA-Z0-9_]+$")) {
            throw new IllegalArgumentException("Nombre de tabla contiene caracteres no permitidos");
        }
    }
    
    /**
     * Valida que el nombre de columna sea seguro
     */
    private void validarNombreColumna(String columna) {
        if (columna == null || columna.trim().isEmpty()) {
            throw new IllegalArgumentException("Nombre de columna no puede estar vacío");
        }
        
        if (!columna.matches("^[a-zA-Z0-9_]+$")) {
            throw new IllegalArgumentException("Nombre de columna contiene caracteres no permitidos");
        }
    }
    
    public List<TablaDTO> obtenerTablas() {
        String sql = """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_type = 'BASE TABLE'
              AND table_name IN (?, ?, ?, ?)
            ORDER BY table_name
        """;
        
        // Solo devolver tablas permitidas
        return jdbcTemplate.query(sql, 
            TABLAS_PERMITIDAS.toArray(),
            (rs, rowNum) -> new TablaDTO(rs.getString("table_name"))
        );
    }
    
    public List<ColumnaDTO> obtenerColumnas(String tabla) {
        validarNombreTabla(tabla);
        
        String sql = """
            SELECT 
                c.column_name, 
                c.data_type,
                c.column_key,
                c.extra,
                c.is_nullable,
                c.column_default,
                kcu.referenced_table_name,
                kcu.referenced_column_name
            FROM information_schema.columns c
            LEFT JOIN information_schema.key_column_usage kcu
                ON c.table_schema = kcu.table_schema
                AND c.table_name = kcu.table_name
                AND c.column_name = kcu.column_name
                AND kcu.referenced_table_name IS NOT NULL
            WHERE c.table_schema = DATABASE()
              AND c.table_name = ?
            ORDER BY c.ordinal_position
        """;
        
        return jdbcTemplate.query(sql, new Object[]{tabla}, (rs, rowNum) -> {
            ColumnaDTO dto = new ColumnaDTO(
                rs.getString("column_name"),
                rs.getString("data_type")
            );
            dto.setColumnKey(rs.getString("column_key"));
            dto.setExtra(rs.getString("extra"));
            dto.setIsNullable(rs.getString("is_nullable"));
            dto.setColumnDefault(rs.getString("column_default"));
            dto.setReferencedTable(rs.getString("referenced_table_name"));
            dto.setReferencedColumn(rs.getString("referenced_column_name"));
            return dto;
        });
    }
    
    /**
     * ⚠️ VERSIÓN MEJORADA: Inserta con validación y manejo inteligente de NULL
     */
    public void insertar(String tabla, Map<String, Object> datos) {
        validarNombreTabla(tabla);
        
        if (datos.isEmpty()) {
            throw new IllegalArgumentException("No hay datos para insertar");
        }
        
        // Validar nombres de columnas
        datos.keySet().forEach(this::validarNombreColumna);
        
        // Obtener columnas de la tabla para validar
        List<ColumnaDTO> columnasTabla = obtenerColumnas(tabla);
        Map<String, ColumnaDTO> mapaColumnas = columnasTabla.stream()
            .collect(Collectors.toMap(ColumnaDTO::getNombre, c -> c));
        
        // Procesar y filtrar datos
        Map<String, Object> datosFinales = new java.util.LinkedHashMap<>();
        
        for (Map.Entry<String, Object> entry : datos.entrySet()) {
            String nombreColumna = entry.getKey();
            Object valor = entry.getValue();
            
            // Verificar que la columna existe
            if (!mapaColumnas.containsKey(nombreColumna)) {
                System.out.println("ADVERTENCIA: Columna no existe: " + nombreColumna);
                continue;
            }
            
            ColumnaDTO columna = mapaColumnas.get(nombreColumna);
            
            // Procesar el valor según el tipo de columna
            Object valorProcesado = procesarValor(valor, columna);
            
            // Solo incluir si no es null o si la columna lo permite
            if (valorProcesado != null) {
                datosFinales.put(nombreColumna, valorProcesado);
            } else if (columna.esNullable()) {
                // Si es nullable, incluir explícitamente como null
                datosFinales.put(nombreColumna, null);
            } else if (columna.getColumnDefault() != null) {
                // Si tiene valor por defecto, no incluir (dejará que la BD use el default)
                continue;
            } else if (!columna.esAutoIncrement()) {
                // Si no acepta NULL, no tiene default, y no es AI -> ERROR
                throw new IllegalArgumentException(
                    "La columna '" + nombreColumna + "' no acepta valores NULL y no se proporcionó un valor válido"
                );
            }
        }
        
        if (datosFinales.isEmpty()) {
            throw new IllegalArgumentException("No hay datos válidos para insertar");
        }
        
        // Construir SQL de forma segura
        String columnas = String.join(", ", datosFinales.keySet());
        String placeholders = datosFinales.keySet().stream()
            .map(k -> "?")
            .collect(Collectors.joining(", "));
        
        String sql = String.format("INSERT INTO %s (%s) VALUES (%s)", 
            tabla, columnas, placeholders);
        
        System.out.println("SQL: " + sql);
        System.out.println("Valores: " + datosFinales.values());
        
        jdbcTemplate.update(sql, datosFinales.values().toArray());
    }

    /**
     * Procesa un valor según el tipo de columna
     */
    private Object procesarValor(Object valor, ColumnaDTO columna) {
        // Si es null, devolver null
        if (valor == null) {
            return null;
        }
        
        // Si es String vacío, tratarlo como null
        if (valor instanceof String) {
            String strValor = ((String) valor).trim();
            if (strValor.isEmpty()) {
                return null;
            }
            
            // Convertir según el tipo de dato
            String tipo = columna.getTipo().toLowerCase();
            
            try {
                if (tipo.contains("int") || tipo.contains("tinyint") || 
                    tipo.contains("smallint") || tipo.contains("bigint")) {
                    return Integer.parseInt(strValor);
                } else if (tipo.contains("decimal") || tipo.contains("double") || 
                           tipo.contains("float")) {
                    return Double.parseDouble(strValor);
                } else if (tipo.contains("date") && !tipo.contains("datetime")) {
                    return java.sql.Date.valueOf(strValor);
                } else if (tipo.contains("datetime") || tipo.contains("timestamp")) {
                    return java.sql.Timestamp.valueOf(strValor);
                } else if (tipo.contains("time")) {
                    return java.sql.Time.valueOf(strValor);
                }
                // Para VARCHAR, TEXT, etc., devolver el string tal cual
                return strValor;
            } catch (Exception e) {
                throw new IllegalArgumentException(
                    "Error convirtiendo valor '" + strValor + "' para columna '" + 
                    columna.getNombre() + "' de tipo " + columna.getTipo() + ": " + e.getMessage()
                );
            }
        }
        
        // Si ya es del tipo correcto, devolverlo
        return valor;
    }
    public List<Map<String, Object>> obtenerDatos(String tabla) {
        validarNombreTabla(tabla);
        String sql = String.format("SELECT * FROM %s", tabla);
        return jdbcTemplate.queryForList(sql);
    }
    
    /**
     * Obtiene datos para select con búsqueda mejorada
     */
    public List<Map<String, Object>> obtenerDatosParaSelect(String tabla) {
        validarNombreTabla(tabla);
        
        String columnaPK = obtenerColumnaId(tabla);
        String columnaDescriptiva = obtenerColumnaDescriptiva(tabla, columnaPK);
        
        validarNombreColumna(columnaPK);
        validarNombreColumna(columnaDescriptiva);
        
        String sql = String.format(
            "SELECT %s as id, %s as texto FROM %s ORDER BY %s", 
            columnaPK, columnaDescriptiva, tabla, columnaDescriptiva
        );
        
        return jdbcTemplate.queryForList(sql);
    }
    
    private String obtenerColumnaDescriptiva(String tabla, String columnaPK) {
        validarNombreTabla(tabla);
        validarNombreColumna(columnaPK);
        
        String sql = """
            SELECT column_name
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = ?
              AND column_name != ?
              AND (column_name LIKE '%nombre%' 
                   OR column_name LIKE '%descripcion%'
                   OR column_name LIKE '%desc%'
                   OR column_name LIKE '%tipo%'
                   OR column_name LIKE '%des_%')
            ORDER BY 
                CASE 
                    WHEN column_name LIKE '%nombre%' THEN 1
                    WHEN column_name LIKE '%desc%' THEN 2
                    WHEN column_name LIKE '%des_%' THEN 2
                    ELSE 3
                END,
                ordinal_position
            LIMIT 1
        """;
        
        List<String> resultado = jdbcTemplate.query(sql, 
            new Object[]{tabla, columnaPK}, 
            (rs, rowNum) -> rs.getString("column_name")
        );
        
        return resultado.isEmpty() ? columnaPK : resultado.get(0);
    }
    
    public Map<String, Object> obtenerPorId(String tabla, String columnaId, Object id) {
        validarNombreTabla(tabla);
        validarNombreColumna(columnaId);
        
        String sql = String.format("SELECT * FROM %s WHERE %s = ?", tabla, columnaId);
        List<Map<String, Object>> resultado = jdbcTemplate.queryForList(sql, id);
        return resultado.isEmpty() ? null : resultado.get(0);
    }
    
    public void actualizar(String tabla, String columnaId, Object id, Map<String, Object> datos) {
        validarNombreTabla(tabla);
        validarNombreColumna(columnaId);
        
        if (datos.isEmpty()) {
            throw new IllegalArgumentException("No hay datos para actualizar");
        }
        
        datos.keySet().forEach(this::validarNombreColumna);
        
        String setClause = datos.keySet().stream()
            .map(k -> k + " = ?")
            .collect(Collectors.joining(", "));
        
        String sql = String.format("UPDATE %s SET %s WHERE %s = ?", 
            tabla, setClause, columnaId);
        
        Object[] params = new Object[datos.size() + 1];
        int i = 0;
        for (Object valor : datos.values()) {
            params[i++] = valor;
        }
        params[i] = id;
        
        jdbcTemplate.update(sql, params);
    }
    
    public void eliminar(String tabla, String columnaId, Object id) {
        validarNombreTabla(tabla);
        validarNombreColumna(columnaId);
        
        String sql = String.format("DELETE FROM %s WHERE %s = ?", tabla, columnaId);
        jdbcTemplate.update(sql, id);
    }
    
    public String obtenerColumnaId(String tabla) {
        validarNombreTabla(tabla);
        
        String sql = """
            SELECT column_name
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = ?
              AND column_key = 'PRI'
            LIMIT 1
        """;
        
        List<String> resultado = jdbcTemplate.query(sql, 
            new Object[]{tabla}, 
            (rs, rowNum) -> rs.getString("column_name")
        );
        
        return resultado.isEmpty() ? "id" : resultado.get(0);
    }
}