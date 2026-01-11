using PruebaWeb.Entities;
using PruebaWeb.Repository;
using System.Collections.Generic;

namespace PruebaWeb.Logic
{
    public class EstadoCivilService
    {
        private readonly EstadoCivilRepository repo = new EstadoCivilRepository();

        // Método de consultar todos los estados civiles
        public List<EstadoCivil> Consultar() => repo.ConsultarEstadoCivil();
    }
}
