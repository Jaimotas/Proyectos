function ejecutarCarga(tipo) {
    const consola = document.getElementById("resultadoCarga");
    consola.textContent = "Ejecutando carga: " + tipo + "...\n\n";

    fetch("/cargaArchivo/ejecutar/" + tipo, {
        method: "POST"
    })
    .then(response => response.text())
    .then(data => {
        consola.textContent += data;
    })
    .catch(error => {
        consola.textContent += "\n[ERROR] " + error;
    });
}
