document.addEventListener("DOMContentLoaded", function () {
    const tablaSelect = document.getElementById("tablaSelect");
    const opcionesCrud = document.getElementById("opcionesCrud");
    const zonaTrabajo = document.getElementById("zonaTrabajo");

    tablaSelect.addEventListener("change", function () {
        zonaTrabajo.innerHTML = "";
        if (this.value) {
            opcionesCrud.style.display = "flex";
        } else {
            opcionesCrud.style.display = "none";
        }
    });
});

function accionCrud(accion) {
    const tabla = document.getElementById("tablaSelect").value;
    const zona = document.getElementById("zonaTrabajo");

    if (!tabla) {
        alert("Selecciona una tabla primero");
        return;
    }

    zona.innerHTML = `
        <div class="mt-4">
            <h3>${accion} sobre tabla <strong>${tabla}</strong></h3>
        </div>
    `;

    if (accion === 'CREATE') {
        cargarFormularioCrear(tabla);
    } else if (accion === 'READ') {
        cargarDatosTabla(tabla);
    } else if (accion === 'UPDATE') {
        alert("UPDATE pendiente de implementar");
    } else if (accion === 'DELETE') {
        alert("DELETE pendiente de implementar");
    }
}

function cargarFormularioCrear(tabla) {
    fetch(`/cargaInterfaz/columnas/${tabla}`)
        .then(response => {
            if (!response.ok) throw new Error('Error al cargar columnas');
            return response.json();
        })
        .then(columnas => pintarFormularioCrear(tabla, columnas))
        .catch(error => {
            console.error('Error:', error);
            alert("Error cargando columnas");
        });
}

async function pintarFormularioCrear(tabla, columnas) {
    const zona = document.getElementById("zonaTrabajo");
    const tablasConIdManual = ['lga_modelos', 'lga_permisos', 'lga_vias'];

    let html = `
        <div class="card mt-4">
            <div class="card-body">
                <h4>Crear registro en ${tabla}</h4>
                <form id="formCrear">
                    <div class="form-row">
    `;

    for (const col of columnas) {
        const nombreLower = col.nombre.toLowerCase();
        const esRequerido = col.isNullable === 'NO' && !col.extra?.includes('auto_increment');
        const requiredAttr = esRequerido ? 'required' : '';
        const asterisco = esRequerido ? ' <span class="text-danger">*</span>' : '';
        
        // Saltar auto-increment
        if (col.extra && col.extra.includes("auto_increment")) {
            continue;
        }
        
        // ⚠️ SI ES FK, crear Select2
        if (col.referencedTable) {
            try {
                const opciones = await fetch(`/cargaInterfaz/opciones/${col.referencedTable}`)
                    .then(res => res.json());
                
                html += `
                    <div class="col-md-6 form-group">
                        <label>${col.nombre}${asterisco}</label>
                        <select class="form-control select2-fk" 
                                name="${col.nombre}" 
                                ${requiredAttr}
                                data-placeholder="Buscar ${col.referencedTable}...">
                            ${!esRequerido ? '<option value="">-- Ninguno --</option>' : '<option value="">-- Selecciona --</option>'}
                `;
                
                opciones.forEach(opt => {
                    html += `<option value="${opt.id}">${opt.id} - ${opt.texto}</option>`;
                });
                
                html += `
                        </select>
                        <small class="form-text text-muted">FK → ${col.referencedTable}</small>
                    </div>
                `;
            } catch (error) {
                console.error(`Error cargando opciones para ${col.referencedTable}:`, error);
                html += crearInputNormal(col, false, esRequerido);
            }
        } 
        
        // Campo normal
        else {
            html += crearInputNormal(col, false, esRequerido);
        }
    }

    html += `
                    </div>
                    <div class="mt-3">
                        <button type="button" class="btn btn-success" onclick="enviarCrear('${tabla}')">
                            Guardar
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="accionCrud('READ')">
                            Cancelar
                        </button>
                    </div>
                    <small class="form-text text-muted mt-2">
                        <span class="text-danger">*</span> Campos obligatorios
                    </small>
                </form>
            </div>
        </div>
    `;

    zona.innerHTML = html;
    
    // ⚠️ Inicializar Select2 en todos los selects FK
    setTimeout(() => {
        $('.select2-fk').select2({
            theme: 'bootstrap-5',
            width: '100%',
            language: 'es',
            allowClear: true
        });
    }, 100);
}

