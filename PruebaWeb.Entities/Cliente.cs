using System;

namespace PruebaWeb.Entities
{
    // Entidad clientes
    public class Cliente
    {
        public long Id { get; set; }
        public string Cedula { get; set; }
        public string Nombre { get; set; }
        public char Genero { get; set; }
        public string FechaNac { get; set; }
        public int EstadoCivilId { get; set; }
        public string EstadoCivil { get; set; }
    }
}
