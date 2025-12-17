using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace actividad.Models;

public partial class Cultivo
{
    public int Id { get; set; }

    [Required]
    [StringLength(150)]
    public string Nombre { get; set; } = null!;

    public string? Descripcion { get; set; }

    [StringLength(100)]
    public string? Tipo { get; set; }

    [StringLength(100)]
    public string? Area { get; set; }

    public string? Estado { get; set; }

    public DateOnly? FechaSiembra { get; set; }

    public DateOnly? FechaCosecha { get; set; }

    public string? Observaciones { get; set; }

    public DateTime FechaCreacion { get; set; }

    public DateTime? FechaActualizacion { get; set; }

    public virtual ICollection<Actividade> Actividades { get; set; } = new List<Actividade>();

    public virtual ICollection<Siembra> Siembras { get; set; } = new List<Siembra>();
}
