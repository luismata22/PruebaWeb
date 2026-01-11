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
            // Evita que se ejecute en cada postback y solo lo hace cuando la pagina cargue por primer vez.
            if (!IsPostBack)
            {
                HttpCookie cookie = Request.Cookies["PruebaWebAuth"];
                // Valida si existe alguna cookier, ya sea desde el navegador o guardada en session.
                if (cookie != null && Session["AuthToken"] != null)
                {
                    // Valida que el token de la cookie enviada por el navegador coincida con el de la sesión.
                    if (cookie.Value == Session["AuthToken"].ToString())
                    {
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
                // Generacion de cookie con nombre PruebaWebAuth y un valor GUID Unico, accesibilidad en todas las paginas y se guarda en el navegador y en la sesion del servidor.
                HttpCookie authCookie = new HttpCookie("PruebaWebAuth", Guid.NewGuid().ToString());
                authCookie.Path = "/";
                authCookie.HttpOnly = true;
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