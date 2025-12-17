using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace actividad.Models;

public partial class AgrosftContext : DbContext
{
    public AgrosftContext()
    {
    }

    public AgrosftContext(DbContextOptions<AgrosftContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Abono> Abonos { get; set; }

    public virtual DbSet<Actividade> Actividades { get; set; }

    public virtual DbSet<Animale> Animales { get; set; }

    public virtual DbSet<Cultivo> Cultivos { get; set; }

    public virtual DbSet<DeteccionesPlaga> DeteccionesPlagas { get; set; }

    public virtual DbSet<Finca> Fincas { get; set; }

    public virtual DbSet<Ganado> Ganados { get; set; }

    public virtual DbSet<HistorialMedico> HistorialMedicos { get; set; }

    public virtual DbSet<Huerta> Huertas { get; set; }

    public virtual DbSet<ObservacionesHuertum> ObservacionesHuerta { get; set; }

    public virtual DbSet<Paciente> Pacientes { get; set; }

    public virtual DbSet<Plaga> Plagas { get; set; }

    public virtual DbSet<Poda> Podas { get; set; }

    public virtual DbSet<Riego> Riegos { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Siembra> Siembras { get; set; }

    public virtual DbSet<Tarea> Tareas { get; set; }

    public virtual DbSet<Tratamiento> Tratamientos { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySql("server=localhost;user=root;database=agrosft", Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.4.32-mariadb"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_unicode_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Abono>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("abonos");

            entity.HasIndex(e => e.AplicadoPor, "aplicado_por");

            entity.HasIndex(e => e.SiembraId, "siembra_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AplicadoPor)
                .HasColumnType("int(11)")
                .HasColumnName("aplicado_por");
            entity.Property(e => e.Cantidad)
                .HasPrecision(10, 2)
                .HasColumnName("cantidad");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PROGRAMADO'")
                .HasColumnType("enum('PROGRAMADO','APLICADO','CANCELADO')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaAplicacion).HasColumnName("fecha_aplicacion");
            entity.Property(e => e.FechaProgramada).HasColumnName("fecha_programada");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.SiembraId)
                .HasColumnType("int(11)")
                .HasColumnName("siembra_id");
            entity.Property(e => e.TipoAbono)
                .HasMaxLength(120)
                .HasColumnName("tipo_abono");

            entity.HasOne(d => d.AplicadoPorNavigation).WithMany(p => p.Abonos)
                .HasForeignKey(d => d.AplicadoPor)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("abonos_ibfk_2");

            entity.HasOne(d => d.Siembra).WithMany(p => p.Abonos)
                .HasForeignKey(d => d.SiembraId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("abonos_ibfk_1");
        });

        modelBuilder.Entity<Actividade>(entity =>
        {
            entity.HasKey(e => e.IdActividad).HasName("PRIMARY");

            entity.ToTable("actividades");

            entity.HasIndex(e => e.IdCultivo, "idx_actividades_cultivo");

            entity.HasIndex(e => e.FechaActividad, "idx_actividades_fecha");

            entity.Property(e => e.IdActividad)
                .HasColumnType("bigint(20)")
                .HasColumnName("id_actividad");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .HasDefaultValueSql("'PENDIENTE'")
                .HasColumnName("estado");
            entity.Property(e => e.FechaActividad).HasColumnName("fecha_actividad");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.IdCultivo)
                .HasColumnType("int(11)")
                .HasColumnName("id_cultivo");
            entity.Property(e => e.TipoActividad)
                .HasMaxLength(150)
                .HasColumnName("tipo_actividad");
            entity.Property(e => e.TrabajadorResponsable)
                .HasMaxLength(255)
                .HasColumnName("trabajador_responsable");

            entity.HasOne(d => d.IdCultivoNavigation).WithMany(p => p.Actividades)
                .HasForeignKey(d => d.IdCultivo)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("actividades_ibfk_1");
        });

        modelBuilder.Entity<Animale>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("animales");

            entity.HasIndex(e => e.CodigoIdentificacion, "codigo_identificacion").IsUnique();

            entity.HasIndex(e => e.ResponsableId, "responsable_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CodigoIdentificacion)
                .HasMaxLength(80)
                .HasColumnName("codigo_identificacion");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.EstadoSalud)
                .HasDefaultValueSql("'SALUDABLE'")
                .HasColumnType("enum('SALUDABLE','EN_TRATAMIENTO','BAJA')")
                .HasColumnName("estado_salud");
            entity.Property(e => e.FechaNacimiento).HasColumnName("fecha_nacimiento");
            entity.Property(e => e.Raza)
                .HasMaxLength(120)
                .HasColumnName("raza");
            entity.Property(e => e.ResponsableId)
                .HasColumnType("int(11)")
                .HasColumnName("responsable_id");
            entity.Property(e => e.TipoAnimal)
                .HasMaxLength(80)
                .HasColumnName("tipo_animal");

            entity.HasOne(d => d.Responsable).WithMany(p => p.Animales)
                .HasForeignKey(d => d.ResponsableId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("animales_ibfk_1");
        });

        modelBuilder.Entity<Cultivo>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("cultivos");

            entity.HasIndex(e => e.Estado, "idx_cultivos_estado");

            entity.HasIndex(e => e.Nombre, "idx_cultivos_nombre");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Area)
                .HasMaxLength(100)
                .HasColumnName("area");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .HasDefaultValueSql("'Activo'")
                .HasColumnName("estado");
            entity.Property(e => e.FechaActualizacion)
                .HasColumnType("timestamp")
                .HasColumnName("fecha_actualizacion");
            entity.Property(e => e.FechaCosecha).HasColumnName("fecha_cosecha");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.FechaSiembra).HasColumnName("fecha_siembra");
            entity.Property(e => e.Nombre)
                .HasMaxLength(150)
                .HasColumnName("nombre");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.Tipo)
                .HasMaxLength(100)
                .HasColumnName("tipo");
        });

        modelBuilder.Entity<DeteccionesPlaga>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("detecciones_plagas");

            entity.HasIndex(e => e.PlagaId, "plaga_id");

            entity.HasIndex(e => e.ReportadoPor, "reportado_por");

            entity.HasIndex(e => e.SiembraId, "siembra_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AccionesTomadas)
                .HasColumnType("text")
                .HasColumnName("acciones_tomadas");
            entity.Property(e => e.Caracteristicas)
                .HasColumnType("text")
                .HasColumnName("caracteristicas");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PENDIENTE'")
                .HasColumnType("enum('PENDIENTE','EN_REVISION','RESUELTO')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaReporte)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("datetime")
                .HasColumnName("fecha_reporte");
            entity.Property(e => e.ImagenUrl)
                .HasMaxLength(255)
                .HasColumnName("imagen_url");
            entity.Property(e => e.PlagaId)
                .HasColumnType("int(11)")
                .HasColumnName("plaga_id");
            entity.Property(e => e.ReportadoPor)
                .HasColumnType("int(11)")
                .HasColumnName("reportado_por");
            entity.Property(e => e.SiembraId)
                .HasColumnType("int(11)")
                .HasColumnName("siembra_id");

            entity.HasOne(d => d.Plaga).WithMany(p => p.DeteccionesPlagas)
                .HasForeignKey(d => d.PlagaId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("detecciones_plagas_ibfk_1");

            entity.HasOne(d => d.ReportadoPorNavigation).WithMany(p => p.DeteccionesPlagas)
                .HasForeignKey(d => d.ReportadoPor)
                .HasConstraintName("detecciones_plagas_ibfk_3");

            entity.HasOne(d => d.Siembra).WithMany(p => p.DeteccionesPlagas)
                .HasForeignKey(d => d.SiembraId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("detecciones_plagas_ibfk_2");
        });

        modelBuilder.Entity<Finca>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("fincas");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(150)
                .HasColumnName("nombre");
            entity.Property(e => e.Ubicacion)
                .HasMaxLength(255)
                .HasColumnName("ubicacion");
        });

        modelBuilder.Entity<Ganado>(entity =>
        {
            entity.HasKey(e => e.IdGanado).HasName("PRIMARY");

            entity.ToTable("ganado");

            entity.HasIndex(e => e.Activo, "idx_ganado_activo");

            entity.HasIndex(e => e.EstadoSalud, "idx_ganado_estado");

            entity.HasIndex(e => e.Tipo, "idx_ganado_tipo");

            entity.Property(e => e.IdGanado)
                .HasColumnType("bigint(20)")
                .HasColumnName("id_ganado");
            entity.Property(e => e.Activo)
                .HasDefaultValueSql("'1'")
                .HasColumnName("activo");
            entity.Property(e => e.Edad)
                .HasColumnType("int(11)")
                .HasColumnName("edad");
            entity.Property(e => e.EstadoSalud)
                .HasMaxLength(50)
                .HasColumnName("estado_salud");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.FechaNacimiento).HasColumnName("fecha_nacimiento");
            entity.Property(e => e.Peso)
                .HasPrecision(10, 2)
                .HasColumnName("peso");
            entity.Property(e => e.Raza)
                .HasMaxLength(120)
                .HasColumnName("raza");
            entity.Property(e => e.Tipo)
                .HasMaxLength(80)
                .HasColumnName("tipo");
        });

        modelBuilder.Entity<HistorialMedico>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("historial_medico");

            entity.HasIndex(e => e.AnimalId, "animal_id");

            entity.HasIndex(e => e.VeterinarioId, "veterinario_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AnimalId)
                .HasColumnType("int(11)")
                .HasColumnName("animal_id");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Dosis)
                .HasMaxLength(100)
                .HasColumnName("dosis");
            entity.Property(e => e.Fecha)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("datetime")
                .HasColumnName("fecha");
            entity.Property(e => e.ProximaVisita).HasColumnName("proxima_visita");
            entity.Property(e => e.Tratamiento)
                .HasColumnType("text")
                .HasColumnName("tratamiento");
            entity.Property(e => e.Vacunado)
                .HasDefaultValueSql("'0'")
                .HasColumnName("vacunado");
            entity.Property(e => e.VeterinarioId)
                .HasColumnType("int(11)")
                .HasColumnName("veterinario_id");

            entity.HasOne(d => d.Animal).WithMany(p => p.HistorialMedicos)
                .HasForeignKey(d => d.AnimalId)
                .HasConstraintName("historial_medico_ibfk_1");

            entity.HasOne(d => d.Veterinario).WithMany(p => p.HistorialMedicos)
                .HasForeignKey(d => d.VeterinarioId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("historial_medico_ibfk_2");
        });

        modelBuilder.Entity<Huerta>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("huertas");

            entity.HasIndex(e => e.ResponsableId, "idx_huertas_responsable");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(150)
                .HasColumnName("nombre");
            entity.Property(e => e.ResponsableId)
                .HasColumnType("int(11)")
                .HasColumnName("responsable_id");
            entity.Property(e => e.Ubicacion)
                .HasMaxLength(255)
                .HasColumnName("ubicacion");

            entity.HasOne(d => d.Responsable).WithMany(p => p.Huerta)
                .HasForeignKey(d => d.ResponsableId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("huertas_ibfk_1");
        });

        modelBuilder.Entity<ObservacionesHuertum>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("observaciones_huerta");

            entity.HasIndex(e => e.HuertaId, "idx_observaciones_huerta_id");

            entity.HasIndex(e => e.RegistradoPor, "idx_observaciones_registrado_por");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Comentario)
                .HasColumnType("text")
                .HasColumnName("comentario");
            entity.Property(e => e.Fecha)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("datetime")
                .HasColumnName("fecha");
            entity.Property(e => e.FotosUrl)
                .HasMaxLength(255)
                .HasColumnName("fotos_url");
            entity.Property(e => e.HuertaId)
                .HasColumnType("int(11)")
                .HasColumnName("huerta_id");
            entity.Property(e => e.RegistradoPor)
                .HasColumnType("int(11)")
                .HasColumnName("registrado_por");

            entity.HasOne(d => d.Huerta).WithMany(p => p.ObservacionesHuerta)
                .HasForeignKey(d => d.HuertaId)
                .HasConstraintName("observaciones_huerta_ibfk_1");

            entity.HasOne(d => d.RegistradoPorNavigation).WithMany(p => p.ObservacionesHuerta)
                .HasForeignKey(d => d.RegistradoPor)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("observaciones_huerta_ibfk_2");
        });

        modelBuilder.Entity<Paciente>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("paciente");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.Edad)
                .HasMaxLength(50)
                .HasColumnName("edad");
            entity.Property(e => e.Especie)
                .HasMaxLength(100)
                .HasColumnName("especie");
            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .HasColumnName("estado");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(150)
                .HasColumnName("nombre");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.Raza)
                .HasMaxLength(120)
                .HasColumnName("raza");
        });

        modelBuilder.Entity<Plaga>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("plagas");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(150)
                .HasColumnName("nombre");
            entity.Property(e => e.Severidad)
                .HasDefaultValueSql("'MEDIA'")
                .HasColumnType("enum('BAJA','MEDIA','ALTA')")
                .HasColumnName("severidad");
        });

        modelBuilder.Entity<Poda>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("podas");

            entity.HasIndex(e => e.RealizadaPor, "realizada_por");

            entity.HasIndex(e => e.SiembraId, "siembra_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PROGRAMADA'")
                .HasColumnType("enum('PROGRAMADA','REALIZADA','CANCELADA')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaProgramada).HasColumnName("fecha_programada");
            entity.Property(e => e.FechaRealizada).HasColumnName("fecha_realizada");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.RealizadaPor)
                .HasColumnType("int(11)")
                .HasColumnName("realizada_por");
            entity.Property(e => e.SiembraId)
                .HasColumnType("int(11)")
                .HasColumnName("siembra_id");
            entity.Property(e => e.TipoPoda)
                .HasMaxLength(120)
                .HasColumnName("tipo_poda");

            entity.HasOne(d => d.RealizadaPorNavigation).WithMany(p => p.Poda)
                .HasForeignKey(d => d.RealizadaPor)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("podas_ibfk_2");

            entity.HasOne(d => d.Siembra).WithMany(p => p.Poda)
                .HasForeignKey(d => d.SiembraId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("podas_ibfk_1");
        });

        modelBuilder.Entity<Riego>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("riegos");

            entity.HasIndex(e => e.RealizadoPor, "realizado_por");

            entity.HasIndex(e => e.SiembraId, "siembra_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CantidadAguaLitros)
                .HasPrecision(12, 2)
                .HasColumnName("cantidad_agua_litros");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PROGRAMADO'")
                .HasColumnType("enum('PROGRAMADO','REALIZADO','SUSPENDIDO')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaProgramada).HasColumnName("fecha_programada");
            entity.Property(e => e.FechaRealizada).HasColumnName("fecha_realizada");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.RealizadoPor)
                .HasColumnType("int(11)")
                .HasColumnName("realizado_por");
            entity.Property(e => e.SiembraId)
                .HasColumnType("int(11)")
                .HasColumnName("siembra_id");

            entity.HasOne(d => d.RealizadoPorNavigation).WithMany(p => p.Riegos)
                .HasForeignKey(d => d.RealizadoPor)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("riegos_ibfk_2");

            entity.HasOne(d => d.Siembra).WithMany(p => p.Riegos)
                .HasForeignKey(d => d.SiembraId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("riegos_ibfk_1");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("roles");

            entity.HasIndex(e => e.Nombre, "nombre").IsUnique();

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .HasColumnName("descripcion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<Siembra>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("siembras");

            entity.HasIndex(e => e.CultivoId, "cultivo_id");

            entity.HasIndex(e => e.FincaId, "finca_id");

            entity.HasIndex(e => e.TrabajadorId, "trabajador_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Area)
                .HasPrecision(10, 2)
                .HasColumnName("area");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.CultivoId)
                .HasColumnType("int(11)")
                .HasColumnName("cultivo_id");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PLANIFICADA'")
                .HasColumnType("enum('PLANIFICADA','EN_CURSO','FINALIZADA','CANCELADA')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaSiembra).HasColumnName("fecha_siembra");
            entity.Property(e => e.FincaId)
                .HasColumnType("int(11)")
                .HasColumnName("finca_id");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.TrabajadorId)
                .HasColumnType("int(11)")
                .HasColumnName("trabajador_id");

            entity.HasOne(d => d.Cultivo).WithMany(p => p.Siembras)
                .HasForeignKey(d => d.CultivoId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("siembras_ibfk_1");

            entity.HasOne(d => d.Finca).WithMany(p => p.Siembras)
                .HasForeignKey(d => d.FincaId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("siembras_ibfk_2");

            entity.HasOne(d => d.Trabajador).WithMany(p => p.Siembras)
                .HasForeignKey(d => d.TrabajadorId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("siembras_ibfk_3");
        });

        modelBuilder.Entity<Tarea>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("tareas");

            entity.HasIndex(e => e.AsignadoA, "asignado_a");

            entity.HasIndex(e => e.AsignadoPor, "asignado_por");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AsignadoA)
                .HasColumnType("int(11)")
                .HasColumnName("asignado_a");
            entity.Property(e => e.AsignadoPor)
                .HasColumnType("int(11)")
                .HasColumnName("asignado_por");
            entity.Property(e => e.CreadoEn)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("creado_en");
            entity.Property(e => e.Descripcion)
                .HasColumnType("text")
                .HasColumnName("descripcion");
            entity.Property(e => e.Estado)
                .HasDefaultValueSql("'PENDIENTE'")
                .HasColumnType("enum('PENDIENTE','EN_PROGRESO','COMPLETADA','CANCELADA')")
                .HasColumnName("estado");
            entity.Property(e => e.FechaInicio)
                .HasColumnType("datetime")
                .HasColumnName("fecha_inicio");
            entity.Property(e => e.FechaVencimiento)
                .HasColumnType("datetime")
                .HasColumnName("fecha_vencimiento");
            entity.Property(e => e.Tipo)
                .HasDefaultValueSql("'GENERICA'")
                .HasColumnType("enum('ABONO','PODA','RIEGO','PLAGA','SIEMBRA','GENERICA')")
                .HasColumnName("tipo");
            entity.Property(e => e.Titulo)
                .HasMaxLength(150)
                .HasColumnName("titulo");

            entity.HasOne(d => d.AsignadoANavigation).WithMany(p => p.TareaAsignadoANavigations)
                .HasForeignKey(d => d.AsignadoA)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("tareas_ibfk_1");

            entity.HasOne(d => d.AsignadoPorNavigation).WithMany(p => p.TareaAsignadoPorNavigations)
                .HasForeignKey(d => d.AsignadoPor)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("tareas_ibfk_2");
        });

        modelBuilder.Entity<Tratamiento>(entity =>
        {
            entity.HasKey(e => e.IdTratamiento).HasName("PRIMARY");

            entity.ToTable("tratamientos");

            entity.HasIndex(e => e.FechaTratamiento, "idx_tratamientos_fecha");

            entity.HasIndex(e => e.IdGanado, "idx_tratamientos_ganado");

            entity.Property(e => e.IdTratamiento)
                .HasColumnType("bigint(20)")
                .HasColumnName("id_tratamiento");
            entity.Property(e => e.Costo)
                .HasPrecision(10, 2)
                .HasColumnName("costo");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.FechaTratamiento).HasColumnName("fecha_tratamiento");
            entity.Property(e => e.IdGanado)
                .HasColumnType("bigint(20)")
                .HasColumnName("id_ganado");
            entity.Property(e => e.Observaciones)
                .HasColumnType("text")
                .HasColumnName("observaciones");
            entity.Property(e => e.TipoTratamiento)
                .HasMaxLength(150)
                .HasColumnName("tipo_tratamiento");
            entity.Property(e => e.VeterinarioResponsable)
                .HasMaxLength(255)
                .HasColumnName("veterinario_responsable");

            entity.HasOne(d => d.IdGanadoNavigation).WithMany(p => p.Tratamientos)
                .HasForeignKey(d => d.IdGanado)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("tratamientos_ibfk_1");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("usuarios");

            entity.HasIndex(e => e.Correo, "correo").IsUnique();

            entity.HasIndex(e => e.NumeroDocumento, "idx_usuarios_numero_documento").IsUnique();

            entity.HasIndex(e => e.RoleId, "idx_usuarios_role");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Activo)
                .HasDefaultValueSql("'1'")
                .HasColumnName("activo");
            entity.Property(e => e.Correo)
                .HasMaxLength(150)
                .HasColumnName("correo");
            entity.Property(e => e.FechaCreacion)
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("fecha_creacion");
            entity.Property(e => e.Nombre)
                .HasMaxLength(120)
                .HasColumnName("nombre");
            entity.Property(e => e.NumeroDocumento)
                .HasMaxLength(50)
                .HasColumnName("numero_documento");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.RoleId)
                .HasColumnType("int(11)")
                .HasColumnName("role_id");
            entity.Property(e => e.Telefono)
                .HasMaxLength(30)
                .HasColumnName("telefono");
            entity.Property(e => e.UltimoLogin)
                .HasColumnType("timestamp")
                .HasColumnName("ultimo_login");

            entity.HasOne(d => d.Role).WithMany(p => p.Usuarios)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("usuarios_ibfk_1");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
