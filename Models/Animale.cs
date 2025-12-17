using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class Animale
{
    public int Id { get; set; }

    public string? CodigoIdentificacion { get; set; }

    public string TipoAnimal { get; set; } = null!;

    public string? Raza { get; set; }

    public DateOnly? FechaNacimiento { get; set; }

    public string? EstadoSalud { get; set; }

    public int? ResponsableId { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual ICollection<HistorialMedico> HistorialMedicos { get; set; } = new List<HistorialMedico>();

    public virtual Usuario? Responsable { get; set; }
}
