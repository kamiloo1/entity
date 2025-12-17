using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Paciente
{
    public long Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string? Especie { get; set; }

    public string? Raza { get; set; }

    public string? Edad { get; set; }

    public string? Estado { get; set; }

    public string? Observaciones { get; set; }

    public DateTime FechaCreacion { get; set; }
}
