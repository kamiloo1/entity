using System;
using System.Collections.Generic;

namespace actividad.Models;

public partial class ObservacionesHuertum
{
    public int Id { get; set; }

    public int HuertaId { get; set; }

    public int? RegistradoPor { get; set; }

    public DateTime? Fecha { get; set; }

    public string? Comentario { get; set; }

    public string? FotosUrl { get; set; }

    public virtual Huerta Huerta { get; set; } = null!;

    public virtual Usuario? RegistradoPorNavigation { get; set; }
}
