using PruebaWeb.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace PruebaWeb.Repository
{
    public class EstadoCivilRepository
    {
        public List<EstadoCivil> ConsultarEstadoCivil()
        {
            var list = new List<EstadoCivil>();
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spConsultarEstadoCivil", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        list.Add(new EstadoCivil
                        {
                            Id = rd.GetInt32(0),
                            Nombre = rd.GetString(1)
                        });
                    }
                }
            }
            return list;
        }
    }
}
