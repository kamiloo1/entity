using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Actividade
{
    public long IdActividad { get; set; }

    public int? IdCultivo { get; set; }

    public string TipoActividad { get; set; } = null!;

    public string? Descripcion { get; set; }

    public DateOnly FechaActividad { get; set; }

    public string? TrabajadorResponsable { get; set; }

    public string? Estado { get; set; }

    public DateTime FechaCreacion { get; set; }

    public virtual Cultivo? IdCultivoNavigation { get; set; }
}
