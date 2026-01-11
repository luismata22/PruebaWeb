using PruebaWeb.Entities;
using PruebaWeb.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace PruebaWeb.Web.Pages
{
    public partial class Clientes : System.Web.UI.Page
    {
        private static readonly ClienteService svc = new ClienteService();
        private static readonly EstadoCivilService ecServ = new EstadoCivilService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Validación que exita la cookie tanto en el navegador como en la session y si son iguales.
            HttpCookie cookie = Request.Cookies["PruebaWebAuth"];
            if (cookie == null || Session["AuthToken"] == null || cookie.Value != Session["AuthToken"].ToString())
            {
                Response.Redirect("Login.aspx");
            }
        }

        // Método para buscar todos los estados civiles
        [WebMethod]
        public static List<EstadoCivil> ListarEstadoCivil() => ecServ.Consultar();

        // Método buscar clientes mediante filtros (cedula, nombre, genero, estadocivilid)
        [WebMethod]
        public static List<Cliente> Buscar(string cedula, string nombre, string genero, string estadocivilid)
        {
            return svc.Consultar(cedula, nombre, genero, Int32.Parse(estadocivilid));
        }

        // Método para buscar clientes por id
        [WebMethod]
        public static Cliente BuscarCliente(long id)
        {
            return svc.ConsultarClientePorId(id);
        }

        // Método para crear y modificar clientes
        [WebMethod]
        public static int CrearModificar(int id, string cedula, string nombre, string genero, string fecha_nac, string estado_civil)
        {
            var c = new Cliente
            {
                Id = id,
                Cedula = cedula,
                Nombre = nombre,
                Genero = Convert.ToChar(genero),
                FechaNac = DateTime.Parse(fecha_nac.ToString()).ToString("yyyyMMdd"),
                EstadoCivilId = Int32.Parse(estado_civil)
            };
            return svc.CrearModificar(c);
        }

        // Método para eliminar clientes con el id
        [WebMethod]
        public static bool Eliminar(long id)
        {
            return svc.Eliminar(id);
        }

        //Método para cerrar sesión y limpiar la cookie tanto del navegador y de la session del servidor y devolver al login
        [WebMethod]
        public static void CerrarSesion()
        {
            if (HttpContext.Current.Request.Cookies["PruebaWebAuth"] != null)
            {
                HttpCookie authCookie = new HttpCookie("PruebaWebAuth");
                authCookie.Path = "/";
                HttpContext.Current.Response.Cookies.Add(authCookie);
            }
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }
    }
}