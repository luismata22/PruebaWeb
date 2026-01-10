<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="PruebaWeb.Web.Pages.Clientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Clientes</title>
    <link rel="stylesheet" href="/Content/estilos.css" />
    <link rel="stylesheet" href="/Content/jquery-ui.css" />
    <script src="/Scripts/jquery-3.7.1.min.js"></script>
    <script src="/Scripts/jquery-ui.min.js"></script>
</head>
<body>
    <div class="topbar">
        <h2>Mantenimiento de Clientes</h2>
        <a href="Reporte.aspx" class="btn">Ver reporte</a>
    </div>

    <div>
        <label>Filtros</label>
    </div>
    <section class="filtros">
        
        <input type="text" id="fCedula" placeholder="Cédula" title="Digite parte de la cédula para filtrar" />
        <input type="text" id="fNombre" placeholder="Nombre" title="Digite parte del nombre para filtrar" />
        <button id="btnBuscar">Buscar</button>
        <button id="btnNuevo">Nuevo</button>
    </section>

    <section class="formulario" id="formCliente" style="display:none;">
        <input type="hidden" id="id_clie" />
        <div class="row">
            <label>Cédula</label>
            <input type="text" id="cedula" title="Número de documento del cliente" />
        </div>
        <div class="row">
            <label>Nombre</label>
            <input type="text" id="nombre" title="Nombre del cliente" />
        </div>
        <div class="row">
            <label>Género</label>
            <select id="genero" title="Seleccione género: M o F">
                <option value="M">Masculino</option>
                <option value="F">Femenino</option>
            </select>
        </div>
        <div class="row">
            <label>Fecha Nacimiento</label>
            <input type="text" id="fecha_nac" title="Seleccione la fecha de nacimiento" />
        </div>
        <div class="row">
            <label>Estado Civil</label>
            <select id="estado_civil" title="Estado civil"></select>
        </div>
        <div class="actions">
            <button id="btnGuardar">Guardar</button>
            <button id="btnCancelar">Cancelar</button>
        </div>
    </section>

    <section class="grid">
        <table id="tblClientes">
            <thead>
                <tr>
                    <th>ID</th><th>Cédula</th><th>Nombre</th><th>Género</th><th>Fecha Nac.</th><th>Estado Civil</th><th>Acciones</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </section>

    <script>
        $(function () {
            // datepicker
            $('#fecha_nac').datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true, yearRange: "1900:+0" });

            // tooltips
            $(document).tooltip();

            // auth cookie check (lado cliente complementa el check en code-behind)
            if (!document.cookie.includes('PruebaWebAuth=1')) {
                window.location = 'Login.aspx';
                return;
            }

            cargarEstadoCivil();
            buscar();

            $('#btnBuscar').click(buscar);
            $('#btnNuevo').click(function(){ limpiar(); $('#formCliente').show(); });
            $('#btnCancelar').click(function(){ $('#formCliente').hide(); });
            $('#btnGuardar').click(guardar);
        });

        function cargarEstadoCivil() 
        { 
            $.ajax({ 
                type: "POST", 
                url: "Clientes.aspx/ListarEstadoCivil", 
                data: "{}", // aunque no envíes parámetros, debe ser JSON 
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res)
                {
                    var data = res.d;
                    $('#estado_civil').empty().append('<option value="">Todos</option>');
                    data.forEach(function (e)
                    {
                        $('#estado_civil').append('<option value="' + e.Id + '">' + e.Nombre + '</option>');
                    });
                },
                error: function (xhr, status, error)
                {
                    console.error("Error en la llamada:", status, error);
                    console.log(xhr.responseText);
                }
            });
        }

        function buscar() {
            $.get('Clientes.aspx?act=buscar', {
                cedula: $('#fCedula').val(),
                nombre: $('#fNombre').val()
            }, function (data) {
                const rows = JSON.parse(data);
                const tb = $('#tblClientes tbody').empty();
                rows.forEach(r => {
                    tb.append(`
                    <tr>
                        <td>${r.Id}</td>
                        <td>${r.Cedula}</td>
                        <td>${r.Nombre}</td>
                        <td>${r.Genero}</td>
                        <td>${r.FechaNac.substring(0,10)}</td>
                        <td>${r.EstadoCivilDesc}</td>
                        <td>
                            <button onclick="editar(${r.Id})">Editar</button>
                            <button onclick="eliminar(${r.Id})">Eliminar</button>
                        </td>
                    </tr>`);
                });
            });
        }

        function limpiar(){
            $('#id_clie').val('');
            $('#cedula,#nombre,#fecha_nac').val('');
            $('#genero').val('M');
        }

        function editar(id){
            // Reutilizamos búsqueda y filtramos en cliente por ID para demo
            $.get('Clientes.aspx?act=buscar', { cedula: '', nombre: '' }, function(data){
                const rows = JSON.parse(data);
                const r = rows.find(x => x.Id === id);
                if (!r) return;
                $('#id_clie').val(r.Id);
                $('#cedula').val(r.Cedula);
                $('#nombre').val(r.Nombre);
                $('#genero').val(r.Genero);
                $('#fecha_nac').val(r.FechaNac.substring(0,10));
                $('#estado_civil').val(r.EstadoCivilId);
                $('#formCliente').show();
            });
        }

        function eliminar(id){
            if(!confirm('¿Eliminar registro?')) return;
            $.post('Clientes.aspx?act=eliminar', { id: id }, function(){
                buscar();
            });
        }

        function guardar(){
            const payload = {
                id: $('#id_clie').val(),
                cedula: $('#cedula').val(),
                nombre: $('#nombre').val(),
                genero: $('#genero').val(),
                fecha_nac: $('#fecha_nac').val(),
                estado_civil: $('#estado_civil').val()
            };
            const act = payload.id ? 'editar' : 'crear';
            $.post('Clientes.aspx?act=' + act, payload, function(){
                $('#formCliente').hide();
                buscar();
            });
        }
    </script>
</body>
</html>
