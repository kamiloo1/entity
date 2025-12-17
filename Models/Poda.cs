using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Poda
{
    public int Id { get; set; }

    public int? SiembraId { get; set; }

    public string TipoPoda { get; set; } = null!;

    public DateOnly FechaProgramada { get; set; }

    public DateOnly? FechaRealizada { get; set; }

    public int? RealizadaPor { get; set; }

    public string? Estado { get; set; }

    public string? Observaciones { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual Usuario? RealizadaPorNavigation { get; set; }

    public virtual Siembra? Siembra { get; set; }
}
