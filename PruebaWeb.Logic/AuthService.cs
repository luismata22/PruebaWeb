using System.Security.Cryptography;
using System.Text;

namespace PruebaWeb.Logic
{
    public class AuthService
    {
        // Método de login con datos por defecto (Admin, 1234)
        public bool Login(string user, string pass)
        {
            pass = HashPassword(pass + "Prueba-web-SS");
            return user == "admin" && pass == "5a1a90c273379a3483b1dc287dc5cd51da7afbdb300bc5785a5fc4e77ebea372";
        }

        // Método de encriptación con SHA256
        private string HashPassword(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
