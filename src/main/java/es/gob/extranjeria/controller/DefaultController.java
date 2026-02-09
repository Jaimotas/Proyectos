package es.gob.extranjeria.controller;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DefaultController {

    @GetMapping("/")
    public String root(Authentication authentication) {

        // No autenticado
        if (authentication == null ||
            authentication instanceof AnonymousAuthenticationToken ||
            !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        // Autenticado
        return "redirect:/home";
    }
}