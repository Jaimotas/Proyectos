package es.gob.extranjeria.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import es.gob.extranjeria.service.CargaService;

@Controller
@RequestMapping("/carga")
public class CargaController {

    @Autowired
    private CargaService cargaService;

    @GetMapping
    public String vistaCarga() {
        return "carga";
    }

    @PostMapping("/ejecutar/{tipo}")
    @ResponseBody
    public String ejecutar(@PathVariable String tipo) {
        return cargaService.ejecutarScript(tipo);
    }
}
