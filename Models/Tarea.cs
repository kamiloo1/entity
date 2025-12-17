using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Tarea
{
    public int Id { get; set; }

    public string Titulo { get; set; } = null!;

    public string? Descripcion { get; set; }

    public string? Tipo { get; set; }

    public int? AsignadoA { get; set; }

    public int? AsignadoPor { get; set; }

    public DateTime? FechaInicio { get; set; }

    public DateTime? FechaVencimiento { get; set; }

    public string? Estado { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual Usuario? AsignadoANavigation { get; set; }

    public virtual Usuario? AsignadoPorNavigation { get; set; }
}
