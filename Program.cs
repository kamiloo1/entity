using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using actividad.Models;

var builder = WebApplication.CreateBuilder(args);

// Register DbContext for dependency injection
builder.Services.AddDbContext<AgrosftContext>(options =>
    options.UseMySql(builder.Configuration.GetConnectionString("conexion") ?? "server=localhost;user=root;database=agrosft",
    Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.4.32-mariadb")));

// Register ApplicationDbContext for Identity
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseMySql(builder.Configuration.GetConnectionString("conexion") ?? "server=localhost;user=root;database=agrosft",
    Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.4.32-mariadb")));

// Configure Identity
builder.Services.AddDefaultIdentity<ApplicationUser>(options => 
{
    // Password settings
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = true;
    options.Password.RequiredLength = 6;
    options.Password.RequiredUniqueChars = 1;

    // Lockout settings
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
    options.Lockout.MaxFailedAccessAttempts = 5;
    options.Lockout.AllowedForNewUsers = true;

    // User settings
    options.User.RequireUniqueEmail = true;
    options.SignIn.RequireConfirmedAccount = false;
})
.AddEntityFrameworkStores<ApplicationDbContext>();

// Configure cookie authentication options
builder.Services.ConfigureApplicationCookie(options =>
{
    options.LoginPath = "/Identity/Account/Login";
    options.LogoutPath = "/Identity/Account/Logout";
    options.AccessDeniedPath = "/Identity/Account/AccessDenied";
});

// Add services to the container.
builder.Services.AddControllersWithViews();

// Configure Razor Pages for Identity
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapRazorPages();

app.Run();
