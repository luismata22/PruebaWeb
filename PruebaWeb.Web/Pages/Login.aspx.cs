using PruebaWeb.Logic;
using System;
using System.Web;
using System.Web.Services;

namespace PruebaWeb.Web.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        private static readonly AuthService auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Evita que se ejecute en cada postback 
            if (!IsPostBack)
            {
                HttpCookie cookie = Request.Cookies["PruebaWebAuth"];
                if (cookie != null && Session["AuthToken"] != null)
                {
                    // Validar que el token de la cookie coincida con el de la sesión 
                    if (cookie.Value == Session["AuthToken"].ToString())
                    { // Ya hay sesión activa → redirigir 
                        Response.Redirect("Clientes.aspx");
                    }
                }
            }
        }


        [WebMethod]
        public static bool IniciarSesion(string usuario, string password)
        {
            if(auth.Login(usuario, password))
            {
                HttpCookie authCookie = new HttpCookie("PruebaWebAuth", Guid.NewGuid().ToString());
                authCookie.Path = "/";
                authCookie.HttpOnly = true; // más seguro 
                HttpContext.Current.Response.Cookies.Add(authCookie);

                HttpContext.Current.Session["AuthToken"] = authCookie.Value;
                return true;
            }else
            {
                return false;
            }
        }
    }
}