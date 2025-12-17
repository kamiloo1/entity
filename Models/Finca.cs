using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Finca
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string? Ubicacion { get; set; }

    public string? Descripcion { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual ICollection<Siembra> Siembras { get; set; } = new List<Siembra>();
}
