using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using actividad.Models;
using System.Linq;

namespace actividad.Controllers
{
 [Authorize]
 public class SiembrasController : Controller
 {
 private readonly AgrosftContext _context;

 public SiembrasController(AgrosftContext context)
 {
 _context = context;
 }

 public async Task<IActionResult> Index()
 {
 var siembras = _context.Siembras.Include(s => s.Cultivo).Include(s => s.Finca).Include(s => s.Trabajador);
 return View(await siembras.ToListAsync());
 }

 public async Task<IActionResult> Details(int? id)
 {
 if (id == null) return NotFound();
 var siembra = await _context.Siembras.Include(s => s.Cultivo).Include(s => s.Finca).Include(s => s.Trabajador).FirstOrDefaultAsync(s => s.Id == id);
 if (siembra == null) return NotFound();
 return View(siembra);
 }

 public IActionResult Create()
 {
 ViewData["Cultivos"] = _context.Cultivos.ToList();
 ViewData["Fincas"] = _context.Fincas.ToList();
 ViewData["Trabajadores"] = _context.Usuarios.ToList();
 return View();
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Create([Bind("Id,CultivoId,FincaId,TrabajadorId,Area,FechaSiembra,Observaciones")] Siembra siembra)
 {
 if (ModelState.IsValid)
 {
 _context.Add(siembra);
 await _context.SaveChangesAsync();
 return RedirectToAction(nameof(Index));
 }
 ViewData["Cultivos"] = _context.Cultivos.ToList();
 ViewData["Fincas"] = _context.Fincas.ToList();
 ViewData["Trabajadores"] = _context.Usuarios.ToList();
 return View(siembra);
 }

 public async Task<IActionResult> Edit(int? id)
 {
 if (id == null) return NotFound();
 var siembra = await _context.Siembras.FindAsync(id);
 if (siembra == null) return NotFound();
 ViewData["Cultivos"] = _context.Cultivos.ToList();
 ViewData["Fincas"] = _context.Fincas.ToList();
 ViewData["Trabajadores"] = _context.Usuarios.ToList();
 return View(siembra);
 }

 [HttpPost]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> Edit(int id, [Bind("Id,CultivoId,FincaId,TrabajadorId,Area,FechaSiembra,Observaciones")] Siembra siembra)
 {
 if (id != siembra.Id) return NotFound();
 if (ModelState.IsValid)
 {
 try
 {
 _context.Update(siembra);
 await _context.SaveChangesAsync();
 }
 catch (DbUpdateConcurrencyException)
 {
 if (!SiembraExists(siembra.Id)) return NotFound();
 throw;
 }
 return RedirectToAction(nameof(Index));
 }
 ViewData["Cultivos"] = _context.Cultivos.ToList();
 ViewData["Fincas"] = _context.Fincas.ToList();
 ViewData["Trabajadores"] = _context.Usuarios.ToList();
 return View(siembra);
 }

 public async Task<IActionResult> Delete(int? id)
 {
 if (id == null) return NotFound();
 var siembra = await _context.Siembras.Include(s => s.Cultivo).Include(s => s.Finca).Include(s => s.Trabajador).FirstOrDefaultAsync(s => s.Id == id);
 if (siembra == null) return NotFound();
 return View(siembra);
 }

 [HttpPost, ActionName("Delete")]
 [ValidateAntiForgeryToken]
 public async Task<IActionResult> DeleteConfirmed(int id)
 {
 var siembra = await _context.Siembras.FindAsync(id);
 if (siembra != null)
 {
 _context.Siembras.Remove(siembra);
 await _context.SaveChangesAsync();
 }
 return RedirectToAction(nameof(Index));
 }

 private bool SiembraExists(int id) => _context.Siembras.Any(e => e.Id == id);
 }
}
