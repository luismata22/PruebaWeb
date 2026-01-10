using PruebaWeb.Entities;
using PruebaWeb.Repository;
using System.Collections.Generic;

namespace PruebaWeb.Logic
{
    public class EstadoCivilService
    {
        private readonly EstadoCivilRepository repo = new EstadoCivilRepository();

        public List<EstadoCivil> Consultar() => repo.ConsultarEstadoCivil();
    }
}
