using Microsoft.Reporting.WebForms;
using PruebaWeb.Logic;
using System;

namespace PruebaWeb.Web.Pages
{
    public partial class Reporte : System.Web.UI.Page
    {
        private static readonly ClienteService svc = new ClienteService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Se reciben los parámetros del filtro de búsqueda de la pantalla de clientes
                // Se configura el reportviewer (Clientes.rdlc)
                // Se limpia y se llenan los datos del reporte con el resultado de la búsqueda
                var cedula = string.IsNullOrWhiteSpace(Request.QueryString["cedula"]) ? null : Request.QueryString["cedula"];
                var nombre = string.IsNullOrWhiteSpace(Request.QueryString["nombre"]) ? null : Request.QueryString["nombre"];
                var genero = string.IsNullOrWhiteSpace(Request.QueryString["genero"]) ? null : Request.QueryString["genero"];
                var estadocivilid = string.IsNullOrWhiteSpace(Request.QueryString["estadocivilid"]) ? null : Request.QueryString["estadocivilid"];
                var data = svc.Consultar(cedula, nombre, genero, Int32.Parse(estadocivilid));
                rvClientes.LocalReport.ReportPath = Server.MapPath("~/Reportes/Clientes.rdlc");
                rvClientes.LocalReport.DataSources.Clear();
                rvClientes.LocalReport.DataSources.Add(new ReportDataSource("ClientesDataSet", data));
                rvClientes.DataBind();
                rvClientes.LocalReport.Refresh();
            }
        }
    }
}