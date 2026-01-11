using System.Configuration;
using System.Data.SqlClient;

namespace PruebaWeb.Repository
{
    public static class DBConnection
    {
        // Método para obtener la conexión a la base de datos mediante el connectionStrings configurado en el Web.config
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString);
        }
    }
}
