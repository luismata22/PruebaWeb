<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PruebaWeb.Web.Pages.Login" %>

<!DOCTYPE html>
<!-- Pagina inicial de login -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inicio de sesión</title>
    <link href="~/Content/estilos.css" rel="stylesheet" />
    <link rel="stylesheet" href="~/Content/jquery-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
    <script src="/Scripts/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
</head>
<body>
    <div class="card">
        <div class="box-login">
            <h2 class="aling-center">Inicio de sesión</h2>
            <form id="frmLogin">
                <div>
                    <label>Usuario</label>
                    <input type="text" id="txtUser" title="Ingrese su usuario" class="ui-widget ui-widget-content ui-corner-all" />
                </div>
                <div style="margin-top: 10px">
                    <label>Contraseña</label>
                    <input type="password" id="txtPass" title="Ingrese su contraseña" class="ui-widget ui-widget-content ui-corner-all" />
                </div>
                <div><small id="msg"></small></div>
                <div style="margin-top: 10px">
                    <button type="button" id="btnLogin" class="full-width ui-button ui-widget ui-corner-all"><i class="fa fa-right-to-bracket"></i>Entrar</button>
                </div>

            </form>
        </div>
    </div>

    <script>
        document.getElementById("txtUser").addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                IniciarSesion();
            }
        });

        document.getElementById("txtPass").addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                IniciarSesion();
            }
        });

        // Click de btnLogin para iniciar sesion dentro del aplicativo
        $('#btnLogin').on('click', function () {
            IniciarSesion();
        });

        function IniciarSesion() {
            if ($('#txtUser').val() != "" && $('#txtPass').val() != "") {
                var pass = $('#txtPass').val();
                var payload = {
                    usuario: $('#txtUser').val(),
                    password: CryptoJS.SHA256(pass).toString()
                };
                $.ajax({
                    type: "POST",
                    url: "Login.aspx/IniciarSesion",
                    data: JSON.stringify(payload),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        var result = res.d;
                        if (result === true) {
                            window.location = 'Clientes.aspx';
                        } else {
                            $('#msg').text('Credenciales inválidas');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error en la llamada:", status, error);
                        console.log(xhr.responseText);
                    }
                });
            } else {
                $('#msg').text('Ingrese las credenciales');
            }
        }
    </script>
</body>
</html>
