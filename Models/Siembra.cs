using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace actividad.Models;

public partial class Siembra
{
 public int Id { get; set; }

 [Required]
 public int CultivoId { get; set; }

 public int? FincaId { get; set; }

 public int? TrabajadorId { get; set; }

 [Required]
 public DateOnly FechaSiembra { get; set; }

 [Range(0,999999)]
 public decimal? Area { get; set; }

 public string? Estado { get; set; }

 public string? Observaciones { get; set; }

 public DateTime CreadoEn { get; set; }

 public virtual ICollection<Abono> Abonos { get; set; } = new List<Abono>();

 public virtual Cultivo Cultivo { get; set; } = null!;

 public virtual ICollection<DeteccionesPlaga> DeteccionesPlagas { get; set; } = new List<DeteccionesPlaga>();

 public virtual Finca? Finca { get; set; }

 public virtual ICollection<Poda> Poda { get; set; } = new List<Poda>();

 public virtual ICollection<Riego> Riegos { get; set; } = new List<Riego>();

 public virtual Usuario? Trabajador { get; set; }
}
