using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Riego
{
    public int Id { get; set; }

    public int? SiembraId { get; set; }

    public DateOnly FechaProgramada { get; set; }

    public DateOnly? FechaRealizada { get; set; }

    public decimal? CantidadAguaLitros { get; set; }

    public int? RealizadoPor { get; set; }

    public string? Estado { get; set; }

    public string? Observaciones { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual Usuario? RealizadoPorNavigation { get; set; }

    public virtual Siembra? Siembra { get; set; }
}
