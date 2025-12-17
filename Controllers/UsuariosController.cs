using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using actividad.Models;
using System.Linq;

namespace actividad.Controllers
{
 [Authorize]
 public class UsuariosController : Controller
 {
 private readonly AgrosftContext _context;

 public UsuariosController(AgrosftContext context)
 {
 _context = context;
 }

 public async Task<IActionResult> Index()
 {
 var usuarios = _context.Usuarios.Include(u => u.Role);
 return View(await usuarios.ToListAsync());
 }

 public async Task<IActionResult> Details(int? id)
 {
 if (id == null) return NotFound();
 var usuario = await _context.Usuarios.Include(u => u.Role).FirstOrDefaultAsync(u => u.Id == id);
 if (usuario == null) return NotFound();
 return View(usuario);
 }

 public IActionResult Create()
 {
 ViewData["Roles"] = _context.Roles.ToList();
 return View();
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Create([Bind("Id,Nombre,Correo,Telefono,NumeroDocumento,Password,RoleId,Activo")] Usuario usuario)
 {
 if (ModelState.IsValid)
 {
 usuario.FechaCreacion = System.DateTime.Now;
 _context.Add(usuario);
 await _context.SaveChangesAsync();
 return RedirectToAction(nameof(Index));
 }
 ViewData["Roles"] = _context.Roles.ToList();
 return View(usuario);
 }

 public async Task<IActionResult> Edit(int? id)
 {
 if (id == null) return NotFound();
 var usuario = await _context.Usuarios.FindAsync(id);
 if (usuario == null) return NotFound();
 ViewData["Roles"] = _context.Roles.ToList();
 return View(usuario);
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Edit(int id, [Bind("Id,Nombre,Correo,Telefono,NumeroDocumento,Password,RoleId,Activo")] Usuario usuario)
 {
 if (id != usuario.Id) return NotFound();
 if (ModelState.IsValid)
 {
 try
 {
 _context.Update(usuario);
 await _context.SaveChangesAsync();
 }
 catch (DbUpdateConcurrencyException)
 {
 if (!UsuarioExists(usuario.Id)) return NotFound();
 throw;
 }
 return RedirectToAction(nameof(Index));
 }
 ViewData["Roles"] = _context.Roles.ToList();
 return View(usuario);
 }

 public async Task<IActionResult> Delete(int? id)
 {
 if (id == null) return NotFound();
 var usuario = await _context.Usuarios.Include(u => u.Role).FirstOrDefaultAsync(u => u.Id == id);
 if (usuario == null) return NotFound();
 return View(usuario);
 }

 [HttpPost, ActionName("Delete")]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> DeleteConfirmed(int id)
 {
 var usuario = await _context.Usuarios.FindAsync(id);
 if (usuario != null)
 {
 _context.Usuarios.Remove(usuario);
 await _context.SaveChangesAsync();
 }
 return RedirectToAction(nameof(Index));
 }

 private bool UsuarioExists(int id) => _context.Usuarios.Any(e => e.Id == id);
 }
}
