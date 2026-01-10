<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PruebaWeb.Web.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" href="/Content/estilos.css" />
    <script src="/Scripts/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="card">
        <div>
            <h2>Inicio de sesión</h2>
        </div>
        <form id="frmLogin">
            <div>
                <label>Usuario</label>
                <input type="text" id="txtUser" title="Ingrese su usuario" />
            </div>
            <div>
                <label>Contraseña</label>
                <input type="password" id="txtPass" title="Ingrese su contraseña" />
            </div>
            <div>
                <button type="button" id="btnLogin">Entrar</button>
            </div>
            <div id="msg"></div>
        </form>
    </div>

    <script>
        $('#btnLogin').on('click', function () {
            $.post('Login.aspx?act=login', {
                user: $('#txtUser').val(),
                pass: $('#txtPass').val()
            }).done(function (ok) {
                if (ok === 'OK') {
                    document.cookie = 'PruebaWebAuth=1;path=/';
                    window.location = 'Clientes.aspx';
                } else {
                    $('#msg').text('Credenciales inválidas');
                }
            });
        });
    </script>
</body>
</html>
