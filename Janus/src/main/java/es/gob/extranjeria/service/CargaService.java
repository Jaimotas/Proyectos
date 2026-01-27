package es.gob.extranjeria.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.springframework.stereotype.Service;

@Service
public class CargaService {

    public String ejecutarScript(String tipo) {
        StringBuilder salida = new StringBuilder();

        try {
            String basePath = System.getProperty("user.dir");

            String python = basePath + "/scripts/venvfp/Scripts/python.exe"; // ruta del entorno virtual
            String script = basePath + "/scripts/LGA_cargaExcel.py"; // ruta del script

            ProcessBuilder pb = new ProcessBuilder(
                    python,
                    script,
                    tipo
            );

            pb.redirectErrorStream(true);
            Process proceso = pb.start();

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(proceso.getInputStream())
            );

            String linea;
            while ((linea = reader.readLine()) != null) {
                salida.append(linea).append("\n");
            }

            proceso.waitFor();

        } catch (Exception e) {
            salida.append("ERROR: ").append(e.getMessage());
        }

        return salida.toString();
    }
}
