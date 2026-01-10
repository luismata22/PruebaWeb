using PruebaWeb.Entities;
using PruebaWeb.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace PruebaWeb.Web.Pages
{
    public partial class Clientes : System.Web.UI.Page
    {
        private readonly ClienteService svc = new ClienteService();
        private readonly EstadoCivilService ecRepo = new EstadoCivilService();
        private readonly JavaScriptSerializer json = new JavaScriptSerializer();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check cookie de sesión 
            var authCookie = Request.Cookies["PruebaWebAuth"];
            if (authCookie == null && Request.QueryString["act"] == null)
            {
                Response.Redirect("Login.aspx"); return;
            }
            var act = Request.QueryString["act"];
            if (act == "buscar")
            {
                Buscar();
            }
            else if (act == "crearmodificar")
            {
                CrearModificar();
            }
            else if (act == "eliminar")
            {
                Eliminar();
            }
        }

        [WebMethod]
        public static List<EstadoCivil> ListarEstadoCivil() => new EstadoCivilService().Consultar();

        void Buscar()
        {
            var cedula = Request.QueryString["cedula"];
            var nombre = Request.QueryString["nombre"];
            var list = svc.Consultar(string.IsNullOrWhiteSpace(cedula) ? null : cedula, string.IsNullOrWhiteSpace(nombre) ? null : nombre);
            Response.ContentType = "application/json";
            // Map a objeto anónimo compatible con front 
            var payload = list.Select(c => new { c.Id, c.Cedula, c.Nombre, c.Genero, FechaNac = c.FechaNac.ToString("yyyy-MM-dd"), c.EstadoCivilId, c.EstadoCivil }).ToList();
            Response.Write(json.Serialize(payload));
            Response.End();
        }

        void CrearModificar()
        {
            var c = BindClienteFromForm();
            var id = svc.CrearModificar(c);
            Response.Write("OK:" + id);
            Response.End();
        }
        
        void Eliminar()
        {
            var id = int.Parse(Request.Form["id"]);
            svc.Eliminar(id);
            Response.Write("OK");
            Response.End();
        }

        Cliente BindClienteFromForm()
        {
            return new Cliente
            {
                Cedula = Request.Form["cedula"],
                Nombre = Request.Form["nombre"],
                Genero = Request.Form["genero"][0],
                FechaNac = DateTime.Parse(Request.Form["fecha_nac"]),
                EstadoCivilId = int.Parse(Request.Form["estado_civil"])
            };
        }

    }
}