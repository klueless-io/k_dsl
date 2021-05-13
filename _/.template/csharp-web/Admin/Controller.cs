{{#*inline "bindIds"}}
Id,{{#each entity.columns}}{{camel ./name}}{{#if @last}}{{else}},{{/if}}{{/each}}
{{~/inline}}
namespace {{project.application_namespace}}.Controllers
{
  using System;
  using System.Collections.Generic;
  using System.Linq;
  using System.Threading.Tasks;
  using {{project.application_namespace}}.Context;
  using {{project.application_namespace}}.Data;
  using Microsoft.AspNetCore.Mvc;
  using Microsoft.AspNetCore.Mvc.Rendering;
  using Microsoft.EntityFrameworkCore;

  public class {{camel entity.model_name}}Controller : Controller
  {
    // Should be using DomainContext instead of MsDbContext
    // private readonly DomainContext _context;
    private readonly MsDbContext _context;

    public {{camel entity.model_name}}Controller(MsDbContext context)
    {
        _context = context;
    }

    // GET: {{camel entity.model_name}}
    public async Task<IActionResult> Index()
    {
        return View(await _context.{{camel entity.model_name_plural}}.ToListAsync());
    }

    // GET: {{camel entity.model_name}}/Details/5
    public async Task<IActionResult> Details(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var {{snake entity.model_name}} = await _context.{{camel entity.model_name_plural}}
            .FirstOrDefaultAsync(m => m.Id == id);
        if ({{snake entity.model_name}} == null)
        {
            return NotFound();
        }

        return View({{snake entity.model_name}});
    }

    // GET: {{camel entity.model_name}}/Create
    public IActionResult Create()
    {
        return View();
    }

    // POST: {{camel entity.model_name}}/Create
    // To protect from overposting attacks, enable the specific properties you want to bind to.
    // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
    [HttpPost]
    [ValidateAntiForgeryToken]
    // Id,FirstName,LastName,Phone,BirthDate
    public async Task<IActionResult> Create([Bind("{{> bindIds}}")] {{camel entity.model_name}} {{snake entity.model_name}})
    {
      if (ModelState.IsValid)
      {
          _context.Add({{snake entity.model_name}});
          await _context.SaveChangesAsync();
          return RedirectToAction(nameof(Index));
      }

      return View({{snake entity.model_name}});
    }

    // GET: {{camel entity.model_name}}/Edit/5
    public async Task<IActionResult> Edit(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var {{snake entity.model_name}} = await _context.{{camel entity.model_name_plural}}.FindAsync(id);
        if ({{snake entity.model_name}} == null)
        {
            return NotFound();
        }

        return View({{snake entity.model_name}});
    }

    // POST: {{camel entity.model_name}}/Edit/5
    // To protect from overposting attacks, enable the specific properties you want to bind to.
    // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(int id, [Bind("{{> bindIds}}")] {{camel entity.model_name}} {{snake entity.model_name}})
    {
      if (id != {{snake entity.model_name}}.Id)
      {
          return NotFound();
      }

      if (ModelState.IsValid)
      {
        try
        {
            _context.Update({{snake entity.model_name}});
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!{{camel entity.model_name}}Exists({{snake entity.model_name}}.Id))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return RedirectToAction(nameof(Index));
      }

      return View({{snake entity.model_name}});
    }

    // GET: {{camel entity.model_name}}/Delete/5
    public async Task<IActionResult> Delete(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var {{snake entity.model_name}} = await _context.{{camel entity.model_name_plural}}
            .FirstOrDefaultAsync(m => m.Id == id);
        if ({{snake entity.model_name}} == null)
        {
            return NotFound();
        }

        return View({{snake entity.model_name}});
    }

    // POST: {{camel entity.model_name}}/Delete/5
    [HttpPost]
    [ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        var {{snake entity.model_name}} = await _context.{{camel entity.model_name_plural}}.FindAsync(id);
        _context.{{camel entity.model_name_plural}}.Remove({{snake entity.model_name}});
        await _context.SaveChangesAsync();
        return RedirectToAction(nameof(Index));
    }

    private bool {{camel entity.model_name}}Exists(int id)
    {
        return _context.{{camel entity.model_name_plural}}.Any(e => e.Id == id);
    }
  }
}
