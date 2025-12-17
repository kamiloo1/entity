using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace actividad.Models;

public partial class Usuario
{
    public int Id { get; set; }

    [StringLength(120)]
    public string? Nombre { get; set; }

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Correo { get; set; } = null!;

    [StringLength(30)]
    public string? Telefono { get; set; }

    [StringLength(50)]
    public string? NumeroDocumento { get; set; }

    [Required]
    [StringLength(255, MinimumLength = 6)]
    public string Password { get; set; } = null!;

    public int? RoleId { get; set; }

    public bool? Activo { get; set; }

    public DateTime FechaCreacion { get; set; }

    public DateTime? UltimoLogin { get; set; }

    public virtual ICollection<Abono> Abonos { get; set; } = new List<Abono>();

    public virtual ICollection<Animale> Animales { get; set; } = new List<Animale>();

    public virtual ICollection<DeteccionesPlaga> DeteccionesPlagas { get; set; } = new List<DeteccionesPlaga>();

    public virtual ICollection<HistorialMedico> HistorialMedicos { get; set; } = new List<HistorialMedico>();

    public virtual ICollection<Huerta> Huerta { get; set; } = new List<Huerta>();

    public virtual ICollection<ObservacionesHuertum> ObservacionesHuerta { get; set; } = new List<ObservacionesHuertum>();

    public virtual ICollection<Poda> Poda { get; set; } = new List<Poda>();

    public virtual ICollection<Riego> Riegos { get; set; } = new List<Riego>();

    public virtual Role? Role { get; set; }

    public virtual ICollection<Siembra> Siembras { get; set; } = new List<Siembra>();

    public virtual ICollection<Tarea> TareaAsignadoANavigations { get; set; } = new List<Tarea>();

    public virtual ICollection<Tarea> TareaAsignadoPorNavigations { get; set; } = new List<Tarea>();
}
