using PruebaWeb.Entities;
using PruebaWeb.Repository;
using System.Collections.Generic;
using System.Linq;

namespace PruebaWeb.Logic
{
    public class ClienteService
    {
        private readonly ClienteRepository repo = new ClienteRepository();

        public int CrearModificar(Cliente c)
        {
            var cliente = repo.ConsultarClientes(c.Cedula, "", "", -1);
            if(cliente.Count() == 0)
            {
                return repo.CrearModificarClientes(c);
            }
            else
            {
                if(cliente.FirstOrDefault().Cedula == c.Cedula)
                {
                    return -2;
                }
                else
                {
                    return repo.CrearModificarClientes(c);
                }
            }
        }

        public bool Eliminar(long id) => repo.Eliminar(id);

        public List<Cliente> Consultar(string cedula, string nombre, string genero, int estadocivilid) => repo.ConsultarClientes(cedula, nombre, genero, estadocivilid);

        public Cliente ConsultarClientePorId(long id) => repo.ConsultarClientePorId(id);
    }
}
