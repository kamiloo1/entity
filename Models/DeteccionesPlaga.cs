using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class DeteccionesPlaga
{
    public int Id { get; set; }

    public int? PlagaId { get; set; }

    public int? SiembraId { get; set; }

    public int ReportadoPor { get; set; }

    public DateTime? FechaReporte { get; set; }

    public string? Caracteristicas { get; set; }

    public string? Estado { get; set; }

    public string? ImagenUrl { get; set; }

    public string? AccionesTomadas { get; set; }

    public virtual Plaga? Plaga { get; set; }

    public virtual Usuario ReportadoPorNavigation { get; set; } = null!;

    public virtual Siembra? Siembra { get; set; }
}
