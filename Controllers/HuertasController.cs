using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using actividad.Models;
using System.Linq;

namespace actividad.Controllers
{
 [Authorize]
 public class HuertasController : Controller
 {
 private readonly AgrosftContext _context;

 public HuertasController(AgrosftContext context)
 {
 _context = context;
 }

 public async Task<IActionResult> Index()
 {
 var huertas = _context.Huertas.Include(h => h.Responsable);
 return View(await huertas.ToListAsync());
 }

 public async Task<IActionResult> Details(int? id)
 {
 if (id == null) return NotFound();
 var huerta = await _context.Huertas.Include(h => h.Responsable).FirstOrDefaultAsync(h => h.Id == id);
 if (huerta == null) return NotFound();
 return View(huerta);
 }

 public IActionResult Create()
 {
 ViewData["Responsables"] = _context.Usuarios.ToList();
 return View();
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Create([Bind("Id,Nombre,Descripcion,Ubicacion,ResponsableId")] Huerta huerta)
 {
 if (ModelState.IsValid)
 {
 _context.Add(huerta);
 await _context.SaveChangesAsync();
 return RedirectToAction(nameof(Index));
 }
 ViewData["Responsables"] = _context.Usuarios.ToList();
 return View(huerta);
 }

 public async Task<IActionResult> Edit(int? id)
 {
 if (id == null) return NotFound();
 var huerta = await _context.Huertas.FindAsync(id);
 if (huerta == null) return NotFound();
 ViewData["Responsables"] = _context.Usuarios.ToList();
 return View(huerta);
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Edit(int id, [Bind("Id,Nombre,Descripcion,Ubicacion,ResponsableId")] Huerta huerta)
 {
 if (id != huerta.Id) return NotFound();
 if (ModelState.IsValid)
 {
 try
 {
 _context.Update(huerta);
 await _context.SaveChangesAsync();
 }
 catch (DbUpdateConcurrencyException)
 {
 if (!HuertaExists(huerta.Id)) return NotFound();
 throw;
 }
 return RedirectToAction(nameof(Index));
 }
 ViewData["Responsables"] = _context.Usuarios.ToList();
 return View(huerta);
 }

 public async Task<IActionResult> Delete(int? id)
 {
 if (id == null) return NotFound();
 var huerta = await _context.Huertas.Include(h => h.Responsable).FirstOrDefaultAsync(h => h.Id == id);
 if (huerta == null) return NotFound();
 return View(huerta);
 }

 [HttpPost, ActionName("Delete")]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> DeleteConfirmed(int id)
 {
 var huerta = await _context.Huertas.FindAsync(id);
 if (huerta != null)
 {
 _context.Huertas.Remove(huerta);
 await _context.SaveChangesAsync();
 }
 return RedirectToAction(nameof(Index));
 }

 private bool HuertaExists(int id) => _context.Huertas.Any(e => e.Id == id);
 }
}
