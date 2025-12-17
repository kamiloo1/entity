using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Abono
{
    public int Id { get; set; }

    public int? SiembraId { get; set; }

    public string TipoAbono { get; set; } = null!;

    public decimal? Cantidad { get; set; }

    public DateOnly FechaProgramada { get; set; }

    public DateOnly? FechaAplicacion { get; set; }

    public int? AplicadoPor { get; set; }

    public string? Estado { get; set; }

    public string? Observaciones { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual Usuario? AplicadoPorNavigation { get; set; }

    public virtual Siembra? Siembra { get; set; }
}
