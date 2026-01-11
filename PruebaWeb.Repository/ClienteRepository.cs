using PruebaWeb.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

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
                cmd.Parameters.AddWithValue("@id_estado_civil", c.EstadoCivilId);
                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public bool Eliminar(long id)
        {
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spEliminarSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_clie", id);
                cn.Open();
                cmd.ExecuteNonQuery();
                return true;
            }
        }

        public List<Cliente> ConsultarClientes(string cedula, string nombre, string genero, int estadocivilid)
        {
            var list = new List<Cliente>();
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spConsultarSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cedula", cedula);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@genero", genero);
                cmd.Parameters.AddWithValue("@idestadocivil", estadocivilid);
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
                            FechaNac = rd.GetDateTime(rd.GetOrdinal("fecha_nac")).ToString("dd/MM/yyyy"),
                            EstadoCivilId = rd.GetInt32(rd.GetOrdinal("id_estado_civil")),
                            EstadoCivil = rd.GetString(rd.GetOrdinal("estado_civil"))
                        });
                    }
                }
            }
            return list;
        }

        public Cliente ConsultarClientePorId(long id)
        {
            var list = new List<Cliente>();
            using (var cn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand("spConsultarClienteSEVECLIE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_clie", id);
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
                            FechaNac = rd.GetDateTime(rd.GetOrdinal("fecha_nac")).ToString("dd/MM/yyyy"),
                            EstadoCivilId = rd.GetInt32(rd.GetOrdinal("id_estado_civil")),
                            EstadoCivil = rd.GetString(rd.GetOrdinal("estado_civil"))
                        });
                    }
                }
            }
            return list.FirstOrDefault();
        }
    }
}
