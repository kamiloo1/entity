using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using actividad.Models;

namespace actividad.Controllers
{
 [Authorize]
 public class RolesController : Controller
 {
 private readonly AgrosftContext _context;

 public RolesController(AgrosftContext context)
 {
 _context = context;
 }

 public async Task<IActionResult> Index()
 {
 return View(await _context.Roles.ToListAsync());
 }

 public async Task<IActionResult> Details(int? id)
 {
 if (id == null) return NotFound();
 var role = await _context.Roles.FirstOrDefaultAsync(r => r.Id == id);
 if (role == null) return NotFound();
 return View(role);
 }

 public IActionResult Create() => View();

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Create([Bind("Id,Nombre,Descripcion")] Role role)
 {
 if (ModelState.IsValid)
 {
 _context.Add(role);
 await _context.SaveChangesAsync();
 return RedirectToAction(nameof(Index));
 }
 return View(role);
 }

 public async Task<IActionResult> Edit(int? id)
 {
 if (id == null) return NotFound();
 var role = await _context.Roles.FindAsync(id);
 if (role == null) return NotFound();
 return View(role);
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Edit(int id, [Bind("Id,Nombre,Descripcion")] Role role)
 {
 if (id != role.Id) return NotFound();
 if (ModelState.IsValid)
 {
 try
 {
 _context.Update(role);
 await _context.SaveChangesAsync();
 }
 catch (DbUpdateConcurrencyException)
 {
 if (!RoleExists(role.Id)) return NotFound();
 throw;
 }
 return RedirectToAction(nameof(Index));
 }
 return View(role);
 }

 public async Task<IActionResult> Delete(int? id)
 {
 if (id == null) return NotFound();
 var role = await _context.Roles.FirstOrDefaultAsync(r => r.Id == id);
 if (role == null) return NotFound();
 return View(role);
 }

 [HttpPost, ActionName("Delete")]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> DeleteConfirmed(int id)
 {
 var role = await _context.Roles.FindAsync(id);
 if (role != null)
 {
 _context.Roles.Remove(role);
 await _context.SaveChangesAsync();
 }
 return RedirectToAction(nameof(Index));
 }

 private bool RoleExists(int id) => _context.Roles.Any(e => e.Id == id);
 }
}
