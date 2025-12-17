using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Tratamiento
{
    public long IdTratamiento { get; set; }

    public long? IdGanado { get; set; }

    public string TipoTratamiento { get; set; } = null!;

    public DateOnly FechaTratamiento { get; set; }

    public string? Observaciones { get; set; }

    public string? VeterinarioResponsable { get; set; }

    public decimal? Costo { get; set; }

    public DateTime FechaCreacion { get; set; }

    public virtual Ganado? IdGanadoNavigation { get; set; }
}
