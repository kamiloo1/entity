using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace actividad.Models;

public partial class Huerta
{
    public int Id { get; set; }

    [Required]
    [StringLength(150)]
    public string Nombre { get; set; } = null!;

    [StringLength(255)]
    public string? Ubicacion { get; set; }

    public int? ResponsableId { get; set; }

    public string? Descripcion { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual ICollection<ObservacionesHuertum> ObservacionesHuerta { get; set; } = new List<ObservacionesHuertum>();

    public virtual Usuario? Responsable { get; set; }
}
