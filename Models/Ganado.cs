using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Ganado
{
    public long IdGanado { get; set; }

    public string Tipo { get; set; } = null!;

    public string? Raza { get; set; }

    public int? Edad { get; set; }

    public decimal? Peso { get; set; }

    public string? EstadoSalud { get; set; }

    public DateOnly? FechaNacimiento { get; set; }

    public DateTime FechaCreacion { get; set; }

    public bool? Activo { get; set; }

    public virtual ICollection<Tratamiento> Tratamientos { get; set; } = new List<Tratamiento>();
}
