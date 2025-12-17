using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace actividad.Models;

public partial class Role
{
    public int Id { get; set; }

    [Required]
    [StringLength(50)]
    public string Nombre { get; set; } = null!;

    [StringLength(255)]
    public string? Descripcion { get; set; }

    public DateTime CreadoEn { get; set; }

    public virtual ICollection<Usuario> Usuarios { get; set; } = new List<Usuario>();
}
