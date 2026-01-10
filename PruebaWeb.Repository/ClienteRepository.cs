using PruebaWeb.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace PruebaWeb.Repository
{
    public class ClienteRepository
    {
        public int CrearModificarClientes(Cliente c)
        {
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spInsertarModificarSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_clie", c.Id);
                cmd.Parameters.AddWithValue("@cedula", c.Cedula);
                cmd.Parameters.AddWithValue("@nombre", c.Nombre);
                cmd.Parameters.AddWithValue("@genero", c.Genero);
                cmd.Parameters.AddWithValue("@fecha_nac", c.FechaNac);
                cmd.Parameters.AddWithValue("@estado_civil", c.EstadoCivilId);
                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public void Eliminar(int id)
        {
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spEliminarSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_clie", id);
                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public List<Cliente> ConsultarClientes(string cedula, string nombre)
        {
            var list = new List<Cliente>();
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spConsultarSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cedula", cedula);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cn.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        list.Add(new Cliente
                        {
                            Id = rd.GetInt64(rd.GetOrdinal("id_clie")),
                            Cedula = rd.GetString(rd.GetOrdinal("cedula")),
                            Nombre = rd.GetString(rd.GetOrdinal("nombre")),
                            Genero = rd.GetString(rd.GetOrdinal("genero"))[0],
                            FechaNac = rd.GetDateTime(rd.GetOrdinal("fecha_nac")),
                            EstadoCivilId = rd.GetInt32(rd.GetOrdinal("id_estado_civil")),
                            EstadoCivil = rd.GetString(rd.GetOrdinal("estado_civil"))
                        });
                    }
                }
            }
            return list;
        }
    }
}
