using PruebaWeb.Entities;
using PruebaWeb.Repository;
using System.Collections.Generic;

namespace PruebaWeb.Logic
{
    public class ClienteService
    {
        private readonly ClienteRepository repo = new ClienteRepository();

        public int CrearModificar(Cliente c) => repo.CrearModificarClientes(c);

        public void Eliminar(int id) => repo.Eliminar(id);

        public List<Cliente> Consultar(string cedula, string nombre) => repo.ConsultarClientes(cedula, nombre);
    }
}
