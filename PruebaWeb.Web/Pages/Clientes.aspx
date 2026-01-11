<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="PruebaWeb.Web.Pages.Clientes" %>

<!DOCTYPE html>
<!-- Pagina de clientes -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Clientes</title>
    <link rel="stylesheet" href="~/Content/estilos.css" />
    <link rel="stylesheet" href="~/Content/jquery-ui.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <script src="/Scripts/jquery-3.7.1.min.js"></script>
    <script src="/Scripts/jquery-ui.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <style>
        body {
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="card-clientes">
        <div class="card-clientes2" style="margin-top: 20px; margin-bottom: 20px">
            <div style="text-align:right">
                <button id="btnCerrarSesion" class="ui-button ui-widget ui-corner-all"><i class ="fa fa-right-from-bracket"></i> Cerrar sesión</button>
            </div>
            <div class="topbar">
                <div>
                    <h2><i class="fa fa-user"></i> Clientes</h2>
                </div>
                <div>
                    <button id="btnNuevo" class="ui-button ui-widget ui-corner-all"><i class ="fa fa-plus"></i> Nuevo</button>
                </div>
                
            </div>

            <div>
                <h3><i class="fa fa-filter"></i> Filtros</h3>
            </div>
            <!-- Sección de filtros -->
            <section class="filtros">
                <div class="grid-2">
                    <div>
                        <label>Cédula</label>
                        <input type="text" id="fCedula" class="ui-widget ui-widget-content ui-corner-all" title="Digite parte de la cédula para filtrar" maxlength="8" oninput="this.value=this.value.replace(/[^0-9]/g,'');" />
                    </div>
                    <div>
                        <label>Nombre</label>
                        <input type="text" id="fNombre" class="ui-widget ui-widget-content ui-corner-all" title="Digite parte del nombre para filtrar" />
                    </div>
                    <div>
                        <label>Género</label>
                        <select id="fGenero" title="Seleccione género: M o F" class="ui-widget ui-widget-content ui-corner-all full-width">
                            <option value="">Todos</option>
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                        </select>
                    </div>
                    <div>
                        <label>Estado Civil</label>
                        <select id="fEstadoCivil" title="Estado civil" class="ui-widget ui-widget-content ui-corner-all full-width"></select>
                    </div>
                </div>
                <div class="buttons" style="margin-top: 10px">
                    <button id="btnBuscar" class="ui-button ui-widget ui-corner-all"><i class ="fa fa-search"></i> Buscar</button>
                    <button id="btnLimpiar" class="ui-button ui-widget ui-corner-all"><i class ="fa fa-broom"></i> Limpiar</button>
                </div>
            </section>
            <hr />
            <!-- Sección de formulario para crear y modificar clientes -->
            <section class="formulario" id="formCliente" style="display: none;">
                <h3 id="h3NMC"></h3>
                <input type="hidden" id="id_clie" />
                <div class="grid-2">
                    <div>
                        <label>Cédula</label>
                        <input type="text" id="cedula" title="Número de documento del cliente" class="ui-widget ui-widget-content ui-corner-all" maxlength="8" oninput="this.value=this.value.replace(/[^0-9]/g,'');"/>
                    </div>
                    <div>
                        <label>Nombre</label>
                        <input type="text" id="nombre" title="Nombre del cliente" class="ui-widget ui-widget-content ui-corner-all"/>
                    </div>
                    <div>
                        <label>Género</label>
                        <select id="genero" title="Seleccione género: M o F" class="ui-widget ui-widget-content ui-corner-all full-width">
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                        </select>
                    </div>
                    <div>
                        <label>Fecha Nacimiento</label>
                        <input type="text" id="fecha_nac" title="Seleccione la fecha de nacimiento" autocomplete="off" class="ui-widget ui-widget-content ui-corner-all"/>
                    </div>
                    <div>
                        <label>Estado Civil</label>
                        <select id="estado_civil" title="Estado civil" class="ui-widget ui-widget-content ui-corner-all full-width"></select>
                    </div>
                </div>
                <div><small id="msg"></small></div>
                <div class="buttons">
                    <button id="btnGuardar" class="ui-button ui-widget ui-corner-all"><i class="fa fa-floppy-disk"></i> Guardar</button>
                    <button id="btnCancelar" class="ui-button ui-widget ui-corner-all"><i class="fa fa-xmark"></i> Cancelar</button>
                </div>
                <hr />
            </section>
            <!-- Sección de la tabla de clienes para mostrar los registros mediante filtros -->
            <section class="grid" style="margin-top: 20px">
                <table id="tblClientes">
                    <thead>
                        <tr>
                            <th>Cédula</th>
                            <th>Nombre</th>
                            <th>Género</th>
                            <th>Fecha de nacimiento</th>
                            <th>Estado Civil</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </section>
            <div style="text-align: right; margin-top: 10px">
                <button id="btnVerReporte" class="ui-button ui-widget ui-corner-all"><i class ="fa fa-file"></i> Ver reporte</button>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            // Calendario para la seleccion de fecha
            $('#fecha_nac').datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true, yearRange: "1900:+0" });

            // Tooltip configuracion
            $(document).tooltip({
                position: {
                    my: "left center",
                    at: "right center"
                }
            });

            cargarEstadoCivil();

            buscar();

            $('#btnBuscar').click(buscar);

            $('#btnNuevo').click(function () {
                limpiar();
                $('#h3NMC').text("Nuevo cliente");
                $('#formCliente').show();
            });

            $('#btnCancelar').click(function () {
                $('#formCliente').hide();
            });

            $('#btnGuardar').click(guardar);

            $('#btnVerReporte').click(function () {
                var cedula = $('#fCedula').val();
                var nombre = $('#fNombre').val();
                var genero = $('#fGenero').val();
                var estadocivilid = $('#fEstadoCivil').val();
                window.location = `Reporte.aspx?cedula=${cedula}&nombre=${nombre}&genero=${genero}&estadocivilid=${estadocivilid}`;
            });

            $('#btnCerrarSesion').click(cerrarsesion);

            $('#btnLimpiar').click(limpiarfiltros);

            document.getElementById("fCedula").addEventListener("keydown", function (event) {
                if (event.key === "Enter") {
                    buscar();
                }
            });

            document.getElementById("fNombre").addEventListener("keydown", function (event) {
                if (event.key === "Enter") {
                    buscar();
                }
            });
        });

        // Método para cargar los estados civiles en el select
        function cargarEstadoCivil() {
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/ListarEstadoCivil",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var data = res.d;
                    $('#estado_civil').empty();
                    $('#fEstadoCivil').empty().append('<option value="-1">Todos</option>');;
                    data.forEach(function (e) {
                        $('#estado_civil, #fEstadoCivil').append('<option value="' + e.Id + '">' + e.Nombre + '</option>');
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }

        // Método para buscar los clientes mediante filtros para luegos ser visualizados en la tabla de clientes
        function buscar() {
            var payload = {
                cedula: $('#fCedula').val(),
                nombre: $('#fNombre').val(),
                genero: $('#fGenero').val(),
                estadocivilid: $('#fEstadoCivil').val() == null ? -1 : $('#fEstadoCivil').val()
            };
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/Buscar",
                data: JSON.stringify(payload),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    const rows = res.d;
                    $('#tblClientes').DataTable().destroy();
                    const tb = $('#tblClientes tbody').empty();
                    rows.forEach(r => {
                        tb.append(`
                    <tr>
                        <td>${r.Cedula}</td>
                        <td>${r.Nombre}</td>
                        <td>${r.Genero}</td>
                        <td>${r.FechaNac}</td>
                        <td>${r.EstadoCivil}</td>
                        <td>
                            <button onclick="editar(${r.Id})" class ="ui-button ui-widget ui-corner-all"><i class ="fa fa-pencil"></i></button>
                            <button onclick="eliminar(${r.Id})" class ="ui-button ui-widget ui-corner-all"><i class ="fa fa-trash"></i></button>
                        </td>
                    </tr>`);
                    });
                    
                    $('#tblClientes').DataTable({
                        paging: true,
                        searching: true,
                        ordering: true,
                        pageLength: 10,
                        language: { url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }

        // Método para limpiar los filtros de búsqueda
        function limpiarfiltros() {
            $('#fCedula,#fNombre,#fGenero').val('');
            $('#fEstadoCivil').val('-1');
        }

        // Método para limpiar el formulario de registro
        function limpiar() {
            $('#id_clie').val('-1');
            $('#cedula,#nombre,#fecha_nac').val('');
            $('#genero').val('M');
        }

        // Método para  mostrar en el formulario de registro el cliente a modificar
        function editar(id) {
            var payload = {
                id: id
            };
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/BuscarCliente",
                data: JSON.stringify(payload),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    const cliente = res.d;
                    if (!res.d) return;
                    $('#id_clie').val(cliente.Id);
                    $('#cedula').val(cliente.Cedula);
                    $('#nombre').val(cliente.Nombre);
                    $('#genero').val(cliente.Genero);
                    $('#fecha_nac').val(cliente.FechaNac);
                    $('#estado_civil').val(cliente.EstadoCivilId);
                    $('#h3NMC').text("Editar cliente");
                    $('#formCliente').show();
                },
                error: function (xhr, status, error) {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }

        // Método para eliminar clientes
        function eliminar(id) {
            if (!confirm('¿Desea eliminar el registro?')) return;
            const payload = {
                id: id,
            }
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/Eliminar",
                data: JSON.stringify(payload),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d) {
                        buscar()
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }

        // Método para guardar y editar los clientes
        function guardar() {
            if (Validardatos()) {
                const payload = {
                    id: $('#id_clie').val(),
                    cedula: $('#cedula').val(),
                    nombre: $('#nombre').val(),
                    genero: $('#genero').val(),
                    fecha_nac: $('#fecha_nac').val(),
                    estado_civil: $('#estado_civil').val()
                };
                $.ajax({
                    type: "POST",
                    url: "Clientes.aspx/CrearModificar",
                    data: JSON.stringify(payload),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        if (res.d > 0) {
                            $('#formCliente').hide();
                            buscar();
                        } else if (res.d == -2) {
                            $('#msg').text("La cédula ya se encuentra registrada");
                        } else {
                            $('#msg').text("Ocurrio un error al guardar el cliente");
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error en la llamada:", status, error);
                        console.log(xhr.responseText);
                    }
                });
            }
        }

        // Método para validar que todos los campos del formulario de registros esten completos
        function Validardatos() {
            if ($('#cedula').val() == "" || $('#nombre').val() == "" || $('#fecha_nac').val() == "" || $('#estado_civil').val() == "") {
                var msg = "* Ingrese los datos solicitados (";
                if ($('#cedula').val() == "") {
                    msg = msg + "cédula, ";
                }
                if ($('#nombre').val() == "") {
                    msg = msg + "nombre, ";
                }
                if ($('#fecha_nac').val() == "") {
                    msg = msg + "fecha de nacimiento, ";
                }
                if ($('#estado_civil').val() == "") {
                    msg = msg + "estado civil ";
                }
                msg = msg + ")";
                $('#msg').text(msg);
                return false;
            } else {
                $('#msg').text("");
                return true;
            }

        }

        // Método para cerrar sesión
        function cerrarsesion() {
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/CerrarSesion",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    window.location = 'Login.aspx';
                },
                error: function (xhr, status, error) {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }
    </script>
</body>
</html>
