using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using actividad.Models;
using System.Linq;

namespace actividad.Controllers
{
 [Authorize]
 public class CultivosController : Controller
 {
 private readonly AgrosftContext _context;

 public CultivosController(AgrosftContext context)
 {
 _context = context;
 }

 public async Task<IActionResult> Index()
 {
 return View(await _context.Cultivos.ToListAsync());
 }

 public async Task<IActionResult> Details(int? id)
 {
 if (id == null) return NotFound();
 var cultivo = await _context.Cultivos.FirstOrDefaultAsync(c => c.Id == id);
 if (cultivo == null) return NotFound();
 return View(cultivo);
 }

 public IActionResult Create() => View();

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Create([Bind("Id,Nombre,Tipo,Area,Descripcion")] Cultivo cultivo)
 {
 if (ModelState.IsValid)
 {
 _context.Add(cultivo);
 await _context.SaveChangesAsync();
 return RedirectToAction(nameof(Index));
 }
 return View(cultivo);
 }

 public async Task<IActionResult> Edit(int? id)
 {
 if (id == null) return NotFound();
 var cultivo = await _context.Cultivos.FindAsync(id);
 if (cultivo == null) return NotFound();
 return View(cultivo);
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Edit(int id, [Bind("Id,Nombre,Tipo,Area,Descripcion")] Cultivo cultivo)
 {
 if (id != cultivo.Id) return NotFound();
 if (ModelState.IsValid)
 {
 try
 {
 _context.Update(cultivo);
 await _context.SaveChangesAsync();
 }
 catch (DbUpdateConcurrencyException)
 {
 if (!CultivoExists(cultivo.Id)) return NotFound();
 throw;
 }
 return RedirectToAction(nameof(Index));
 }
 return View(cultivo);
 }

 public async Task<IActionResult> Delete(int? id)
 {
 if (id == null) return NotFound();
 var cultivo = await _context.Cultivos.FirstOrDefaultAsync(c => c.Id == id);
 if (cultivo == null) return NotFound();
 return View(cultivo);
 }

 [HttpPost, ActionName("Delete")]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> DeleteConfirmed(int id)
 {
 var cultivo = await _context.Cultivos.FindAsync(id);
 if (cultivo != null)
 {
 _context.Cultivos.Remove(cultivo);
 await _context.SaveChangesAsync();
 }
 return RedirectToAction(nameof(Index));
 }

 private bool CultivoExists(int id) => _context.Cultivos.Any(e => e.Id == id);
 }
}
