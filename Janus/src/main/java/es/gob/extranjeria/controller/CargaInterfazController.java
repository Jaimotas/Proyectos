package es.gob.extranjeria.controller;

import java.util.List;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import es.gob.extranjeria.DTO.ColumnaDTO;
import es.gob.extranjeria.DTO.TablaDTO;
import es.gob.extranjeria.service.CargaInterfazService;

@Controller
@RequestMapping("/cargaInterfaz")
public class CargaInterfazController {
    
    private final CargaInterfazService service;
    
    public CargaInterfazController(CargaInterfazService service) {
        this.service = service;
    }
    
    @GetMapping("/opciones/{tabla}")
    @ResponseBody
    public List<Map<String, Object>> obtenerOpcionesParaSelect(@PathVariable String tabla) {
        return service.obtenerOpcionesSelect(tabla);
    }
    @GetMapping
    public String cargarVista(Model model) {
        List<TablaDTO> tablas = service.obtenerTablasDisponibles();
        System.out.println("TABLAS ENCONTRADAS: " + tablas.size());
        model.addAttribute("tablas", tablas);
        return "cargaInterfaz";
    }
    
    @GetMapping("/columnas/{tabla}")
    @ResponseBody
    public List<ColumnaDTO> obtenerColumnas(@PathVariable String tabla) {
        return service.obtenerColumnasTabla(tabla);
    }
    
    
    @PostMapping("/crear/{tabla}")
    @ResponseBody
    public ResponseEntity<String> crearRegistro(
            @PathVariable String tabla, 
            @RequestBody Map<String, Object> datos) {
        try {
            System.out.println("Creando en tabla: " + tabla);
            System.out.println("Datos recibidos: " + datos);
            
            service.insertarRegistro(tabla, datos);
            return ResponseEntity.ok("Registro creado correctamente");
            
        } catch (IllegalArgumentException e) {
            System.err.println("Error de validación: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
            
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            System.err.println("Error de integridad: " + e.getMessage());
            String mensaje = "Error de integridad de datos: ";
            if (e.getMessage().contains("foreign key")) {
                mensaje += "Referencia a clave foránea inválida";
            } else if (e.getMessage().contains("duplicate")) {
                mensaje += "Ya existe un registro con esos datos";
            } else {
                mensaje += e.getMostSpecificCause().getMessage();
            }
            return ResponseEntity.badRequest().body(mensaje);
            
        } catch (Exception e) {
            System.err.println("Error inesperado: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error interno: " + e.getMessage());
        }
    }
    
    @GetMapping("/leer/{tabla}")
    @ResponseBody
    public List<Map<String, Object>> leerRegistros(@PathVariable String tabla) {
        return service.obtenerRegistros(tabla);
    }
}