using PruebaWeb.Logic;
using System;

namespace PruebaWeb.Web.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly AuthService auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST" && Request.QueryString["act"] == "login")
            {
                var user = Request.Form["user"];
                var pass = Request.Form["pass"];
                Response.Write(auth.Login(user, pass) ? "OK" : "ERROR");
                Response.End();
            }
        }
    }
}