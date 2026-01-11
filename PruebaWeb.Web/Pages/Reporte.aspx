<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reporte.aspx.cs" Inherits="PruebaWeb.Web.Pages.Reporte" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte de Clientes</title>
    <link rel="stylesheet" href="~/Content/estilos.css" />
    <link rel="stylesheet" href="~/Content/jquery-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <script src="/Scripts/jquery-3.7.1.min.js"></script>
    <script src="/Scripts/jquery-ui.min.js"></script>
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
    <div>
            <div class="topbar">
                <h2>Reporte</h2>
                <div style="margin-bottom: 10px">
                    <button id="btnRegresar" class="ui-button ui-widget ui-corner-all"><i class="fa fa-arrow-left"></i> Regresar</button>
                </div>
            </div>

            <form runat="server" style="width: 1000px">
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <rsweb:ReportViewer ID="rvClientes" runat="server" Width="100%" Height="600px" ProcessingMode="Local" />
            </form>
    </div>
    <script>
        $(function () {
            $('#btnRegresar').click(function () {
                window.location = `Clientes.aspx?`;
            });
        })
    </script>
</body>
</html>