function crearInputNormal(col, esIdManual, esRequerido) {
    const tipoLower = col.tipo.toLowerCase();
    const requiredAttr = esRequerido ? 'required' : '';
    const asterisco = esRequerido ? ' <span class="text-danger">*</span>' : '';
    let inputType = 'text';
    let extraAttrs = '';
    
    if (tipoLower.includes('int') || tipoLower.includes('decimal') || tipoLower.includes('float')) {
        inputType = 'number';
        if (tipoLower.includes('decimal') || tipoLower.includes('float')) {
            extraAttrs = 'step="0.01"';
        }
    } else if (tipoLower.includes('date')) {
        inputType = 'date';
    } else if (tipoLower.includes('time')) {
        inputType = 'time';
    } else if (tipoLower.includes('text') || tipoLower.includes('blob')) {
        return `
            <div class="col-md-12 form-group">
                <label>${col.nombre}${asterisco}</label>
                <textarea class="form-control" 
                          name="${col.nombre}" 
                          rows="3"
                          ${requiredAttr}
                          placeholder="${col.tipo}${!esRequerido ? ' (opcional)' : ''}"></textarea>
            </div>
        `;
    }
    
    return `
        <div class="col-md-6 form-group">
            <label>${col.nombre}${asterisco}</label>
            <input class="form-control" 
                   name="${col.nombre}" 
                   type="${inputType}"
                   ${extraAttrs}
                   ${requiredAttr}
                   placeholder="${col.tipo}${!esRequerido ? ' (opcional)' : ''}">
        </div>
    `;
}

function enviarCrear(tabla) {
    const form = document.getElementById("formCrear");
    
    // Validar formulario HTML5
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    const datos = {};

    // Recoger TODOS los campos del formulario
    const formData = new FormData(form);
    
    formData.forEach((value, key) => {
        // Incluir todos los campos, el backend decidirá qué hacer
        // Si está vacío, enviamos string vacío y el backend lo convertirá a null si procede
        datos[key] = value;
    });

    console.log('Datos a enviar:', datos);

    // Deshabilitar botón de envío
    const btnGuardar = form.querySelector('button[onclick*="enviarCrear"]');
    if (btnGuardar) {
        btnGuardar.disabled = true;
        btnGuardar.innerHTML = 'Guardando...';
    }

    fetch(`/cargaInterfaz/crear/${tabla}`, {
        method: "POST",
        headers: { 
            "Content-Type": "application/json"
        },
        body: JSON.stringify(datos)
    })
    .then(response => {
        console.log('Status:', response.status);
        return response.text().then(text => {
            if (response.ok) {
                return text;
            } else {
                throw new Error(text || 'Error desconocido');
            }
        });
    })
    .then(mensaje => {
        console.log('Éxito:', mensaje);
        alert(mensaje);
        form.reset();
        $('.select2-fk').val(null).trigger('change');
        cargarDatosTabla(tabla);
    })
    .catch(error => {
        console.error('Error completo:', error);
        alert("Error al crear el registro:\n\n" + error.message);
    })
    .finally(() => {
        // Rehabilitar botón
        if (btnGuardar) {
            btnGuardar.disabled = false;
            btnGuardar.innerHTML = 'Guardar';
        }
    });
}

function cargarDatosTabla(tabla) {
    const zona = document.getElementById("zonaTrabajo");
    zona.innerHTML = `<div class="text-center"><p>Cargando datos de ${tabla}...</p></div>`;

    fetch(`/cargaInterfaz/leer/${tabla}`)
        .then(response => {
            if (!response.ok) throw new Error('Error al cargar datos');
            return response.json();
        })
        .then(datos => {
            if (!datos || datos.length === 0) {
                zona.innerHTML = "<div class='alert alert-info'>No hay registros para mostrar</div>";
                return;
            }

            let html = `<div class="table-responsive mt-3">
                <table class="table table-bordered table-striped table-hover">
                    <thead class="thead-dark"><tr>`;

            Object.keys(datos[0]).forEach(col => {
                html += `<th>${col}</th>`;
            });

            html += `</tr></thead><tbody>`;

            datos.forEach(fila => {
                html += `<tr>`;
                Object.values(fila).forEach(valor => {
                    if (valor === null || valor === '') {
                        html += `<td class="text-muted"><em>NULL</em></td>`;
                    } else {
                        html += `<td>${valor}</td>`;
                    }
                });
                html += `</tr>`;
            });

            html += `</tbody></table></div>`;
            zona.innerHTML = html;
        })
        .catch(error => {
            console.error('Error:', error);
            zona.innerHTML = `<div class="alert alert-danger">Error cargando datos: ${error.message}</div>`;
        });
}
