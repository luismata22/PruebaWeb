using System.Configuration;
using System.Data.SqlClient;

namespace PruebaWeb.Repository
{
    public static class DBConnection
    {
        public static SqlConnection GetConnection() { return new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString); }
    }
}
