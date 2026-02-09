package es.gob.extranjeria.DTO;

public class ColumnaDTO {
    private String nombre;
    private String tipo;
    private String columnKey;
    private String extra;
    private String isNullable;
    private String columnDefault;
    private String referencedTable;
    private String referencedColumn;
    
    public ColumnaDTO(String nombre, String tipo) {
        this.nombre = nombre;
        this.tipo = tipo;
    }
    
    // Getters y Setters
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    
    public String getColumnKey() { return columnKey; }
    public void setColumnKey(String columnKey) { this.columnKey = columnKey; }
    
    public String getExtra() { return extra; }
    public void setExtra(String extra) { this.extra = extra; }
    
    public String getIsNullable() { return isNullable; }
    public void setIsNullable(String isNullable) { this.isNullable = isNullable; }
    
    public String getColumnDefault() { return columnDefault; }
    public void setColumnDefault(String columnDefault) { this.columnDefault = columnDefault; }
    
    public String getReferencedTable() { return referencedTable; }
    public void setReferencedTable(String referencedTable) { this.referencedTable = referencedTable; }
    
    public String getReferencedColumn() { return referencedColumn; }
    public void setReferencedColumn(String referencedColumn) { this.referencedColumn = referencedColumn; }
    
    public boolean esAutoIncrement() {
        return extra != null && extra.contains("auto_increment");
    }
    
    public boolean esForaneaKey() {
        return referencedTable != null;
    }
    
    public boolean esNullable() {
        return "YES".equalsIgnoreCase(isNullable);
    }
    
    public boolean esRequerido() {
        return !esNullable() && columnDefault == null && !esAutoIncrement();
    }
}