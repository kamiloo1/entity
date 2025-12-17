using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class HistorialMedico
{
    public int Id { get; set; }

    public int AnimalId { get; set; }

    public DateTime? Fecha { get; set; }

    public int? VeterinarioId { get; set; }

    public string? Descripcion { get; set; }

    public string? Tratamiento { get; set; }

    public bool? Vacunado { get; set; }

    public string? Dosis { get; set; }

    public DateOnly? ProximaVisita { get; set; }

    public virtual Animale Animal { get; set; } = null!;

    public virtual Usuario? Veterinario { get; set; }
}
