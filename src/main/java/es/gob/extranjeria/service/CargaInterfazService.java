package es.gob.extranjeria.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import es.gob.extranjeria.DTO.ColumnaDTO;
import es.gob.extranjeria.DTO.TablaDTO;
import es.gob.extranjeria.repository.GenericCrudRepository;

@Service
public class CargaInterfazService {
    
    private final GenericCrudRepository repository;
    
    public CargaInterfazService(GenericCrudRepository repository) {
        this.repository = repository;
    }
    
    public List<TablaDTO> obtenerTablasDisponibles() {
        return repository.obtenerTablas();
    }
    
    public List<ColumnaDTO> obtenerColumnasTabla(String tabla) {
        return repository.obtenerColumnas(tabla);
    }
    
    public void insertarRegistro(String tabla, Map<String, Object> datos) {
        repository.insertar(tabla, datos);
    }
    
    // ⚠️ AÑADIR: Método para leer registros
    public List<Map<String, Object>> obtenerRegistros(String tabla) {
        return repository.obtenerDatos(tabla);
    }
    public List<Map<String, Object>> obtenerOpcionesSelect(String tabla) {
        return repository.obtenerDatosParaSelect(tabla);
    }
}