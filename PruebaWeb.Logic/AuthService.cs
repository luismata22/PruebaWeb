namespace PruebaWeb.Logic
{
    public class AuthService
    {
        public bool Login(string user, string pass) => user == "admin" && pass == "1234";
    }
}
