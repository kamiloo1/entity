using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Plaga
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string? Descripcion { get; set; }

    public string? Severidad { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual ICollection<DeteccionesPlaga> DeteccionesPlagas { get; set; } = new List<DeteccionesPlaga>();
}
