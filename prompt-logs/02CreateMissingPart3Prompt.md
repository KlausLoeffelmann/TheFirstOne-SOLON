 D:\Git\SOLON  23:51:37 - Wed, Nov. 5    main ≡  ?3  ✔ 
 > copilot --allow-all-tools
 Welcome to GitHub Copilot CLI
 Version 0.0.353 · Commit f8fd3e3

 Copilot can write, test and debug code right from your terminal. Describe a task to get started or enter ? for help.
 Copilot uses AI, check for mistakes.

 ● Connected to GitHub MCP Server

 ● Logged in with gh as user: KlausLoeffelmann

 > There is a general prompt for creating specs in `\prmpt-logs\01CreateInitialMDFiles.md`. From that prompt, 2
      documents have already been crezted. Could you please add the 3rd and add the text to the existing file in
      `doc\spc\Part3-Domain-Specific-Specs.md`?

 ● I'll help you create the 3rd document based on the general prompt. Let me first
   examine the existing files to understand the structure and content.

 ✓ List directory prompt-logs (7 files)

 ✓ List directory docs (7 files)

 ✓ Read prompt-logs\01CreateInitialMDFiles.md (118 lines)

 ✓ List directory docs\spec (10 files)

 ✓ Read docs\spec\Part1-Historical-Context.md:1-50 (54 lines)

 ✓ Read docs\spec\Part2-Software-Analysis.md:1-50 (55 lines)

 ✓ Read docs\spec\Part3-Domain-Specific-Specs.md (6 lines)

 ● Now I can see that Part3-Domain-Specific-Specs.md exists but is mostly empty.
   Let me examine the other parts more thoroughly to understand the complete
   context and create comprehensive Part 3 content.

 ✓ Read docs\spec\Part1-Historical-Context.md:1-end (5 lines)

 ✓ Read docs\spec\Part2-Software-Analysis.md:1-end (5 lines)

 ✓ Check Part 1 file size
   $ Get-Content "D:\Git\SOLON\docs\spec\Part1-Historical-Context.md" | Measure-Object -Line
   ↪ 4 lines...

 ✓ Read Part 1 and Part 2 completely
   $ Get-Content "D:\Git\SOLON\docs\spec\Part1-Historical-Context.md" -Raw; Write-Host "`n=== PART 2 ===`n"; Get-Content
   "D:\Git\SOLON\docs\spec\Part2-Software-Analysis.md" -Raw
   ↪ 289 lines...

 ● Perfect! Now I have all the context. Let me create comprehensive Part 3 content
   for the domain-specific specifications for migrating to .NET 10 WinForms with
   SQLite.

 ✗ Execution failed: Expected ',' or '}' after property value in JSON at position 127 (line 1 column 128)

 > Do you have more information about the last exception you hit?

 ✓ Read prompt-logs\01CreateInitialMDFiles.md:80-113 (39 lines)

 ● Based on the log, the previous errors were JSON parsing errors when attempting
   to create Part 3. The error "Expected ',' or '}' after property value in JSON at
   position 71" indicates that the AI was trying to pass malformed JSON to the
   create tool - likely the file content had unescaped characters or quotes that
   broke the JSON structure.

   The good news: Part 3 file already exists (just nearly empty), and I now have
   full context from Parts 1 and 2. Let me create the complete Part 3 content now,
   being careful to avoid JSON issues:

 ✓ Edit docs\spec\Part3-Domain-Specific-Specs.md (+312 -1)
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
   │   1  -  # SOLON - Domain specific specification                                                                  │
   │   1  +  # SOLON - Massenermittlung für Bauunternehmer                                                            │
   │   2  +  ## Part 3: Migration Specification for .NET 10 WinForms                                                  │
   │   3  +                                                                                                           │
   │   4  +  **Document Version:** 1.0                                                                                │
   │   5  +  **Date:** November 2025                                                                                  │
   │   6  +  **Target Platform:** .NET 10, Windows 10/11                                                              │
   │   7  +  **Target Framework:** WinForms with SQLite backend                                                       │
   │   8  +  **Migration Strategy:** Greenfield development with legacy data import                                   │
   │   9  +                                                                                                           │
   │  10  +  ---                                                                                                      │
   │  11  +                                                                                                           │
   │  12  +  ## Table of Contents                                                                                     │
   │  13  +                                                                                                           │
   │  14  +  1. [Executive Summary](#executive-summary)                                                               │
   │  15  +  2. [Migration Goals and Principles](#migration-goals-and-principles)                                     │
   │  16  +  3. [Architecture Design](#architecture-design)                                                           │
   │  17  +  4. [Data Migration Strategy](#data-migration-strategy)                                                   │
   │  18  +  5. [Database Schema Design](#database-schema-design)                                                     │
   │  19  +  6. [User Interface Specifications](#user-interface-specifications)                                       │
   │  20  +  7. [Functional Requirements](#functional-requirements)                                                   │
   │  21  +  8. [Non-Functional Requirements](#non-functional-requirements)                                           │
   │  22  +  9. [Implementation Roadmap](#implementation-roadmap)                                                     │
   │  23  +  10. [Risk Assessment](#risk-assessment)                                                                  │
   │  24  +                                                                                                           │
   │  25  +  ---                                                                                                      │
   │  26  +                                                                                                           │
   │  27  +  ## Executive Summary                                                                                     │
   │  28  +                                                                                                           │
   │  29  +  This document specifies the complete migration of the DOS-based SOLON construction cost estimation       │
   │         system to a modern .NET 10 WinForms application. The new system will:                                    │
   │  30  +                                                                                                           │
   │  31  +  - **Preserve** all original functionality and domain logic                                               │
   │  32  +  - **Import** existing DOS file-based data into SQLite                                                    │
   │  33  +  - **Modernize** the user interface while respecting workflow patterns                                    │
   │  34  +  - **Extend** capabilities with modern features (undo/redo, search, reporting)                            │
   │  35  +  - **Maintain** compatibility with German construction industry standards                                 │
   │  36  +                                                                                                           │
   │  37  +  ### Key Success Criteria                                                                                 │
   │  38  +                                                                                                           │
   │  39  +  | Criterion | Target |                                                                                   │
   │  40  +  |-----------|--------|                                                                                   │
   │  41  +  | Data Migration | 100% of DOS projects readable |                                                       │
   │  42  +  | Feature Parity | All original features implemented |                                                   │
   │  43  +  | Performance | Sub-second response for typical operations |                                             │
   │  44  +  | Usability | Intuitive for users familiar with DOS version |                                            │
   │  45  +  | Reliability | Zero data loss, full transaction support |                                               │
   │  46  +                                                                                                           │
   │  47  +  ---                                                                                                      │
   │  48  +                                                                                                           │
   │  49  +  ## Migration Goals and Principles                                                                        │
   │  50  +                                                                                                           │
   │  51  +  ### Primary Goals                                                                                        │
   │  52  +                                                                                                           │
   │  53  +  1. **Preserve Business Value**                                                                           │
   │  54  +     - Maintain all calculation logic exactly as original                                                  │
   │  55  +     - Support existing workflow patterns                                                                  │
   │  56  +     - Keep domain terminology consistent                                                                  │
   │  57  +                                                                                                           │
   │  58  +  2. **Modernize Technology Stack**                                                                        │
   │  59  +     - Replace file-based storage with SQLite relational database                                          │
   │  60  +     - Use modern UI patterns (context menus, toolbars, keyboard shortcuts)                                │
   │  61  +     - Support contemporary Windows (10/11, high DPI, dark mode)                                           │
   │  62  +                                                                                                           │
   │  63  +  3. **Enhance Capabilities**                                                                              │
   │  64  +     - Add search across all projects                                                                      │
   │  65  +     - Implement undo/redo                                                                                 │
   │  66  +     - Support export to Excel/PDF                                                                         │
   │  67  +     - Enable data backup/restore                                                                          │
   │  68  +     - Add audit trail                                                                                     │
   │  69  +                                                                                                           │
   │  70  +  4. **Ensure Data Safety**                                                                                │
   │  71  +     - ACID transactions for all operations                                                                │
   │  72  +     - Automatic backup functionality                                                                      │
   │  73  +     - Data validation and integrity constraints                                                           │
   │  74  +     - Import verification tools                                                                           │
   │  75  +                                                                                                           │
   │  76  +  ### Design Principles                                                                                    │
   │  77  +                                                                                                           │
   │  78  +  **Principle 1: Respect the Domain**                                                                      │
   │  79  +  - Keep German terminology in UI where appropriate                                                        │
   │  80  +  - Maintain 4-level hierarchy (4.Summe → Los → Titel → Position)                                          │
   │  81  +  - Preserve calculation rules and formulas                                                                │
   │  82  +                                                                                                           │
   │  83  +  **Principle 2: Progressive Disclosure**                                                                  │
   │  84  +  - Show hierarchy clearly (TreeView)                                                                      │
   │  85  +  - Display details on demand                                                                              │
   │  86  +  - Support keyboard-driven power users                                                                    │
   │  87  +                                                                                                           │
   │  88  +  **Principle 3: Data Integrity First**                                                                    │
   │  89  +  - All mutations in transactions                                                                          │
   │  90  +  - Referential integrity enforced                                                                         │
   │  91  +  - Input validation at database and UI layers                                                             │
   │  92  +                                                                                                           │
   │  93  +  **Principle 4: Maintain Workflow Continuity**                                                            │
   │  94  +  - Honor original F-key conventions where practical                                                       │
   │  95  +  - Support rapid data entry patterns                                                                      │
   │  96  +  - Minimize clicks for common operations                                                                  │
   │  97  +                                                                                                           │
   │  98  +  ---                                                                                                      │
   │  99  +                                                                                                           │
   │ 100  +  ## Architecture Design                                                                                   │
   │ 101  +                                                                                                           │
   │ 102  +  ### Application Architecture                                                                             │
   │ 103  +                                                                                                           │
   │ 104  +  ```                                                                                                      │
   │ 105  +  ┌─────────────────────────────────────────────────────────────┐                                          │
   │ 106  +  │                    Presentation Layer                        │                                         │
   │ 107  +  │                      (WinForms)                              │                                         │
   │ 108  +  ├──────────────┬──────────────┬──────────────┬────────────────┤                                          │
   │ 109  +  │ Main Window  │ Project Tree │ Position     │ Invoice        │                                          │
   │ 110  +  │ (MDI Parent) │ Explorer     │ Editor       │ Generator      │                                          │
   │ 111  +  └──────────────┴──────────────┴──────────────┴────────────────┘                                          │
   │ 112  +                             │                                                                             │
   │ 113  +                             ▼                                                                             │
   │ 114  +  ┌─────────────────────────────────────────────────────────────┐                                          │
   │ 115  +  │                  Business Logic Layer                        │                                         │
   │ 116  +  │                  (Domain Services)                           │                                         │
   │ 117  +  ├──────────────┬──────────────┬──────────────┬────────────────┤                                          │
   │ 118  +  │ Project      │ Position     │ Calculation  │ Reporting      │                                          │
   │ 119  +  │ Manager      │ Service      │ Engine       │ Service        │                                          │
   │ 120  +  └──────────────┴──────────────┴──────────────┴────────────────┘                                          │
   │ 121  +                             │                                                                             │
   │ 122  +                             ▼                                                                             │
   │ 123  +  ┌─────────────────────────────────────────────────────────────┐                                          │
   │ 124  +  │                    Data Access Layer                         │                                         │
   │ 125  +  │                  (Repository Pattern)                        │                                         │
   │ 126  +  ├──────────────┬──────────────┬──────────────┬────────────────┤                                          │
   │ 127  +  │ Project      │ Position     │ Customer     │ Import         │                                          │
   │ 128  +  │ Repository   │ Repository   │ Repository   │ Service        │                                          │
   │ 129  +  └──────────────┴──────────────┴──────────────┴────────────────┘                                          │
   │ 130  +                             │                                                                             │
   │ 131  +                             ▼                                                                             │
   │ 132  +  ┌─────────────────────────────────────────────────────────────┐                                          │
   │ 133  +  │                   SQLite Database                            │                                         │
   │ 134  +  │               (Single-file, transactional)                   │                                         │
   │ 135  +  └─────────────────────────────────────────────────────────────┘                                          │
   │ 136  +  ```                                                                                                      │
   │ 137  +                                                                                                           │
   │ 138  +  ### Technology Stack                                                                                     │
   │ 139  +                                                                                                           │
   │ 140  +  | Component | Technology | Rationale |                                                                   │
   │ 141  +  |-----------|-----------|-----------|                                                                    │
   │ 142  +  | Framework | .NET 10 | Latest LTS, modern C# features |                                                 │
   │ 143  +  | UI | WinForms | Native Windows, familiar patterns |                                                    │
   │ 144  +  | Database | SQLite | Single-file, embedded, no server |                                                 │
   │ 145  +  | ORM | Dapper or EF Core | Type-safe queries, migration support |                                       │
   │ 146  +  | Reporting | FastReport / Crystal | Professional invoice generation |                                   │
   │ 147  +  | Testing | xUnit + FluentAssertions | Comprehensive test coverage |                                     │
   │ 148  +  | Logging | Serilog | Structured logging |                                                               │
   │ 149  +                                                                                                           │
   │ 150  +  ### Project Structure                                                                                    │
   │ 151  +                                                                                                           │
   │ 152  +  ```                                                                                                      │
   │ 153  +  Solon.sln                                                                                                │
   │ 154  +  │                                                                                                        │
   │ 155  +  ├─── Solon.Core/                    # Domain models, interfaces                                          │
   │ 156  +  │    ├─── Models/                                                                                        │
   │ 157  +  │    │    ├─── Project.cs                                                                                │
   │ 158  +  │    │    ├─── FourthSum.cs                                                                              │
   │ 159  +  │    │    ├─── Lot.cs                                                                                    │
   │ 160  +  │    │    ├─── Title.cs                                                                                  │
   │ 161  +  │    │    ├─── Position.cs                                                                               │
   │ 162  +  │    │    ├─── Customer.cs                                                                               │
   │ 163  +  │    │    └─── Invoice.cs                                                                                │
   │ 164  +  │    ├─── Interfaces/                                                                                    │
   │ 165  +  │    ├─── Enums/                                                                                         │
   │ 166  +  │    └─── Constants/                                                                                     │
   │ 167  +  │                                                                                                        │
   │ 168  +  ├─── Solon.Data/                    # Data access, repositories                                          │
   │ 169  +  │    ├─── SolonDbContext.cs                                                                              │
   │ 170  +  │    ├─── Repositories/                                                                                  │
   │ 171  +  │    ├─── Migrations/                                                                                    │
   │ 172  +  │    └─── Import/                                                                                        │
   │ 173  +  │         └─── DosImporter.cs                                                                            │
   │ 174  +  │                                                                                                        │
   │ 175  +  ├─── Solon.Business/                # Business logic, services                                           │
   │ 176  +  │    ├─── Services/                                                                                      │
   │ 177  +  │    │    ├─── ProjectService.cs                                                                         │
   │ 178  +  │    │    ├─── PositionService.cs                                                                        │
   │ 179  +  │    │    ├─── CalculationEngine.cs                                                                      │
   │ 180  +  │    │    └─── InvoiceService.cs                                                                         │
   │ 181  +  │    └─── Validators/                                                                                    │
   │ 182  +  │                                                                                                        │
   │ 183  +  ├─── Solon.WinForms/                # UI layer                                                           │
   │ 184  +  │    ├─── Forms/                                                                                         │
   │ 185  +  │    │    ├─── MainForm.cs                                                                               │
   │ 186  +  │    │    ├─── ProjectExplorerForm.cs                                                                    │
   │ 187  +  │    │    ├─── PositionEditorForm.cs                                                                     │
   │ 188  +  │    │    ├─── CustomerForm.cs                                                                           │
   │ 189  +  │    │    └─── InvoiceForm.cs                                                                            │
   │ 190  +  │    ├─── Controls/                                                                                      │
   │ 191  +  │    ├─── Dialogs/                                                                                       │
   │ 192  +  │    └─── Resources/                                                                                     │
   │ 193  +  │                                                                                                        │
   │ 194  +  ├─── Solon.Reporting/               # Report generation                                                  │
   │ 195  +  │    ├─── Templates/                                                                                     │
   │ 196  +  │    └─── Generators/                                                                                    │
   │ 197  +  │                                                                                                        │
   │ 198  +  └─── Solon.Tests/                   # Unit and integration tests                                         │
   │ 199  +       ├─── Unit/                                                                                          │
   │ 200  +       └─── Integration/                                                                                   │
   │ 201  +  ```                                                                                                      │
   │ 202  +                                                                                                           │
   │ 203  +  ---                                                                                                      │
   │ 204  +                                                                                                           │
   │ 205  +  ## Data Migration Strategy                                                                               │
   │ 206  +                                                                                                           │
   │ 207  +  ### Phase 1: Analysis and Import Tool                                                                    │
   │ 208  +                                                                                                           │
   │ 209  +  **Objective:** Read all DOS project data and validate structure                                          │
   │ 210  +                                                                                                           │
   │ 211  +  **Implementation:**                                                                                      │
   │ 212  +  1. Create `DosProjectScanner` class                                                                      │
   │ 213  +     - Recursively scan C:\ partition structure                                                            │
   │ 214  +     - Identify all .PRJ directories                                                                       │
   │ 215  +     - Catalog files by extension                                                                          │
   │ 216  +     - Detect encoding (likely CP437 or CP850)                                                             │
   │ 217  +                                                                                                           │
   │ 218  +  2. Create `DosDataReader` classes                                                                        │
   │ 219  +     - `ProjectDefinitionReader` (.SOL files)                                                              │
   │ 220  +     - `PositionReader` (.POS files)                                                                       │
   │ 221  +     - `TitleReader` (.TIT files)                                                                          │
   │ 222  +     - `CustomerReader` (KUNDEN.DAT)                                                                       │
   │ 223  +                                                                                                           │
   │ 224  +  3. Build validation report                                                                               │
   │ 225  +     - Count projects, titles, positions                                                                   │
   │ 226  +     - Identify file format inconsistencies                                                                │
   │ 227  +     - Flag unreadable files                                                                               │
   │ 228  +     - Generate migration readiness report                                                                 │
   │ 229  +                                                                                                           │
   │ 230  +  ### Phase 2: Schema Mapping                                                                              │
   │ 231  +                                                                                                           │
   │ 232  +  **DOS Structure → SQLite Schema**                                                                        │
   │ 233  +                                                                                                           │
   │ 234  +  | DOS Element | SQLite Table | Notes |                                                                   │
   │ 235  +  |-------------|--------------|-------|                                                                   │
   │ 236  +  | Project directory | `Projects` | Single record per project |                                           │
   │ 237  +  | PRJKTDEF.SOL | `Projects` | Project metadata |                                                         │
   │ 238  +  | 4SUMME*.4SM | `FourthSums` | Highest level grouping |                                                  │
   │ 239  +  | LOS*.PRK | `Lots` | Lot grouping |                                                                     │
   │ 240  +  | *.TIT directory | `Titles` | Title records |                                                           │
   │ 241  +  | *.POS file | `Positions` | Position details |                                                          │
   │ 242  +  | KUNDEN.DAT | `Customers` | Customer master data |                                                      │
   │ 243  +  | POSITION.PRK | `PositionIndex` | Match code index |                                                    │
   │ 244  +                                                                                                           │
   │ 245  +  ### Phase 3: Data Import Process                                                                         │
   │ 246  +                                                                                                           │
   │ 247  +  **Import Algorithm:**                                                                                    │
   │ 248  +                                                                                                           │
   │ 249  +  ```csharp                                                                                                │
   │ 250  +  public class DosImporter                                                                                 │
   │ 251  +  {                                                                                                        │
   │ 252  +      public async Task<ImportResult> ImportProject(string dosProjectPath)                                 │
   │ 253  +      {                                                                                                    │
   │ 254  +          using var transaction = await _dbContext.Database.BeginTransactionAsync();                       │
   │ 255  +                                                                                                           │
   │ 256  +          try                                                                                              │
   │ 257  +          {                                                                                                │
   │ 258  +              // 1. Read project definition                                                                │
   │ 259  +              var projectDef = ReadProjectDefinition(dosProjectPath);                                      │
   │ 260  +              var project = MapToProject(projectDef);                                                      │
   │ 261  +              await _projectRepo.AddAsync(project);                                                        │
   │ 262  +                                                                                                           │
   │ 263  +              // 2. Import hierarchy                                                                       │
   │ 264  +              await ImportFourthSums(dosProjectPath, project.Id);                                          │
   │ 265  +              await ImportLots(dosProjectPath, project.Id);                                                │
   │ 266  +              await ImportTitles(dosProjectPath, project.Id);                                              │
   │ 267  +              await ImportPositions(dosProjectPath, project.Id);                                           │
   │ 268  +                                                                                                           │
   │ 269  +              // 3. Import customers if referenced                                                         │
   │ 270  +              await ImportReferencedCustomers(projectDef);                                                 │
   │ 271  +                                                                                                           │
   │ 272  +              // 4. Validate totals                                                                        │
   │ 273  +              var validationResult = ValidateImportedData(project.Id);                                     │
   │ 274  +              if (!validationResult.IsValid)                                                               │
   │ 275  +              {                                                                                            │
   │ 276  +                  throw new ImportValidationException(validationResult.Errors);                            │
   │ 277  +              }                                                                                            │
   │ 278  +                                                                                                           │
   │ 279  +              await transaction.CommitAsync();                                                             │
   │ 280  +              return ImportResult.Success(project.Id);                                                     │
   │ 281  +          }                                                                                                │
   │ 282  +          catch (Exception ex)                                                                             │
   │ 283  +          {                                                                                                │
   │ 284  +              await transaction.RollbackAsync();                                                           │
   │ 285  +              return ImportResult.Failure(ex.Message);                                                     │
   │ 286  +          }                                                                                                │
   │ 287  +      }                                                                                                    │
   │ 288  +  }                                                                                                        │
   │ 289  +  ```                                                                                                      │
   │ 290  +                                                                                                           │
   │ 291  +  ### Phase 4: Import Verification                                                                         │
   │ 292  +                                                                                                           │
   │ 293  +  **Verification Steps:**                                                                                  │
   │ 294  +  1. Compare record counts (DOS vs SQLite)                                                                 │
   │ 295  +  2. Recalculate all totals and compare                                                                    │
   │ 296  +  3. Verify hierarchy integrity (all children have parents)                                                │
   │ 297  +  4. Check for data loss (field truncation, encoding issues)                                               │
   │ 298  +  5. Generate detailed import log                                                                          │
   │ 299  +                                                                                                           │
   │ 300  +  **Import UI:**                                                                                           │
   │ 301  +  - Progress dialog with detailed status                                                                   │
   │ 302  +  - Preview mode (dry run without commit)                                                                  │
   │ 303  +  - Selective import (choose specific projects)                                                            │
   │ 304  +  - Error reporting with retry capability                                                                  │
   │ 305  +                                                                                                           │
   │ 306  +  ---                                                                                                      │
   │ 307  +                                                                                                           │
   │ 308  +  ## Database Schema Design                                                                                │
   │ 309  +                                                                                                           │
   │ 310  +  ### Core Tables                                                                                          │
   │ 311  +                                                                                                           │
   │ 312  +  #### Projects Table                                                                                      │
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

 ✓ Edit docs\spec\Part3-Domain-Specific-Specs.md (+1395)
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
   │  311                                                                                                             │
   │  312     #### Projects Table                                                                                     │
   │  313                                                                                                             │
   │  314  +  ```sql                                                                                                  │
   │  315  +  CREATE TABLE Projects (                                                                                 │
   │  316  +      ProjectId INTEGER PRIMARY KEY AUTOINCREMENT,                                                        │
   │  317  +      ProjectNumber TEXT NOT NULL UNIQUE,  -- e.g., "10", "20"                                            │
   │  318  +      ProjectName TEXT NOT NULL,           -- e.g., "Sample Project"                                      │
   │  319  +      CreatedDate DATETIME NOT NULL,                                                                      │
   │  320  +      ModifiedDate DATETIME NOT NULL,                                                                     │
   │  321  +      CustomerId INTEGER,                                                                                 │
   │  322  +      Status TEXT CHECK(Status IN ('Active', 'Archived', 'Completed')),                                   │
   │  323  +      Notes TEXT,                                                                                         │
   │  324  +      -- Original DOS paths for reference                                                                 │
   │  325  +      OriginalDosPath TEXT,                                                                               │
   │  326  +      ImportedDate DATETIME,                                                                              │
   │  327  +      FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)                                           │
   │  328  +  );                                                                                                      │
   │  329  +                                                                                                          │
   │  330  +  CREATE INDEX IX_Projects_ProjectNumber ON Projects(ProjectNumber);                                      │
   │  331  +  CREATE INDEX IX_Projects_CustomerId ON Projects(CustomerId);                                            │
   │  332  +  ```                                                                                                     │
   │  333  +                                                                                                          │
   │  334  +  #### FourthSums Table                                                                                   │
   │  335  +                                                                                                          │
   │  336  +  ```sql                                                                                                  │
   │  337  +  CREATE TABLE FourthSums (                                                                               │
   │  338  +      FourthSumId INTEGER PRIMARY KEY AUTOINCREMENT,                                                      │
   │  339  +      ProjectId INTEGER NOT NULL,                                                                         │
   │  340  +      Code TEXT NOT NULL,              -- e.g., "4SSYSTEM"                                                │
   │  341  +      Description TEXT NOT NULL,                                                                          │
   │  342  +      SortOrder INTEGER NOT NULL,                                                                         │
   │  343  +      TotalAmount DECIMAL(18,2),       -- Calculated total                                                │
   │  344  +      FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId) ON DELETE CASCADE,                           │
   │  345  +      UNIQUE(ProjectId, Code)                                                                             │
   │  346  +  );                                                                                                      │
   │  347  +                                                                                                          │
   │  348  +  CREATE INDEX IX_FourthSums_ProjectId ON FourthSums(ProjectId);                                          │
   │  349  +  ```                                                                                                     │
   │  350  +                                                                                                          │
   │  351  +  #### Lots Table                                                                                         │
   │  352  +                                                                                                          │
   │  353  +  ```sql                                                                                                  │
   │  354  +  CREATE TABLE Lots (                                                                                     │
   │  355  +      LotId INTEGER PRIMARY KEY AUTOINCREMENT,                                                            │
   │  356  +      FourthSumId INTEGER NOT NULL,                                                                       │
   │  357  +      Code TEXT NOT NULL,              -- e.g., "LOSSYSTM"                                                │
   │  358  +      Description TEXT NOT NULL,                                                                          │
   │  359  +      SortOrder INTEGER NOT NULL,                                                                         │
   │  360  +      TotalAmount DECIMAL(18,2),                                                                          │
   │  361  +      FOREIGN KEY (FourthSumId) REFERENCES FourthSums(FourthSumId) ON DELETE CASCADE,                     │
   │  362  +      UNIQUE(FourthSumId, Code)                                                                           │
   │  363  +  );                                                                                                      │
   │  364  +                                                                                                          │
   │  365  +  CREATE INDEX IX_Lots_FourthSumId ON Lots(FourthSumId);                                                  │
   │  366  +  ```                                                                                                     │
   │  367  +                                                                                                          │
   │  368  +  #### Titles Table                                                                                       │
   │  369  +                                                                                                          │
   │  370  +  ```sql                                                                                                  │
   │  371  +  CREATE TABLE Titles (                                                                                   │
   │  372  +      TitleId INTEGER PRIMARY KEY AUTOINCREMENT,                                                          │
   │  373  +      LotId INTEGER NOT NULL,                                                                             │
   │  374  +      TitleNumber TEXT NOT NULL,       -- e.g., "0010"                                                    │
   │  375  +      Description TEXT NOT NULL,                                                                          │
   │  376  +      SortOrder INTEGER NOT NULL,                                                                         │
   │  377  +      TotalAmount DECIMAL(18,2),                                                                          │
   │  378  +      PositionCount INTEGER DEFAULT 0,                                                                    │
   │  379  +      FOREIGN KEY (LotId) REFERENCES Lots(LotId) ON DELETE CASCADE,                                       │
   │  380  +      UNIQUE(LotId, TitleNumber)                                                                          │
   │  381  +  );                                                                                                      │
   │  382  +                                                                                                          │
   │  383  +  CREATE INDEX IX_Titles_LotId ON Titles(LotId);                                                          │
   │  384  +  ```                                                                                                     │
   │  385  +                                                                                                          │
   │  386  +  #### Positions Table                                                                                    │
   │  387  +                                                                                                          │
   │  388  +  ```sql                                                                                                  │
   │  389  +  CREATE TABLE Positions (                                                                                │
   │  390  +      PositionId INTEGER PRIMARY KEY AUTOINCREMENT,                                                       │
   │  391  +      TitleId INTEGER NOT NULL,                                                                           │
   │  392  +      PositionNumber TEXT NOT NULL,    -- e.g., "00010#"                                                  │
   │  393  +      MatchCode TEXT,                  -- Quick search code                                               │
   │  394  +      ShortDescription TEXT NOT NULL,  -- Brief description                                               │
   │  395  +      LongDescription TEXT,            -- Detailed specification                                          │
   │  396  +      -- Dimension fields                                                                                 │
   │  397  +      Dimension1 DECIMAL(18,3),        -- Length, width, or quantity                                      │
   │  398  +      Dimension2 DECIMAL(18,3),        -- Width or height                                                 │
   │  399  +      Dimension3 DECIMAL(18,3),        -- Height or depth                                                 │
   │  400  +      CalculatedQuantity DECIMAL(18,3), -- Result of dimension calculation                                │
   │  401  +      Unit TEXT,                       -- e.g., "m³", "m²", "Stk"                                         │
   │  402  +      -- Pricing                                                                                          │
   │  403  +      UnitPrice DECIMAL(18,4),         -- Price per unit (Einheitspreis)                                  │
   │  404  +      TotalPrice DECIMAL(18,2),        -- Calculated: Quantity * UnitPrice                                │
   │  405  +      -- Metadata                                                                                         │
   │  406  +      CreatedDate DATETIME NOT NULL,                                                                      │
   │  407  +      ModifiedDate DATETIME NOT NULL,                                                                     │
   │  408  +      Notes TEXT,                                                                                         │
   │  409  +      FOREIGN KEY (TitleId) REFERENCES Titles(TitleId) ON DELETE CASCADE,                                 │
   │  410  +      UNIQUE(TitleId, PositionNumber)                                                                     │
   │  411  +  );                                                                                                      │
   │  412  +                                                                                                          │
   │  413  +  CREATE INDEX IX_Positions_TitleId ON Positions(TitleId);                                                │
   │  414  +  CREATE INDEX IX_Positions_MatchCode ON Positions(MatchCode);                                            │
   │  415  +  CREATE INDEX IX_Positions_PositionNumber ON Positions(PositionNumber);                                  │
   │  416  +  ```                                                                                                     │
   │  417  +                                                                                                          │
   │  418  +  #### Customers Table                                                                                    │
   │  419  +                                                                                                          │
   │  420  +  ```sql                                                                                                  │
   │  421  +  CREATE TABLE Customers (                                                                                │
   │  422  +      CustomerId INTEGER PRIMARY KEY AUTOINCREMENT,                                                       │
   │  423  +      CustomerNumber TEXT NOT NULL UNIQUE,                                                                │
   │  424  +      CompanyName TEXT NOT NULL,                                                                          │
   │  425  +      ContactPerson TEXT,                                                                                 │
   │  426  +      Street TEXT,                                                                                        │
   │  427  +      PostalCode TEXT,                                                                                    │
   │  428  +      City TEXT,                                                                                          │
   │  429  +      Country TEXT DEFAULT 'Deutschland',                                                                 │
   │  430  +      Phone TEXT,                                                                                         │
   │  431  +      Fax TEXT,                                                                                           │
   │  432  +      Email TEXT,                                                                                         │
   │  433  +      TaxId TEXT,                      -- Steuernummer                                                    │
   │  434  +      VatId TEXT,                      -- USt-IdNr                                                        │
   │  435  +      PaymentTerms TEXT,               -- e.g., "14 Tage 2% Skonto, 30 Tage netto"                        │
   │  436  +      DefaultDiscount DECIMAL(5,2),    -- Default discount percentage                                     │
   │  437  +      Notes TEXT,                                                                                         │
   │  438  +      CreatedDate DATETIME NOT NULL,                                                                      │
   │  439  +      ModifiedDate DATETIME NOT NULL                                                                      │
   │  440  +  );                                                                                                      │
   │  441  +                                                                                                          │
   │  442  +  CREATE INDEX IX_Customers_CustomerNumber ON Customers(CustomerNumber);                                  │
   │  443  +  ```                                                                                                     │
   │  444  +                                                                                                          │
   │  445  +  #### Invoices Table                                                                                     │
   │  446  +                                                                                                          │
   │  447  +  ```sql                                                                                                  │
   │  448  +  CREATE TABLE Invoices (                                                                                 │
   │  449  +      InvoiceId INTEGER PRIMARY KEY AUTOINCREMENT,                                                        │
   │  450  +      ProjectId INTEGER NOT NULL,                                                                         │
   │  451  +      CustomerId INTEGER NOT NULL,                                                                        │
   │  452  +      InvoiceNumber TEXT NOT NULL UNIQUE,                                                                 │
   │  453  +      InvoiceDate DATE NOT NULL,                                                                          │
   │  454  +      InvoiceType TEXT CHECK(InvoiceType IN ('Angebot', 'Rechnung', 'Abschlag', 'Schlussrechnung')),      │
   │  455  +      -- Amounts                                                                                          │
   │  456  +      NetAmount DECIMAL(18,2) NOT NULL,                                                                   │
   │  457  +      VatRate DECIMAL(5,2) NOT NULL,   -- e.g., 19.00 for 19%                                             │
   │  458  +      VatAmount DECIMAL(18,2) NOT NULL,                                                                   │
   │  459  +      GrossAmount DECIMAL(18,2) NOT NULL,                                                                 │
   │  460  +      -- Adjustments                                                                                      │
   │  461  +      DiscountPercent DECIMAL(5,2),                                                                       │
   │  462  +      DiscountAmount DECIMAL(18,2),                                                                       │
   │  463  +      SurchargeAmount DECIMAL(18,2),                                                                      │
   │  464  +      RetentionPercent DECIMAL(5,2),                                                                      │
   │  465  +      RetentionAmount DECIMAL(18,2),                                                                      │
   │  466  +      -- Payment                                                                                          │
   │  467  +      PaymentTerms TEXT,                                                                                  │
   │  468  +      DueDate DATE,                                                                                       │
   │  469  +      PaidDate DATE,                                                                                      │
   │  470  +      PaidAmount DECIMAL(18,2),                                                                           │
   │  471  +      -- Content                                                                                          │
   │  472  +      HeaderText TEXT,                                                                                    │
   │  473  +      FooterText TEXT,                                                                                    │
   │  474  +      Notes TEXT,                                                                                         │
   │  475  +      -- Metadata                                                                                         │
   │  476  +      CreatedDate DATETIME NOT NULL,                                                                      │
   │  477  +      ModifiedDate DATETIME NOT NULL,                                                                     │
   │  478  +      PrintedDate DATETIME,                                                                               │
   │  479  +      FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId),                                             │
   │  480  +      FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)                                           │
   │  481  +  );                                                                                                      │
   │  482  +                                                                                                          │
   │  483  +  CREATE INDEX IX_Invoices_ProjectId ON Invoices(ProjectId);                                              │
   │  484  +  CREATE INDEX IX_Invoices_CustomerId ON Invoices(CustomerId);                                            │
   │  485  +  CREATE INDEX IX_Invoices_InvoiceNumber ON Invoices(InvoiceNumber);                                      │
   │  486  +  ```                                                                                                     │
   │  487  +                                                                                                          │
   │  488  +  #### InvoiceLineItems Table                                                                             │
   │  489  +                                                                                                          │
   │  490  +  ```sql                                                                                                  │
   │  491  +  CREATE TABLE InvoiceLineItems (                                                                         │
   │  492  +      LineItemId INTEGER PRIMARY KEY AUTOINCREMENT,                                                       │
   │  493  +      InvoiceId INTEGER NOT NULL,                                                                         │
   │  494  +      PositionId INTEGER,              -- NULL for free-text items                                        │
   │  495  +      LineNumber INTEGER NOT NULL,                                                                        │
   │  496  +      Description TEXT NOT NULL,                                                                          │
   │  497  +      Quantity DECIMAL(18,3),                                                                             │
   │  498  +      Unit TEXT,                                                                                          │
   │  499  +      UnitPrice DECIMAL(18,4),                                                                            │
   │  500  +      TotalPrice DECIMAL(18,2),                                                                           │
   │  501  +      FOREIGN KEY (InvoiceId) REFERENCES Invoices(InvoiceId) ON DELETE CASCADE,                           │
   │  502  +      FOREIGN KEY (PositionId) REFERENCES Positions(PositionId)                                           │
   │  503  +  );                                                                                                      │
   │  504  +                                                                                                          │
   │  505  +  CREATE INDEX IX_InvoiceLineItems_InvoiceId ON InvoiceLineItems(InvoiceId);                              │
   │  506  +  ```                                                                                                     │
   │  507  +                                                                                                          │
   │  508  +  ### Supporting Tables                                                                                   │
   │  509  +                                                                                                          │
   │  510  +  #### AuditLog Table                                                                                     │
   │  511  +                                                                                                          │
   │  512  +  ```sql                                                                                                  │
   │  513  +  CREATE TABLE AuditLog (                                                                                 │
   │  514  +      AuditId INTEGER PRIMARY KEY AUTOINCREMENT,                                                          │
   │  515  +      TableName TEXT NOT NULL,                                                                            │
   │  516  +      RecordId INTEGER NOT NULL,                                                                          │
   │  517  +      Operation TEXT CHECK(Operation IN ('INSERT', 'UPDATE', 'DELETE')),                                  │
   │  518  +      OldValues TEXT,                  -- JSON                                                            │
   │  519  +      NewValues TEXT,                  -- JSON                                                            │
   │  520  +      ChangedBy TEXT,                                                                                     │
   │  521  +      ChangedDate DATETIME NOT NULL                                                                       │
   │  522  +  );                                                                                                      │
   │  523  +                                                                                                          │
   │  524  +  CREATE INDEX IX_AuditLog_TableName ON AuditLog(TableName, RecordId);                                    │
   │  525  +  ```                                                                                                     │
   │  526  +                                                                                                          │
   │  527  +  #### Settings Table                                                                                     │
   │  528  +                                                                                                          │
   │  529  +  ```sql                                                                                                  │
   │  530  +  CREATE TABLE Settings (                                                                                 │
   │  531  +      SettingKey TEXT PRIMARY KEY,                                                                        │
   │  532  +      SettingValue TEXT,                                                                                  │
   │  533  +      Description TEXT,                                                                                   │
   │  534  +      ModifiedDate DATETIME NOT NULL                                                                      │
   │  535  +  );                                                                                                      │
   │  536  +                                                                                                          │
   │  537  +  -- Default settings                                                                                     │
   │  538  +  INSERT INTO Settings VALUES                                                                             │
   │  539  +      ('DefaultVatRate', '19.00', 'Default VAT rate in percent', datetime('now')),                        │
   │  540  +      ('CompanyName', '', 'Company name for invoices', datetime('now')),                                  │
   │  541  +      ('CompanyAddress', '', 'Company address for invoices', datetime('now')),                            │
   │  542  +      ('InvoiceNumberPrefix', 'RE', 'Prefix for invoice numbers', datetime('now')),                       │
   │  543  +      ('NextInvoiceNumber', '1', 'Next invoice number', datetime('now'));                                 │
   │  544  +  ```                                                                                                     │
   │  545  +                                                                                                          │
   │  546  +  ### Database Constraints and Business Rules                                                             │
   │  547  +                                                                                                          │
   │  548  +  **Calculated Fields (via Triggers):**                                                                   │
   │  549  +                                                                                                          │
   │  550  +  ```sql                                                                                                  │
   │  551  +  -- Automatically update Position.TotalPrice                                                             │
   │  552  +  CREATE TRIGGER trg_Position_CalculateTotalPrice                                                         │
   │  553  +  AFTER INSERT ON Positions                                                                               │
   │  554  +  BEGIN                                                                                                   │
   │  555  +      UPDATE Positions                                                                                    │
   │  556  +      SET TotalPrice = CalculatedQuantity * UnitPrice                                                     │
   │  557  +      WHERE PositionId = NEW.PositionId;                                                                  │
   │  558  +  END;                                                                                                    │
   │  559  +                                                                                                          │
   │  560  +  CREATE TRIGGER trg_Position_UpdateTotalPrice                                                            │
   │  561  +  AFTER UPDATE OF CalculatedQuantity, UnitPrice ON Positions                                              │
   │  562  +  BEGIN                                                                                                   │
   │  563  +      UPDATE Positions                                                                                    │
   │  564  +      SET TotalPrice = NEW.CalculatedQuantity * NEW.UnitPrice                                             │
   │  565  +      WHERE PositionId = NEW.PositionId;                                                                  │
   │  566  +  END;                                                                                                    │
   │  567  +                                                                                                          │
   │  568  +  -- Update Title totals                                                                                  │
   │  569  +  CREATE TRIGGER trg_Title_UpdateTotal                                                                    │
   │  570  +  AFTER UPDATE OF TotalPrice ON Positions                                                                 │
   │  571  +  BEGIN                                                                                                   │
   │  572  +      UPDATE Titles                                                                                       │
   │  573  +      SET TotalAmount = (                                                                                 │
   │  574  +          SELECT COALESCE(SUM(TotalPrice), 0)                                                             │
   │  575  +          FROM Positions                                                                                  │
   │  576  +          WHERE TitleId = NEW.TitleId                                                                     │
   │  577  +      )                                                                                                   │
   │  578  +      WHERE TitleId = NEW.TitleId;                                                                        │
   │  579  +  END;                                                                                                    │
   │  580  +                                                                                                          │
   │  581  +  -- Update Lot totals                                                                                    │
   │  582  +  CREATE TRIGGER trg_Lot_UpdateTotal                                                                      │
   │  583  +  AFTER UPDATE OF TotalAmount ON Titles                                                                   │
   │  584  +  BEGIN                                                                                                   │
   │  585  +      UPDATE Lots                                                                                         │
   │  586  +      SET TotalAmount = (                                                                                 │
   │  587  +          SELECT COALESCE(SUM(TotalAmount), 0)                                                            │
   │  588  +          FROM Titles                                                                                     │
   │  589  +          WHERE LotId = (SELECT LotId FROM Titles WHERE TitleId = NEW.TitleId)                            │
   │  590  +      )                                                                                                   │
   │  591  +      WHERE LotId = (SELECT LotId FROM Titles WHERE TitleId = NEW.TitleId);                               │
   │  592  +  END;                                                                                                    │
   │  593  +  ```                                                                                                     │
   │  594  +                                                                                                          │
   │  595  +  ---                                                                                                     │
   │  596  +                                                                                                          │
   │  597  +  ## User Interface Specifications                                                                        │
   │  598  +                                                                                                          │
   │  599  +  ### Main Window (MDI Container)                                                                         │
   │  600  +                                                                                                          │
   │  601  +  **Layout:**                                                                                             │
   │  602  +                                                                                                          │
   │  603  +  ```                                                                                                     │
   │  604  +  ╔═══════════════════════════════════════════════════════════════╗                                       │
   │  605  +  ║ SOLON - Massenermittlung                                  [_][□][X]                                   │
   │  606  +  ╠═══════════════════════════════════════════════════════════════╣                                       │
   │  607  +  ║ [File] [Edit] [Project] [Position] [Invoice] [Tools] [Help]  ║                                        │
   │  608  +  ╠═══════════════════════════════════════════════════════════════╣                                       │
   │  609  +  ║ [New] [Open] [Save] | [Cut] [Copy] [Paste] | [Print] [PDF]   ║                                        │
   │  610  +  ╠════════════════════╦══════════════════════════════════════════╣                                       │
   │  611  +  ║ Project Explorer   ║                                          ║                                       │
   │  612  +  ║ ┬ 10 - Sample Proj ║   [Position Editor / Invoice View]      ║                                        │
   │  613  +  ║ ├─┬ 4SSYSTEM       ║                                          ║                                       │
   │  614  +  ║ │ └─┬ LOSSYSTM     ║      (MDI Child Window Area)            ║                                        │
   │  615  +  ║ │   └─┬ 0010 Titel ║                                          ║                                       │
   │  616  +  ║ │     ├─ Pos 00010#║                                          ║                                       │
   │  617  +  ║ │     └─ Pos 00020#║                                          ║                                       │
   │  618  +  ║ └─┬ Other 4Sum     ║                                          ║                                       │
   │  619  +  ║   └─ ...           ║                                          ║                                       │
   │  620  +  ║                    ║                                          ║                                       │
   │  621  +  ║ [+] [-] [Edit]     ║                                          ║                                       │
   │  622  +  ╠════════════════════╩══════════════════════════════════════════╣                                       │
   │  623  +  ║ Ready | Project: 10 | Positions: 234 | Total: 123.456,78 EUR ║                                        │
   │  624  +  ╚═══════════════════════════════════════════════════════════════╝                                       │
   │  625  +  ```                                                                                                     │
   │  626  +                                                                                                          │
   │  627  +  **Menu Structure:**                                                                                     │
   │  628  +                                                                                                          │
   │  629  +  **File Menu:**                                                                                          │
   │  630  +  - New Project (Ctrl+N)                                                                                  │
   │  631  +  - Open Project (Ctrl+O)                                                                                 │
   │  632  +  - Close Project                                                                                         │
   │  633  +  - ---                                                                                                   │
   │  634  +  - Import DOS Project (Ctrl+I)                                                                           │
   │  635  +  - Export to Excel                                                                                       │
   │  636  +  - ---                                                                                                   │
   │  637  +  - Recent Projects ▶                                                                                    │
   │  638  +  - ---                                                                                                   │
   │  639  +  - Exit (Alt+F4)                                                                                         │
   │  640  +                                                                                                          │
   │  641  +  **Edit Menu:**                                                                                          │
   │  642  +  - Undo (Ctrl+Z)                                                                                         │
   │  643  +  - Redo (Ctrl+Y)                                                                                         │
   │  644  +  - ---                                                                                                   │
   │  645  +  - Cut (Ctrl+X)                                                                                          │
   │  646  +  - Copy (Ctrl+C)                                                                                         │
   │  647  +  - Paste (Ctrl+V)                                                                                        │
   │  648  +  - Delete (Del)                                                                                          │
   │  649  +  - ---                                                                                                   │
   │  650  +  - Find (Ctrl+F)                                                                                         │
   │  651  +  - Find Next (F3)                                                                                        │
   │  652  +                                                                                                          │
   │  653  +  **Project Menu:**                                                                                       │
   │  654  +  - Project Properties                                                                                    │
   │  655  +  - Project Settings                                                                                      │
   │  656  +  - ---                                                                                                   │
   │  657  +  - Add 4th Sum                                                                                           │
   │  658  +  - Add Lot                                                                                               │
   │  659  +  - Add Title                                                                                             │
   │  660  +  - ---                                                                                                   │
   │  661  +  - Recalculate Totals                                                                                    │
   │  662  +  - Validate Hierarchy                                                                                    │
   │  663  +                                                                                                          │
   │  664  +  **Position Menu:**                                                                                      │
   │  665  +  - New Position (Ins)                                                                                    │
   │  666  +  - Edit Position (Enter)                                                                                 │
   │  667  +  - Delete Position (Del)                                                                                 │
   │  668  +  - Duplicate Position (Ctrl+D)                                                                           │
   │  669  +  - ---                                                                                                   │
   │  670  +  - Position Properties                                                                                   │
   │  671  +  - Match Code Manager                                                                                    │
   │  672  +                                                                                                          │
   │  673  +  **Invoice Menu:**                                                                                       │
   │  674  +  - Generate Invoice                                                                                      │
   │  675  +  - Generate Quote (Angebot)                                                                              │
   │  676  +  - Partial Invoice (Abschlag)                                                                            │
   │  677  +  - Final Invoice (Schlussrechnung)                                                                       │
   │  678  +  - ---                                                                                                   │
   │  679  +  - Invoice Templates                                                                                     │
   │  680  +  - Invoice History                                                                                       │
   │  681  +                                                                                                          │
   │  682  +  **Tools Menu:**                                                                                         │
   │  683  +  - Customer Management                                                                                   │
   │  684  +  - Settings                                                                                              │
   │  685  +  - Backup Database                                                                                       │
   │  686  +  - Restore Database                                                                                      │
   │  687  +  - ---                                                                                                   │
   │  688  +  - Database Maintenance                                                                                  │
   │  689  +  - Import Log Viewer                                                                                     │
   │  690  +                                                                                                          │
   │  691  +  **Help Menu:**                                                                                          │
   │  692  +  - User Manual (F1)                                                                                      │
   │  693  +  - About SOLON                                                                                           │
   │  694  +                                                                                                          │
   │  695  +  ### Project Explorer (Dockable Panel)                                                                   │
   │  696  +                                                                                                          │
   │  697  +  **TreeView Configuration:**                                                                             │
   │  698  +  - Icons for each level (distinctive visual hierarchy)                                                   │
   │  699  +  - Context menu per node type                                                                            │
   │  700  +  - Drag-and-drop support for reordering                                                                  │
   │  701  +  - Double-click to edit                                                                                  │
   │  702  +  - Bold font for totals                                                                                  │
   │  703  +                                                                                                          │
   │  704  +  **Node Context Menus:**                                                                                 │
   │  705  +                                                                                                          │
   │  706  +  **Project Node:**                                                                                       │
   │  707  +  - Open                                                                                                  │
   │  708  +  - Properties                                                                                            │
   │  709  +  - Close                                                                                                 │
   │  710  +  - ---                                                                                                   │
   │  711  +  - Delete Project                                                                                        │
   │  712  +                                                                                                          │
   │  713  +  **4th Sum Node:**                                                                                       │
   │  714  +  - Add Lot                                                                                               │
   │  715  +  - Edit                                                                                                  │
   │  716  +  - Delete                                                                                                │
   │  717  +  - ---                                                                                                   │
   │  718  +  - Expand All                                                                                            │
   │  719  +  - Collapse All                                                                                          │
   │  720  +                                                                                                          │
   │  721  +  **Lot Node:**                                                                                           │
   │  722  +  - Add Title                                                                                             │
   │  723  +  - Edit                                                                                                  │
   │  724  +  - Delete                                                                                                │
   │  725  +  - ---                                                                                                   │
   │  726  +  - Move to Different 4th Sum                                                                             │
   │  727  +                                                                                                          │
   │  728  +  **Title Node:**                                                                                         │
   │  729  +  - Add Position                                                                                          │
   │  730  +  - Edit                                                                                                  │
   │  731  +  - Delete                                                                                                │
   │  732  +  - ---                                                                                                   │
   │  733  +  - Move to Different Lot                                                                                 │
   │  734  +  - ---                                                                                                   │
   │  735  +  - Print Title Report                                                                                    │
   │  736  +                                                                                                          │
   │  737  +  **Position Node:**                                                                                      │
   │  738  +  - Edit                                                                                                  │
   │  739  +  - Duplicate                                                                                             │
   │  740  +  - Delete                                                                                                │
   │  741  +  - ---                                                                                                   │
   │  742  +  - View History                                                                                          │
   │  743  +                                                                                                          │
   │  744  +  ### Position Editor Form                                                                                │
   │  745                                                                                                             │
   │  746  +  **Layout (Modal Dialog or MDI Child):**                                                                 │
   │  747  +                                                                                                          │
   │  748  +  ```                                                                                                     │
   │  749  +  ╔═══════════════════════════════════════════════════════════════╗                                       │
   │  750  +  ║ Position Editor - Title 0010                          [_][□][X]                                       │
   │  751  +  ╠═══════════════════════════════════════════════════════════════╣                                       │
   │  752  +  ║ Position Number: [00010#    ]  Match Code: [BETP25   ]       ║                                        │
   │  753  +  ║                                                                ║                                      │
   │  754  +  ║ Short Description:                                             ║                                      │
   │  755  +  ║ ┌────────────────────────────────────────────────────────────┐║                                       │
   │  756  +  ║ │ Beton C25/30, Fundament                                    │║                                       │
   │  757  +  ║ └────────────────────────────────────────────────────────────┘║                                       │
   │  758  +  ║                                                                ║                                      │
   │  759  +  ║ Long Description:                                              ║                                      │
   │  760  +  ║ ┌────────────────────────────────────────────────────────────┐║                                       │
   │  761  +  ║ │ Fundamentbeton C25/30 gemäß DIN 1045                       │║                                       │
   │  762  +  ║ │ einschließlich Schalung, Bewehrung und Verdichtung        │║                                        │
   │  763  +  ║ │                                                            │║                                       │
   │  764  +  ║ └────────────────────────────────────────────────────────────┘║                                       │
   │  765  +  ║                                                                ║                                      │
   │  766  +  ║ ┌─ Dimensions ─────────────────────────────────────────────┐ ║                                        │
   │  767  +  ║ │ Dim 1: [  12.50] × Dim 2: [   8.00] × Dim 3: [  0.40]   │ ║                                         │
   │  768  +  ║ │                                                           │ ║                                       │
   │  769  +  ║ │ Calculated Quantity: [  40.00]  Unit: [m³ ▼]            │ ║                                         │
   │  770  +  ║ └───────────────────────────────────────────────────────────┘ ║                                       │
   │  771  +  ║                                                                ║                                      │
   │  772  +  ║ ┌─ Pricing ────────────────────────────────────────────────┐ ║                                        │
   │  773  +  ║ │ Unit Price:      [    125.50] EUR/m³                     │ ║                                        │
   │  774  +  ║ │ Total Price:     [  5,020.00] EUR                        │ ║                                        │
   │  775  +  ║ └───────────────────────────────────────────────────────────┘ ║                                       │
   │  776  +  ║                                                                ║                                      │
   │  777  +  ║ Notes:                                                         ║                                      │
   │  778  +  ║ ┌────────────────────────────────────────────────────────────┐║                                       │
   │  779  +  ║ │                                                            │║                                       │
   │  780  +  ║ └────────────────────────────────────────────────────────────┘║                                       │
   │  781  +  ║                                                                ║                                      │
   │  782  +  ║                           [OK]  [Cancel]  [Apply]             ║                                       │
   │  783  +  ╚═══════════════════════════════════════════════════════════════╝                                       │
   │  784  +  ```                                                                                                     │
   │  785  +                                                                                                          │
   │  786  +  **Field Validation:**                                                                                   │
   │  787  +  - Position Number: Required, unique within Title                                                        │
   │  788  +  - Short Description: Required, max 80 characters                                                        │
   │  789  +  - Dimensions: Numeric, 3 decimal places                                                                 │
   │  790  +  - Unit Price: Numeric, 4 decimal places                                                                 │
   │  791  +  - Auto-calculate Total Price on any change                                                              │
   │  792  +                                                                                                          │
   │  793  +  **Keyboard Shortcuts:**                                                                                 │
   │  794  +  - Ctrl+S: Save and stay open                                                                            │
   │  795  +  - Enter: Save and close (if valid)                                                                      │
   │  796  +  - Esc: Cancel changes                                                                                   │
   │  797  +  - F2: Edit match code                                                                                   │
   │  798  +  - Tab: Navigate fields logically                                                                        │
   │  799  +                                                                                                          │
   │  800  +  ### Customer Management Form                                                                            │
   │  801  +                                                                                                          │
   │  802  +  **Layout (MDI Child or Modal):**                                                                        │
   │  803  +                                                                                                          │
   │  804  +  ```                                                                                                     │
   │  805  +  ╔═══════════════════════════════════════════════════════════════╗                                       │
   │  806  +  ║ Customer Management                                   [_][□][X]                                       │
   │  807  +  ╠═══════════════════════════════════════════════════════════════╣                                       │
   │  808  +  ║ [New] [Edit] [Delete] [Search...]                             ║                                       │
   │  809  +  ╠═══════════════════════════════════════════════════════════════╣                                       │
   │  810  +  ║ ┌────────────────────────────────────────────────────────────┐║                                       │
   │  811  +  ║ │ No.  │ Company Name        │ City        │ Phone          │║                                        │
   │  812  +  ║ ├──────┼─────────────────────┼─────────────┼────────────────┤║                                        │
   │  813  +  ║ │ 1001 │ Müller GmbH         │ München     │ 089-12345     │║                                         │
   │  814  +  ║ │ 1002 │ Schmidt AG          │ Stuttgart   │ 0711-98765    │║                                         │
   │  815  +  ║ │ 1003 │ Weber & Co KG       │ Frankfurt   │ 069-55555     │║                                         │
   │  816  +  ║ │ ...  │                     │             │                │║                                        │
   │  817  +  ║ └────────────────────────────────────────────────────────────┘║                                       │
   │  818  +  ║                                                                ║                                      │
   │  819  +  ║ 127 customers total                           [Close]         ║                                       │
   │  820  +  ╚═══════════════════════════════════════════════════════════════╝                                       │
   │  821  +  ```                                                                                                     │
   │  822  +                                                                                                          │
   │  823  +  **Customer Detail Form:**                                                                               │
   │  824  +  - Tabbed interface (General, Address, Financial, Projects, Notes)                                       │
   │  825  +  - Auto-complete for City based on PostalCode                                                            │
   │  826  +  - Validation for TaxId, VatId formats                                                                   │
   │  827  +  - List of associated projects                                                                           │
   │  828  +                                                                                                          │
   │  829  +  ### Invoice Generator Form                                                                              │
   │  830  +                                                                                                          │
   │  831  +  **Wizard-style Interface:**                                                                             │
   │  832  +                                                                                                          │
   │  833  +  **Step 1: Select Type**                                                                                 │
   │  834  +  - Quote (Angebot)                                                                                       │
   │  835  +  - Invoice (Rechnung)                                                                                    │
   │  836  +  - Partial Invoice (Abschlagsrechnung)                                                                   │
   │  837  +  - Final Invoice (Schlussrechnung)                                                                       │
   │  838  +                                                                                                          │
   │  839  +  **Step 2: Select Positions**                                                                            │
   │  840  +  - Tree view with checkboxes                                                                             │
   │  841  +  - Select all / Deselect all                                                                             │
   │  842  +  - Preview quantities and amounts                                                                        │
   │  843  +                                                                                                          │
   │  844  +  **Step 3: Adjustments**                                                                                 │
   │  845  +  - Discount percentage                                                                                   │
   │  846  +  - Surcharges                                                                                            │
   │  847  +  - Retention amount                                                                                      │
   │  848  +  - VAT rate (default 19%)                                                                                │
   │  849  +                                                                                                          │
   │  850  +  **Step 4: Invoice Details**                                                                             │
   │  851  +  - Invoice number (auto-generated, editable)                                                             │
   │  852  +  - Invoice date                                                                                          │
   │  853  +  - Payment terms                                                                                         │
   │  854  +  - Header text / Footer text                                                                             │
   │  855  +                                                                                                          │
   │  856  +  **Step 5: Preview and Print**                                                                           │
   │  857  +  - PDF preview                                                                                           │
   │  858  +  - Print to printer                                                                                      │
   │  859  +  - Save as PDF                                                                                           │
   │  860  +  - Email (future feature)                                                                                │
   │  861  +                                                                                                          │
   │  862  +  ---                                                                                                     │
   │  863  +                                                                                                          │
   │  864  +  ## Functional Requirements                                                                              │
   │  865  +                                                                                                          │
   │  866  +  ### FR-001: Project Management                                                                          │
   │  867  +                                                                                                          │
   │  868  +  **FR-001.1: Create New Project**                                                                        │
   │  869  +  - User enters project number and name                                                                   │
   │  870  +  - System validates uniqueness of project number                                                         │
   │  871  +  - System creates project with default structure (if configured)                                         │
   │  872  +  - System sets CreatedDate, ModifiedDate to current timestamp                                            │
   │  873  +                                                                                                          │
   │  874  +  **FR-001.2: Open Existing Project**                                                                     │
   │  875  +  - User selects project from list or recent projects                                                     │
   │  876  +  - System loads project hierarchy into tree view                                                         │
   │  877  +  - System displays project summary in status bar                                                         │
   │  878  +                                                                                                          │
   │  879  +  **FR-001.3: Import DOS Project**                                                                        │
   │  880  +  - User selects DOS project directory                                                                    │
   │  881  +  - System scans directory structure                                                                      │
   │  882  +  - System displays import preview (record counts)                                                        │
   │  883  +  - User confirms import                                                                                  │
   │  884  +  - System imports all data transactionally                                                               │
   │  885  +  - System generates import log                                                                           │
   │  886  +  - System displays success message with statistics                                                       │
   │  887  +                                                                                                          │
   │  888  +  **FR-001.4: Close Project**                                                                             │
   │  889  +  - System prompts to save if unsaved changes exist                                                       │
   │  890  +  - System closes all child windows for that project                                                      │
   │  891  +  - System removes project from tree view                                                                 │
   │  892  +                                                                                                          │
   │  893  +  **FR-001.5: Delete Project**                                                                            │
   │  894  +  - User selects project and chooses Delete                                                               │
   │  895  +  - System prompts for confirmation                                                                       │
   │  896  +  - System deletes project and all related data (cascade)                                                 │
   │  897  +  - System logs deletion in audit log                                                                     │
   │  898  +                                                                                                          │
   │  899  +  ### FR-002: Hierarchy Management                                                                        │
   │  900  +                                                                                                          │
   │  901  +  **FR-002.1: Add 4th Sum**                                                                               │
   │  902  +  - User right-clicks project node and selects Add 4th Sum                                                │
   │  903  +  - System prompts for Code and Description                                                               │
   │  904  +  - System validates uniqueness within project                                                            │
   │  905  +  - System creates 4th Sum with auto-assigned SortOrder                                                   │
   │  906  +  - System refreshes tree view                                                                            │
   │  907  +                                                                                                          │
   │  908  +  **FR-002.2: Add Lot**                                                                                   │
   │  909  +  - User right-clicks 4th Sum node and selects Add Lot                                                    │
   │  910  +  - System prompts for Code and Description                                                               │
   │  911  +  - System validates uniqueness within 4th Sum                                                            │
   │  912  +  - System creates Lot with auto-assigned SortOrder                                                       │
   │  913  +  - System refreshes tree view                                                                            │
   │  914  +                                                                                                          │
   │  915  +  **FR-002.3: Add Title**                                                                                 │
   │  916  +  - User right-clicks Lot node and selects Add Title                                                      │
   │  917  +  - System prompts for Title Number and Description                                                       │
   │  918  +  - System validates uniqueness within Lot                                                                │
   │  919  +  - System creates Title with auto-assigned SortOrder                                                     │
   │  920  +  - System refreshes tree view                                                                            │
   │  921  +                                                                                                          │
   │  922  +  **FR-002.4: Reorder Items**                                                                             │
   │  923  +  - User drags node to new position                                                                       │
   │  924  +  - System updates SortOrder values                                                                       │
   │  925  +  - System saves changes                                                                                  │
   │  926  +  - System refreshes tree view                                                                            │
   │  927  +                                                                                                          │
   │  928  +  **FR-002.5: Move Items**                                                                                │
   │  929  +  - User drags Title to different Lot                                                                     │
   │  930  +  - System prompts for confirmation                                                                       │
   │  931  +  - System updates parent relationship                                                                    │
   │  932  +  - System recalculates totals for old and new parent                                                     │
   │  933  +  - System refreshes tree view                                                                            │
   │  934  +                                                                                                          │
   │  935  +  ### FR-003: Position Management                                                                         │
   │  936  +                                                                                                          │
   │  937  +  **FR-003.1: Add Position**                                                                              │
   │  938  +  - User right-clicks Title node or presses Insert key                                                    │
   │  939  +  - System opens Position Editor with empty form                                                          │
   │  940  +  - User enters position data                                                                             │
   │  941  +  - System validates all fields                                                                           │
   │  942  +  - System calculates TotalPrice                                                                          │
   │  943  +  - System saves position                                                                                 │
   │  944  +  - System updates Title total                                                                            │
   │  945  +  - System refreshes tree view                                                                            │
   │  946  +                                                                                                          │
   │  947  +  **FR-003.2: Edit Position**                                                                             │
   │  948  +  - User double-clicks position or presses Enter                                                          │
   │  949  +  - System opens Position Editor with existing data                                                       │
   │  950  +  - User modifies fields                                                                                  │
   │  951  +  - System validates changes                                                                              │
   │  952  +  - System recalculates TotalPrice if needed                                                              │
   │  953  +  - System saves changes                                                                                  │
   │  954  +  - System updates Title total if price changed                                                           │
   │  955  +  - System refreshes tree view                                                                            │
   │  956  +                                                                                                          │
   │  957  +  **FR-003.3: Delete Position**                                                                           │
   │  958  +  - User selects position and presses Delete or chooses Delete from menu                                  │
   │  959  +  - System prompts for confirmation                                                                       │
   │  960  +  - System checks if position is referenced in any invoices                                               │
   │  961  +  - If referenced, system warns and asks to proceed                                                       │
   │  962  +  - System deletes position (soft delete if referenced)                                                   │
   │  963  +  - System updates Title total                                                                            │
   │  964  +  - System refreshes tree view                                                                            │
   │  965  +                                                                                                          │
   │  966  +  **FR-003.4: Duplicate Position**                                                                        │
   │  967  +  - User selects position and presses Ctrl+D                                                              │
   │  968  +  - System creates copy with incremented position number                                                  │
   │  969  +  - System opens Position Editor for new position                                                         │
   │  970  +  - User modifies as needed                                                                               │
   │  971  +  - System saves new position                                                                             │
   │  972  +                                                                                                          │
   │  973  +  **FR-003.5: Match Code Search**                                                                         │
   │  974  +  - User enters match code in search field                                                                │
   │  975  +  - System searches all positions in current project                                                      │
   │  976  +  - System displays matching positions in results list                                                    │
   │  977  +  - User selects position from results                                                                    │
   │  978  +  - System navigates tree view to position and opens editor                                               │
   │  979  +                                                                                                          │
   │  980  +  ### FR-004: Calculation Engine                                                                          │
   │  981  +                                                                                                          │
   │  982  +  **FR-004.1: Position Total Calculation**                                                                │
   │  983  +  - When user changes Dimension1, Dimension2, or Dimension3:                                              │
   │  984  +    - System calculates: CalculatedQuantity = Dim1 × Dim2 × Dim3                                          │
   │  985  +    - System rounds to 3 decimal places                                                                   │
   │  986  +  - When user changes CalculatedQuantity or UnitPrice:                                                    │
   │  987  +    - System calculates: TotalPrice = CalculatedQuantity × UnitPrice                                      │
   │  988  +    - System rounds to 2 decimal places                                                                   │
   │  989  +                                                                                                          │
   │  990  +  **FR-004.2: Title Total Calculation**                                                                   │
   │  991  +  - When any position price changes in Title:                                                             │
   │  992  +    - System sums all TotalPrice values in Title                                                          │
   │  993  +    - System updates Title.TotalAmount                                                                    │
   │  994  +    - System triggers Lot total calculation                                                               │
   │  995  +                                                                                                          │
   │  996  +  **FR-004.3: Lot Total Calculation**                                                                     │
   │  997  +  - When any Title total changes in Lot:                                                                  │
   │  998  +    - System sums all TotalAmount values in Lot                                                           │
   │  999  +    - System updates Lot.TotalAmount                                                                      │
   │ 1000  +    - System triggers 4th Sum total calculation                                                           │
   │ 1001  +                                                                                                          │
   │ 1002  +  **FR-004.4: 4th Sum Total Calculation**                                                                 │
   │ 1003  +  - When any Lot total changes in 4th Sum:                                                                │
   │ 1004  +    - System sums all TotalAmount values in 4th Sum                                                       │
   │ 1005  +    - System updates FourthSum.TotalAmount                                                                │
   │ 1006  +    - System triggers project total recalculation                                                         │
   │ 1007  +                                                                                                          │
   │ 1008  +  **FR-004.5: Manual Recalculation**                                                                      │
   │ 1009  +  - User selects Recalculate Totals from Project menu                                                     │
   │ 1010  +  - System recalculates all totals bottom-up (Position → Title → Lot → 4thSum)                            │
   │ 1011  +  - System displays confirmation message with updated totals                                              │
   │ 1012  +                                                                                                          │
   │ 1013  +  ### FR-005: Invoice Generation                                                                          │
   │ 1014  +                                                                                                          │
   │ 1015  +  **FR-005.1: Create Quote**                                                                              │
   │ 1016  +  - User selects Generate Invoice → Quote                                                                 │
   │ 1017  +  - System opens Invoice Wizard                                                                           │
   │ 1018  +  - User follows wizard steps                                                                             │
   │ 1019  +  - System generates invoice record with InvoiceType = 'Angebot'                                          │
   │ 1020  +  - System creates line items for selected positions                                                      │
   │ 1021  +  - System does NOT mark positions as billed                                                              │
   │ 1022  +  - System generates PDF or sends to printer                                                              │
   │ 1023  +                                                                                                          │
   │ 1024  +  **FR-005.2: Create Invoice**                                                                            │
   │ 1025  +  - User selects Generate Invoice → Invoice                                                               │
   │ 1026  +  - System opens Invoice Wizard                                                                           │
   │ 1027  +  - User selects positions (can be subset)                                                                │
   │ 1028  +  - User enters adjustments, payment terms                                                                │
   │ 1029  +  - System generates invoice with unique InvoiceNumber                                                    │
   │ 1030  +  - System calculates NetAmount, VatAmount, GrossAmount                                                   │
   │ 1031  +  - System creates invoice record and line items                                                          │
   │ 1032  +  - System generates PDF or sends to printer                                                              │
   │ 1033  +                                                                                                          │
   │ 1034  +  **FR-005.3: Create Partial Invoice**                                                                    │
   │ 1035  +  - User selects Generate Invoice → Partial Invoice                                                       │
   │ 1036  +  - System opens Invoice Wizard                                                                           │
   │ 1037  +  - System shows previously billed amounts                                                                │
   │ 1038  +  - User selects additional positions or partial quantities                                               │
   │ 1039  +  - System creates invoice with InvoiceType = 'Abschlag'                                                  │
   │ 1040  +  - System tracks billed amounts                                                                          │
   │ 1041  +  - System generates PDF or sends to printer                                                              │
   │ 1042  +                                                                                                          │
   │ 1043  +  **FR-005.4: Create Final Invoice**                                                                      │
   │ 1044  +  - User selects Generate Invoice → Final Invoice                                                         │
   │ 1045  +  - System calculates total project amount                                                                │
   │ 1046  +  - System subtracts all previous partial invoices                                                        │
   │ 1047  +  - System applies retention release if configured                                                        │
   │ 1048  +  - System creates invoice with InvoiceType = 'Schlussrechnung'                                           │
   │ 1049  +  - System marks project as fully invoiced                                                                │
   │ 1050  +  - System generates PDF or sends to printer                                                              │
   │ 1051  +                                                                                                          │
   │ 1052  +  **FR-005.5: Invoice Template**                                                                          │
   │ 1053  +  - System uses configurable template for invoice layout                                                  │
   │ 1054  +  - Template includes:                                                                                    │
   │ 1055  +    - Company logo and information                                                                        │
   │ 1056  +    - Customer information                                                                                │
   │ 1057  +    - Invoice number, date                                                                                │
   │ 1058  +    - Line items table (Position #, Description, Qty, Unit, Unit Price, Total)                            │
   │ 1059  +    - Subtotal, discount, surcharges                                                                      │
   │ 1060  +    - VAT calculation                                                                                     │
   │ 1061  +    - Gross total                                                                                         │
   │ 1062  +    - Payment terms                                                                                       │
   │ 1063  +    - Footer text                                                                                         │
   │ 1064  +                                                                                                          │
   │ 1065  +  ### FR-006: Customer Management                                                                         │
   │ 1066  +                                                                                                          │
   │ 1067  +  **FR-006.1: Add Customer**                                                                              │
   │ 1068  +  - User opens Customer Management and clicks New                                                         │
   │ 1069  +  - System opens Customer Detail Form                                                                     │
   │ 1070  +  - User enters customer data                                                                             │
   │ 1071  +  - System validates required fields (Company Name, Customer Number)                                      │
   │ 1072  +  - System checks uniqueness of Customer Number                                                           │
   │ 1073  +  - System saves customer                                                                                 │
   │ 1074  +  - System adds to customer list                                                                          │
   │ 1075  +                                                                                                          │
   │ 1076  +  **FR-006.2: Edit Customer**                                                                             │
   │ 1077  +  - User selects customer and clicks Edit                                                                 │
   │ 1078  +  - System opens Customer Detail Form with existing data                                                  │
   │ 1079  +  - User modifies fields                                                                                  │
   │ 1080  +  - System validates changes                                                                              │
   │ 1081  +  - System saves customer                                                                                 │
   │ 1082  +  - System updates customer list                                                                          │
   │ 1083  +                                                                                                          │
   │ 1084  +  **FR-006.3: Delete Customer**                                                                           │
   │ 1085  +  - User selects customer and clicks Delete                                                               │
   │ 1086  +  - System checks if customer is referenced in any projects                                               │
   │ 1087  +  - If referenced, system prevents deletion and shows message                                             │
   │ 1088  +  - If not referenced, system prompts for confirmation                                                    │
   │ 1089  +  - System deletes customer                                                                               │
   │ 1090  +  - System updates customer list                                                                          │
   │ 1091  +                                                                                                          │
   │ 1092  +  **FR-006.4: Search Customer**                                                                           │
   │ 1093  +  - User enters search term in search field                                                               │
   │ 1094  +  - System searches CustomerNumber, CompanyName, ContactPerson                                            │
   │ 1095  +  - System filters customer list to matches                                                               │
   │ 1096  +  - User can clear search to show all                                                                     │
   │ 1097  +                                                                                                          │
   │ 1098  +  ### FR-007: Data Import/Export                                                                          │
   │ 1099  +                                                                                                          │
   │ 1100  +  **FR-007.1: Import DOS Project**                                                                        │
   │ 1101  +  - See FR-001.3                                                                                          │
   │ 1102  +                                                                                                          │
   │ 1103  +  **FR-007.2: Export to Excel**                                                                           │
   │ 1104  +  - User selects Export to Excel from File menu                                                           │
   │ 1105  +  - User selects export scope (Current Project, Selected Titles, All Projects)                            │
   │ 1106  +  - System generates Excel file with worksheets:                                                          │
   │ 1107  +    - Project Summary                                                                                     │
   │ 1108  +    - Hierarchy (4th Sums, Lots, Titles)                                                                  │
   │ 1109  +    - Position Details                                                                                    │
   │ 1110  +    - Totals by Level                                                                                     │
   │ 1111  +  - System opens Excel file or prompts to save                                                            │
   │ 1112  +                                                                                                          │
   │ 1113  +  **FR-007.3: Export to PDF**                                                                             │
   │ 1114  +  - User selects Export to PDF                                                                            │
   │ 1115  +  - User selects report type (Project Report, Position List, Invoice)                                     │
   │ 1116  +  - System generates PDF using configured template                                                        │
   │ 1117  +  - System opens PDF viewer or prompts to save                                                            │
   │ 1118  +                                                                                                          │
   │ 1119  +  **FR-007.4: Backup Database**                                                                           │
   │ 1120  +  - User selects Backup Database from Tools menu                                                          │
   │ 1121  +  - System prompts for backup location                                                                    │
   │ 1122  +  - System creates timestamped copy of SQLite database file                                               │
   │ 1123  +  - System creates backup log entry                                                                       │
   │ 1124  +  - System displays confirmation message                                                                  │
   │ 1125  +                                                                                                          │
   │ 1126  +  **FR-007.5: Restore Database**                                                                          │
   │ 1127  +  - User selects Restore Database from Tools menu                                                         │
   │ 1128  +  - User selects backup file                                                                              │
   │ 1129  +  - System validates backup file                                                                          │
   │ 1130  +  - System prompts for confirmation (warns data will be replaced)                                         │
   │ 1131  +  - System closes all open projects                                                                       │
   │ 1132  +  - System replaces current database with backup                                                          │
   │ 1133  +  - System reopens application                                                                            │
   │ 1134  +  - System displays confirmation message                                                                  │
   │ 1135  +                                                                                                          │
   │ 1136  +  ### FR-008: Search and Navigation                                                                       │
   │ 1137  +                                                                                                          │
   │ 1138  +  **FR-008.1: Global Search**                                                                             │
   │ 1139  +  - User presses Ctrl+F or selects Find from Edit menu                                                    │
   │ 1140  +  - System opens Search dialog                                                                            │
   │ 1141  +  - User enters search term                                                                               │
   │ 1142  +  - User selects search scope (Position Description, Match Code, All Text)                                │
   │ 1143  +  - User optionally limits to current project or searches all projects                                    │
   │ 1144  +  - System executes search                                                                                │
   │ 1145  +  - System displays results list with:                                                                    │
   │ 1146  +    - Project Number                                                                                      │
   │ 1147  +    - Hierarchy path (4thSum → Lot → Title → Position)                                                    │
   │ 1148  +    - Matching text snippet                                                                               │
   │ 1149  +  - User double-clicks result                                                                             │
   │ 1150  +  - System navigates to position and opens editor                                                         │
   │ 1151  +                                                                                                          │
   │ 1152  +  **FR-008.2: Find Next**                                                                                 │
   │ 1153  +  - User presses F3 or selects Find Next from Edit menu                                                   │
   │ 1154  +  - System navigates to next search result                                                                │
   │ 1155  +  - System highlights match in editor                                                                     │
   │ 1156  +                                                                                                          │
   │ 1157  +  **FR-008.3: Recent Projects**                                                                           │
   │ 1158  +  - User selects File → Recent Projects                                                                   │
   │ 1159  +  - System displays submenu with last 10 opened projects                                                  │
   │ 1160  +  - User selects project                                                                                  │
   │ 1161  +  - System opens selected project                                                                         │
   │ 1162  +                                                                                                          │
   │ 1163  +  **FR-008.4: Jump to Position**                                                                          │
   │ 1164  +  - User presses Ctrl+G (Go To)                                                                           │
   │ 1165  +  - System opens Jump dialog                                                                              │
   │ 1166  +  - User enters Position Number or Match Code                                                             │
   │ 1167  +  - System finds matching position in current project                                                     │
   │ 1168  +  - System navigates tree view and opens editor                                                           │
   │ 1169  +                                                                                                          │
   │ 1170  +  ### FR-009: Undo/Redo Support                                                                           │
   │ 1171  +                                                                                                          │
   │ 1172  +  **FR-009.1: Undo**                                                                                      │
   │ 1173  +  - User presses Ctrl+Z or selects Undo from Edit menu                                                    │
   │ 1174  +  - System reverts last change                                                                            │
   │ 1175  +  - Supported operations:                                                                                 │
   │ 1176  +    - Position add/edit/delete                                                                            │
   │ 1177  +    - Hierarchy item add/edit/delete                                                                      │
   │ 1178  +    - Customer add/edit/delete                                                                            │
   │ 1179  +  - System updates UI to reflect reverted state                                                           │
   │ 1180  +  - System updates status bar with undo description                                                       │
   │ 1181  +                                                                                                          │
   │ 1182  +  **FR-009.2: Redo**                                                                                      │
   │ 1183  +  - User presses Ctrl+Y or selects Redo from Edit menu                                                    │
   │ 1184  +  - System reapplies last undone change                                                                   │
   │ 1185  +  - System updates UI to reflect reapplied state                                                          │
   │ 1186  +  - System updates status bar with redo description                                                       │
   │ 1187  +                                                                                                          │
   │ 1188  +  **FR-009.3: Undo History**                                                                              │
   │ 1189  +  - System maintains undo stack of last 50 operations per project                                         │
   │ 1190  +  - System clears undo stack when project is closed                                                       │
   │ 1191  +  - System disables Undo menu item when stack is empty                                                    │
   │ 1192  +                                                                                                          │
   │ 1193  +  ### FR-010: Settings and Configuration                                                                  │
   │ 1194  +                                                                                                          │
   │ 1195  +  **FR-010.1: Application Settings**                                                                      │
   │ 1196  +  - User selects Tools → Settings                                                                         │
   │ 1197  +  - System opens Settings dialog with tabs:                                                               │
   │ 1198  +    - General (UI preferences, date formats)                                                              │
   │ 1199  +    - Invoice (default VAT rate, invoice numbering)                                                       │
   │ 1200  +    - Company (company info for invoices)                                                                 │
   │ 1201  +    - Database (backup location, auto-backup interval)                                                    │
   │ 1202  +    - Advanced (logging level, performance options)                                                       │
   │ 1203  +  - User modifies settings                                                                                │
   │ 1204  +  - System validates settings                                                                             │
   │ 1205  +  - System saves to Settings table                                                                        │
   │ 1206  +  - System applies settings immediately where possible                                                    │
   │ 1207  +                                                                                                          │
   │ 1208  +  **FR-010.2: Project-Specific Settings**                                                                 │
   │ 1209  +  - User selects Project → Project Settings                                                               │
   │ 1210  +  - System opens Project Settings dialog                                                                  │
   │ 1211  +  - User configures:                                                                                      │
   │ 1212  +    - Default VAT rate for this project                                                                   │
   │ 1213  +    - Retention percentage                                                                                │
   │ 1214  +    - Default discount                                                                                    │
   │ 1215  +    - Invoice header/footer templates                                                                     │
   │ 1216  +  - System saves to project record                                                                        │
   │ 1217  +  - System applies to future invoices for this project                                                    │
   │ 1218  +                                                                                                          │
   │ 1219  +  ---                                                                                                     │
   │ 1220  +                                                                                                          │
   │ 1221  +  ## Non-Functional Requirements                                                                          │
   │ 1222  +                                                                                                          │
   │ 1223  +  ### NFR-001: Performance                                                                                │
   │ 1224  +                                                                                                          │
   │ 1225  +  **NFR-001.1: Response Time**                                                                            │
   │ 1226  +  - Project open: < 1 second for typical project (< 5000 positions)                                       │
   │ 1227  +  - Position save: < 100 ms                                                                               │
   │ 1228  +  - Tree view refresh: < 500 ms                                                                           │
   │ 1229  +  - Search results: < 2 seconds for full database search                                                  │
   │ 1230  +  - Invoice generation: < 3 seconds                                                                       │
   │ 1231  +                                                                                                          │
   │ 1232  +  **NFR-001.2: Scalability**                                                                              │
   │ 1233  +  - Support projects with up to 50,000 positions                                                          │
   │ 1234  +  - Support database with up to 1000 projects                                                             │
   │ 1235  +  - Support customer database with up to 10,000 customers                                                 │
   │ 1236  +                                                                                                          │
   │ 1237  +  **NFR-001.3: Memory Usage**                                                                             │
   │ 1238  +  - Maximum working set: 500 MB for typical usage                                                         │
   │ 1239  +  - Application startup: < 3 seconds on modern hardware                                                   │
   │ 1240  +                                                                                                          │
   │ 1241  +  ### NFR-002: Usability                                                                                  │
   │ 1242  +                                                                                                          │
   │ 1243  +  **NFR-002.1: Learnability**                                                                             │
   │ 1244  +  - Users familiar with DOS version should be productive within 1 hour                                    │
   │ 1245  +  - New users should complete basic tasks within 2 hours with documentation                               │
   │ 1246  +                                                                                                          │
   │ 1247  +  **NFR-002.2: Accessibility**                                                                            │
   │ 1248  +  - Full keyboard navigation support                                                                      │
   │ 1249  +  - High-contrast mode support                                                                            │
   │ 1250  +  - Screen reader compatibility (NVDA, JAWS)                                                              │
   │ 1251  +  - Scalable UI for high DPI displays                                                                     │
   │ 1252  +                                                                                                          │
   │ 1253  +  **NFR-002.3: User Interface**                                                                           │
   │ 1254  +  - Consistent with Windows UI guidelines                                                                 │
   │ 1255  +  - Responsive (no UI freezing during operations)                                                         │
   │ 1256  +  - Clear error messages with suggested actions                                                           │
   │ 1257  +  - Confirmation dialogs for destructive operations                                                       │
   │ 1258  +                                                                                                          │
   │ 1259  +  ### NFR-003: Reliability                                                                                │
   │ 1260  +                                                                                                          │
   │ 1261  +  **NFR-003.1: Data Integrity**                                                                           │
   │ 1262  +  - Zero data loss under normal operation                                                                 │
   │ 1263  +  - Transactional consistency (all-or-nothing for multi-table operations)                                 │
   │ 1264  +  - Automatic backup before major operations (project delete, import)                                     │
   │ 1265  +  - Referential integrity enforced by database constraints                                                │
   │ 1266  +                                                                                                          │
   │ 1267  +  **NFR-003.2: Error Handling**                                                                           │
   │ 1268  +  - Graceful degradation on errors                                                                        │
   │ 1269  +  - User-friendly error messages                                                                          │
   │ 1270  +  - Detailed error logging for troubleshooting                                                            │
   │ 1271  +  - Automatic error reporting (optional, with user consent)                                               │
   │ 1272  +                                                                                                          │
   │ 1273  +  **NFR-003.3: Availability**                                                                             │
   │ 1274  +  - Application startup success rate: > 99.9%                                                             │
   │ 1275  +  - No data corruption on unexpected shutdown                                                             │
   │ 1276  +  - Database recovery on corruption                                                                       │
   │ 1277  +                                                                                                          │
   │ 1278  +  ### NFR-004: Maintainability                                                                            │
   │ 1279  +                                                                                                          │
   │ 1280  +  **NFR-004.1: Code Quality**                                                                             │
   │ 1281  +  - Unit test coverage: > 80% for business logic                                                          │
   │ 1282  +  - Integration test coverage: > 60% for data access layer                                                │
   │ 1283  +  - XML documentation for all public APIs                                                                 │
   │ 1284  +  - Code analysis (StyleCop, SonarAnalyzer) with zero warnings                                            │
   │ 1285  +                                                                                                          │
   │ 1286  +  **NFR-004.2: Logging**                                                                                  │
   │ 1287  +  - Structured logging with Serilog                                                                       │
   │ 1288  +  - Log levels: Trace, Debug, Information, Warning, Error, Fatal                                          │
   │ 1289  +  - Log rotation (daily, max 30 days)                                                                     │
   │ 1290  +  - Performance logging for slow operations (> 1 second)                                                  │
   │ 1291  +                                                                                                          │
   │ 1292  +  **NFR-004.3: Configuration**                                                                            │
   │ 1293  +  - Externalized configuration (appsettings.json)                                                         │
   │ 1294  +  - Environment-specific overrides                                                                        │
   │ 1295  +  - No hardcoded paths or connection strings                                                              │
   │ 1296  +                                                                                                          │
   │ 1297  +  ### NFR-005: Security                                                                                   │
   │ 1298  +                                                                                                          │
   │ 1299  +  **NFR-005.1: Data Protection**                                                                          │
   │ 1300  +  - Database file encryption (optional)                                                                   │
   │ 1301  +  - Sensitive data (customer financial info) encrypted at rest                                            │
   │ 1302  +  - Secure backup storage recommendations                                                                 │
   │ 1303  +                                                                                                          │
   │ 1304  +  **NFR-005.2: User Authentication**                                                                      │
   │ 1305  +  - Single-user application (no multi-user authentication in v1)                                          │
   │ 1306  +  - Audit log for all data modifications                                                                  │
   │ 1307  +  - User identification via Windows username                                                              │
   │ 1308  +                                                                                                          │
   │ 1309  +  **NFR-005.3: Input Validation**                                                                         │
   │ 1310  +  - All user input validated before processing                                                            │
   │ 1311  +  - SQL injection prevention (parameterized queries)                                                      │
   │ 1312  +  - Path traversal prevention (file operations)                                                           │
   │ 1313  +                                                                                                          │
   │ 1314  +  ### NFR-006: Portability                                                                                │
   │ 1315  +                                                                                                          │
   │ 1316  +  **NFR-006.1: Platform Support**                                                                         │
   │ 1317  +  - Windows 10 (version 1809 or later)                                                                    │
   │ 1318  +  - Windows 11                                                                                            │
   │ 1319  +  - Both 32-bit and 64-bit (prefer 64-bit)                                                                │
   │ 1320  +                                                                                                          │
   │ 1321  +  **NFR-006.2: Dependencies**                                                                             │
   │ 1322  +  - .NET 10 Runtime (bundled with installer)                                                              │
   │ 1323  +  - No external database server required                                                                  │
   │ 1324  +  - Minimal 3rd-party dependencies                                                                        │
   │ 1325  +                                                                                                          │
   │ 1326  +  ---                                                                                                     │
   │ 1327  +                                                                                                          │
   │ 1328  +  ## Implementation Roadmap                                                                               │
   │ 1329  +                                                                                                          │
   │ 1330  +  ### Phase 1: Foundation (Weeks 1-4)                                                                     │
   │ 1331  +                                                                                                          │
   │ 1332  +  **Week 1-2: Project Setup and Core Infrastructure**                                                     │
   │ 1333  +  - Create solution structure                                                                             │
   │ 1334  +  - Set up CI/CD pipeline (GitHub Actions or Azure DevOps)                                                │
   │ 1335  +  - Implement Solon.Core (domain models, interfaces)                                                      │
   │ 1336  +  - Implement Solon.Data (DbContext, repositories)                                                        │
   │ 1337  +  - Create database schema and migrations                                                                 │
   │ 1338  +  - Write unit tests for core models                                                                      │
   │ 1339  +                                                                                                          │
   │ 1340  +  **Week 3-4: DOS Import and Data Migration**                                                             │
   │ 1341  +  - Implement DosProjectScanner                                                                           │
   │ 1342  +  - Implement file format readers (SOL, POS, TIT, etc.)                                                   │
   │ 1343  +  - Build import service with validation                                                                  │
   │ 1344  +  - Create import UI (console app or simple WinForms)                                                     │
   │ 1345  +  - Test with sample DOS projects                                                                         │
   │ 1346  +  - Generate import documentation                                                                         │
   │ 1347  +                                                                                                          │
   │ 1348  +  **Deliverables:**                                                                                       │
   │ 1349  +  - Working database schema                                                                               │
   │ 1350  +  - DOS import tool with 100% success rate on test projects                                               │
   │ 1351  +  - Foundation code with > 80% test coverage                                                              │
   │ 1352  +                                                                                                          │
   │ 1353  +  ### Phase 2: Business Logic (Weeks 5-8)                                                                 │
   │ 1354  +                                                                                                          │
   │ 1355  +  **Week 5-6: Business Services**                                                                         │
   │ 1356  +  - Implement ProjectService                                                                              │
   │ 1357  +  - Implement PositionService with calculation engine                                                     │
   │ 1358  +  - Implement CustomerService                                                                             │
   │ 1359  +  - Implement validation logic                                                                            │
   │ 1360  +  - Write comprehensive unit tests                                                                        │
   │ 1361  +                                                                                                          │
   │ 1362  +  **Week 7-8: Invoice Generation**                                                                        │
   │ 1363  +  - Implement InvoiceService                                                                              │
   │ 1364  +  - Create invoice calculation logic                                                                      │
   │ 1365  +  - Implement PDF generation (evaluate FastReport, QuestPDF, or iText)                                    │
   │ 1366  +  - Create invoice templates                                                                              │
   │ 1367  +  - Test invoice calculations against DOS-generated invoices                                              │
   │ 1368  +                                                                                                          │
   │ 1369  +  **Deliverables:**                                                                                       │
   │ 1370  +  - Complete business logic layer                                                                         │
   │ 1371  +  - Invoice generation with PDF output                                                                    │
   │ 1372  +  - Business logic tests with > 85% coverage                                                              │
   │ 1373  +                                                                                                          │
   │ 1374  +  ### Phase 3: User Interface (Weeks 9-14)                                                                │
   │ 1375  +                                                                                                          │
   │ 1376  +  **Week 9-10: Main Window and Project Explorer**                                                         │
   │ 1377  +  - Create MDI main window                                                                                │
   │ 1378  +  - Implement menu system                                                                                 │
   │ 1379  +  - Build project tree view with icons                                                                    │
   │ 1380  +  - Implement context menus                                                                               │
   │ 1381  +  - Add drag-and-drop support                                                                             │
   │ 1382  +                                                                                                          │
   │ 1383  +  **Week 11-12: Position Editor and Dialogs**                                                             │
   │ 1384  +  - Create Position Editor form                                                                           │
   │ 1385  +  - Implement field validation and auto-calculation                                                       │
   │ 1386  +  - Build Customer Management form                                                                        │
   │ 1387  +  - Create Project Settings dialog                                                                        │
   │ 1388  +  - Implement Application Settings dialog                                                                 │
   │ 1389  +                                                                                                          │
   │ 1390  +  **Week 13-14: Invoice UI and Reporting**                                                                │
   │ 1391  +  - Build Invoice Wizard                                                                                  │
   │ 1392  +  - Implement invoice preview                                                                             │
   │ 1393  +  - Create print dialog                                                                                   │
   │ 1394  +  - Add export functionality (Excel, PDF)                                                                 │
   │ 1395  +  - Implement search dialog and global search                                                             │
   │ 1396  +                                                                                                          │
   │ 1397  +  **Deliverables:**                                                                                       │
   │ 1398  +  - Complete WinForms UI                                                                                  │
   │ 1399  +  - All forms functional and tested                                                                       │
   │ 1400  +  - UI meets accessibility standards                                                                      │
   │ 1401  +                                                                                                          │
   │ 1402  +  ### Phase 4: Advanced Features (Weeks 15-16)                                                            │
   │ 1403  +                                                                                                          │
   │ 1404  +  **Week 15: Undo/Redo and Search**                                                                       │
   │ 1405  +  - Implement Command pattern for undo/redo                                                               │
   │ 1406  +  - Build undo stack management                                                                           │
   │ 1407  +  - Implement global search with highlighting                                                             │
   │ 1408  +  - Add Jump To Position feature                                                                          │
   │ 1409  +  - Create recent projects list                                                                           │
   │ 1410  +                                                                                                          │
   │ 1411  +  **Week 16: Polish and Optimization**                                                                    │
   │ 1412  +  - Performance profiling and optimization                                                                │
   │ 1413  +  - Memory leak detection and fixes                                                                       │
   │ 1414  +  - UI responsiveness improvements                                                                        │
   │ 1415  +  - Icon and visual design refinement                                                                     │
   │ 1416  +  - Keyboard shortcut testing                                                                             │
   │ 1417  +                                                                                                          │
   │ 1418  +  **Deliverables:**                                                                                       │
   │ 1419  +  - Undo/redo fully functional                                                                            │
   │ 1420  +  - Search with < 2 second response time                                                                  │
   │ 1421  +  - Polished, responsive UI                                                                               │
   │ 1422  +                                                                                                          │
   │ 1423  +  ### Phase 5: Testing and Documentation (Weeks 17-18)                                                    │
   │ 1424  +                                                                                                          │
   │ 1425  +  **Week 17: Testing**                                                                                    │
   │ 1426  +  - Integration testing (UI + Business + Data)                                                            │
   │ 1427  +  - End-to-end testing scenarios                                                                          │
   │ 1428  +  - Performance testing (large projects)                                                                  │
   │ 1429  +  - Stress testing (boundary conditions)                                                                  │
   │ 1430  +  - User acceptance testing (UAT) with stakeholders                                                       │
   │ 1431  +                                                                                                          │
   │ 1432  +  **Week 18: Documentation and Deployment**                                                               │
   │ 1433  +  - User manual (PDF and online help)                                                                     │
   │ 1434  +  - Administrator guide (installation, backup, troubleshooting)                                           │
   │ 1435  +  - Developer documentation (architecture, API docs)                                                      │
   │ 1436  +  - Create installer (WiX or ClickOnce)                                                                   │
   │ 1437  +  - Deployment testing                                                                                    │
   │ 1438  +                                                                                                          │
   │ 1439  +  **Deliverables:**                                                                                       │
   │ 1440  +  - Complete test suite (unit + integration + E2E)                                                        │
   │ 1441  +  - Comprehensive documentation                                                                           │
   │ 1442  +  - Production-ready installer                                                                            │
   │ 1443  +                                                                                                          │
   │ 1444  +  ### Phase 6: Deployment and Support (Week 19+)                                                          │
   │ 1445  +                                                                                                          │
   │ 1446  +  **Week 19: Beta Deployment**                                                                            │
   │ 1447  +  - Deploy to selected beta users                                                                         │
   │ 1448  +  - Monitor usage and collect feedback                                                                    │
   │ 1449  +  - Fix critical bugs                                                                                     │
   │ 1450  +  - Refine UI based on feedback                                                                           │
   │ 1451  +                                                                                                          │
   │ 1452  +  **Week 20+: Production Release and Support**                                                            │
   │ 1453  +  - Public release                                                                                        │
   │ 1454  +  - Monitor for issues                                                                                    │
   │ 1455  +  - Provide user support                                                                                  │
   │ 1456  +  - Plan v1.1 enhancements                                                                                │
   │ 1457  +                                                                                                          │
   │ 1458  +  ---                                                                                                     │
   │ 1459  +                                                                                                          │
   │ 1460  +  ## Risk Assessment                                                                                      │
   │ 1461  +                                                                                                          │
   │ 1462  +  ### Technical Risks                                                                                     │
   │ 1463  +                                                                                                          │
   │ 1464  +  **Risk 1: DOS Data Format Ambiguity**                                                                   │
   │ 1465  +  - **Probability:** Medium                                                                               │
   │ 1466  +  - **Impact:** High                                                                                      │
   │ 1467  +  - **Mitigation:**                                                                                       │
   │ 1468  +    - Analyze multiple DOS project samples                                                                │
   │ 1469  +    - Create comprehensive format documentation                                                           │
   │ 1470  +    - Build flexible parser with error tolerance                                                          │
   │ 1471  +    - Provide manual correction tools for edge cases                                                      │
   │ 1472  +                                                                                                          │
   │ 1473  +  **Risk 2: Performance with Large Projects**                                                             │
   │ 1474  +  - **Probability:** Low                                                                                  │
   │ 1475  +  - **Impact:** Medium                                                                                    │
   │ 1476  +  - **Mitigation:**                                                                                       │
   │ 1477  +    - Profile early and often                                                                             │
   │ 1478  +    - Implement lazy loading for tree view                                                                │
   │ 1479  +    - Use database indices effectively                                                                    │
   │ 1480  +    - Consider pagination for very large position lists                                                   │
   │ 1481  +                                                                                                          │
   │ 1482  +  **Risk 3: PDF Generation Library Limitations**                                                          │
   │ 1483  +  - **Probability:** Low                                                                                  │
   │ 1484  +  - **Impact:** Medium                                                                                    │
   │ 1485  +  - **Mitigation:**                                                                                       │
   │ 1486  +    - Evaluate multiple libraries early                                                                   │
   │ 1487  +    - Create abstraction layer for PDF generation                                                         │
   │ 1488  +    - Fallback to HTML + browser printing if needed                                                       │
   │ 1489  +                                                                                                          │
   │ 1490  +  **Risk 4: Complex Calculation Logic Bugs**                                                              │
   │ 1491  +  - **Probability:** Medium                                                                               │
   │ 1492  +  - **Impact:** High                                                                                      │
   │ 1493  +  - **Mitigation:**                                                                                       │
   │ 1494  +    - Comprehensive unit tests for calculation engine                                                     │
   │ 1495  +    - Cross-validate with DOS version outputs                                                             │
   │ 1496  +    - Independent code review of calculation logic                                                        │
   │ 1497  +    - Create test cases from real-world projects                                                          │
   │ 1498  +                                                                                                          │
   │ 1499  +  ### Business Risks                                                                                      │
   │ 1500  +                                                                                                          │
   │ 1501  +  **Risk 5: User Resistance to UI Changes**                                                               │
   │ 1502  +  - **Probability:** Medium                                                                               │
   │ 1503  +  - **Impact:** Medium                                                                                    │
   │ 1504  +  - **Mitigation:**                                                                                       │
   │ 1505  +    - Preserve familiar workflows where possible                                                          │
   │ 1506  +    - Provide extensive training materials                                                                │
   │ 1507  +    - Implement "classic" keyboard shortcuts                                                              │
   │ 1508  +    - Collect early user feedback                                                                         │
   │ 1509  +                                                                                                          │
   │ 1510  +  **Risk 6: Data Migration Issues**                                                                       │
   │ 1511  +  - **Probability:** Medium                                                                               │
   │ 1512  +  - **Impact:** High                                                                                      │
   │ 1513  +  - **Mitigation:**                                                                                       │
   │ 1514  +    - Never modify original DOS files                                                                     │
   │ 1515  +    - Provide preview mode for imports                                                                    │
   │ 1516  +    - Create detailed import logs                                                                         │
   │ 1517  +    - Support selective re-import of failed items                                                         │
   │ 1518  +                                                                                                          │
   │ 1519  +  **Risk 7: Hidden DOS Features**                                                                         │
   │ 1520  +  - **Probability:** Medium                                                                               │
   │ 1521  +  - **Impact:** Medium                                                                                    │
   │ 1522  +  - **Mitigation:**                                                                                       │
   │ 1523  +    - Interview original users                                                                            │
   │ 1524  +    - Analyze DOS code thoroughly                                                                         │
   │ 1525  +    - Implement analytics to track feature usage                                                          │
   │ 1526  +    - Plan for quick feature additions post-launch                                                        │
   │ 1527  +                                                                                                          │
   │ 1528  +  ### Organizational Risks                                                                                │
   │ 1529  +                                                                                                          │
   │ 1530  +  **Risk 8: Timeline Pressure**                                                                           │
   │ 1531  +  - **Probability:** Medium                                                                               │
   │ 1532  +  - **Impact:** Medium                                                                                    │
   │ 1533  +  - **Mitigation:**                                                                                       │
   │ 1534  +    - Prioritize features (MVP vs nice-to-have)                                                           │
   │ 1535  +    - Use iterative development                                                                           │
   │ 1536  +    - Plan for phased rollout                                                                             │
   │ 1537  +    - Maintain technical debt log                                                                         │
   │ 1538  +                                                                                                          │
   │ 1539  +  **Risk 9: Key Person Dependency**                                                                       │
   │ 1540  +  - **Probability:** Low                                                                                  │
   │ 1541  +  - **Impact:** High                                                                                      │
   │ 1542  +  - **Mitigation:**                                                                                       │
   │ 1543  +    - Comprehensive code documentation                                                                    │
   │ 1544  +    - Pair programming for critical components                                                            │
   │ 1545  +    - Knowledge sharing sessions                                                                          │
   │ 1546  +    - Architecture documentation                                                                          │
   │ 1547  +                                                                                                          │
   │ 1548  +  ---                                                                                                     │
   │ 1549  +                                                                                                          │
   │ 1550  +  ## Appendices                                                                                           │
   │ 1551  +                                                                                                          │
   │ 1552  +  ### Appendix A: Keyboard Shortcuts                                                                      │
   │ 1553  +                                                                                                          │
   │ 1554  +  | Shortcut | Action |                                                                                   │
   │ 1555  +  |----------|--------|                                                                                   │
   │ 1556  +  | Ctrl+N | New Project |                                                                                │
   │ 1557  +  | Ctrl+O | Open Project |                                                                               │
   │ 1558  +  | Ctrl+S | Save |                                                                                       │
   │ 1559  +  | Ctrl+Z | Undo |                                                                                       │
   │ 1560  +  | Ctrl+Y | Redo |                                                                                       │
   │ 1561  +  | Ctrl+F | Find |                                                                                       │
   │ 1562  +  | F3 | Find Next |                                                                                      │
   │ 1563  +  | Ctrl+G | Go To Position |                                                                             │
   │ 1564  +  | Ctrl+I | Import DOS Project |                                                                         │
   │ 1565  +  | Ins | New Position |                                                                                  │
   │ 1566  +  | Enter | Edit Position |                                                                               │
   │ 1567  +  | Del | Delete Position |                                                                               │
   │ 1568  +  | Ctrl+D | Duplicate Position |                                                                         │
   │ 1569  +  | F1 | Help |                                                                                           │
   │ 1570  +                                                                                                          │
   │ 1571  +  ### Appendix B: Database Maintenance                                                                    │
   │ 1572  +                                                                                                          │
   │ 1573  +  **Vacuum Database:**                                                                                    │
   │ 1574  +  ```sql                                                                                                  │
   │ 1575  +  VACUUM;                                                                                                 │
   │ 1576  +  ```                                                                                                     │
   │ 1577  +  Run monthly or after large deletions.                                                                   │
   │ 1578  +                                                                                                          │
   │ 1579  +  **Analyze Tables:**                                                                                     │
   │ 1580  +  ```sql                                                                                                  │
   │ 1581  +  ANALYZE;                                                                                                │
   │ 1582  +  ```                                                                                                     │
   │ 1583  +  Run after major data imports.                                                                           │
   │ 1584  +                                                                                                          │
   │ 1585  +  **Integrity Check:**                                                                                    │
   │ 1586  +  ```sql                                                                                                  │
   │ 1587  +  PRAGMA integrity_check;                                                                                 │
   │ 1588  +  ```                                                                                                     │
   │ 1589  +  Run before backups.                                                                                     │
   │ 1590  +                                                                                                          │
   │ 1591  +  ### Appendix C: Sample Migration Script                                                                 │
   │ 1592  +                                                                                                          │
   │ 1593  +  ```csharp                                                                                               │
   │ 1594  +  public class MigrationSample                                                                            │
   │ 1595  +  {                                                                                                       │
   │ 1596  +      public async Task MigrateAllProjectsAsync(string dosRootPath)                                       │
   │ 1597  +      {                                                                                                   │
   │ 1598  +          var scanner = new DosProjectScanner();                                                          │
   │ 1599  +          var projects = await scanner.ScanDirectoryAsync(dosRootPath);                                   │
   │ 1600  +                                                                                                          │
   │ 1601  +          var results = new List<ImportResult>();                                                         │
   │ 1602  +                                                                                                          │
   │ 1603  +          foreach (var projectPath in projects)                                                           │
   │ 1604  +          {                                                                                               │
   │ 1605  +              var importer = new DosImporter(_dbContext);                                                 │
   │ 1606  +              var result = await importer.ImportProjectAsync(projectPath);                                │
   │ 1607  +              results.Add(result);                                                                        │
   │ 1608  +                                                                                                          │
   │ 1609  +              if (result.IsSuccess)                                                                       │
   │ 1610  +              {                                                                                           │
   │ 1611  +                  Console.WriteLine($"✓ Imported: {projectPath}");                                        │
   │ 1612  +              }                                                                                           │
   │ 1613  +              else                                                                                        │
   │ 1614  +              {                                                                                           │
   │ 1615  +                  Console.WriteLine($"✗ Failed: {projectPath}");                                          │
   │ 1616  +                  Console.WriteLine($"  Error: {result.ErrorMessage}");                                   │
   │ 1617  +              }                                                                                           │
   │ 1618  +          }                                                                                               │
   │ 1619  +                                                                                                          │
   │ 1620  +          GenerateMigrationReport(results);                                                               │
   │ 1621  +      }                                                                                                   │
   │ 1622  +  }                                                                                                       │
   │ 1623  +  ```                                                                                                     │
   │ 1624  +                                                                                                          │
   │ 1625  +  ### Appendix D: Unit Test Examples                                                                      │
   │ 1626  +                                                                                                          │
   │ 1627  +  **Position Calculation Test:**                                                                          │
   │ 1628  +  ```csharp                                                                                               │
   │ 1629  +  [Fact]                                                                                                  │
   │ 1630  +  public void Position_CalculatesTotalPrice_Correctly()                                                   │
   │ 1631  +  {                                                                                                       │
   │ 1632  +      // Arrange                                                                                          │
   │ 1633  +      var position = new Position                                                                         │
   │ 1634  +      {                                                                                                   │
   │ 1635  +          Dimension1 = 12.5m,                                                                             │
   │ 1636  +          Dimension2 = 8.0m,                                                                              │
   │ 1637  +          Dimension3 = 0.4m,                                                                              │
   │ 1638  +          UnitPrice = 125.50m                                                                             │
   │ 1639  +      };                                                                                                  │
   │ 1640  +                                                                                                          │
   │ 1641  +      // Act                                                                                              │
   │ 1642  +      position.CalculateQuantity();                                                                       │
   │ 1643  +      position.CalculateTotalPrice();                                                                     │
   │ 1644  +                                                                                                          │
   │ 1645  +      // Assert                                                                                           │
   │ 1646  +      Assert.Equal(40.0m, position.CalculatedQuantity);                                                   │
   │ 1647  +      Assert.Equal(5020.0m, position.TotalPrice);                                                         │
   │ 1648  +  }                                                                                                       │
   │ 1649  +  ```                                                                                                     │
   │ 1650  +                                                                                                          │
   │ 1651  +  **Hierarchy Total Calculation Test:**                                                                   │
   │ 1652  +  ```csharp                                                                                               │
   │ 1653  +  [Fact]                                                                                                  │
   │ 1654  +  public async Task Title_UpdatesTotal_WhenPositionPriceChanges()                                         │
   │ 1655  +  {                                                                                                       │
   │ 1656  +      // Arrange                                                                                          │
   │ 1657  +      var title = CreateSampleTitle();                                                                    │
   │ 1658  +      await _titleRepo.AddAsync(title);                                                                   │
   │ 1659  +                                                                                                          │
   │ 1660  +      var position = new Position                                                                         │
   │ 1661  +      {                                                                                                   │
   │ 1662  +          TitleId = title.TitleId,                                                                        │
   │ 1663  +          CalculatedQuantity = 10m,                                                                       │
   │ 1664  +          UnitPrice = 100m                                                                                │
   │ 1665  +      };                                                                                                  │
   │ 1666  +      await _positionRepo.AddAsync(position);                                                             │
   │ 1667  +                                                                                                          │
   │ 1668  +      // Act                                                                                              │
   │ 1669  +      position.UnitPrice = 150m;                                                                          │
   │ 1670  +      await _positionRepo.UpdateAsync(position);                                                          │
   │ 1671  +                                                                                                          │
   │ 1672  +      // Assert                                                                                           │
   │ 1673  +      var updatedTitle = await _titleRepo.GetByIdAsync(title.TitleId);                                    │
   │ 1674  +      Assert.Equal(1500m, updatedTitle.TotalAmount);                                                      │
   │ 1675  +  }                                                                                                       │
   │ 1676  +  ```                                                                                                     │
   │ 1677  +                                                                                                          │
   │ 1678  +  ---                                                                                                     │
   │ 1679  +                                                                                                          │
   │ 1680  +  ## Conclusion                                                                                           │
   │ 1681  +                                                                                                          │
   │ 1682  +  This specification provides a complete blueprint for migrating the SOLON DOS application to .NET 10     │
   │          WinForms. The migration preserves all domain functionality while modernizing the technical foundation   │
   │          and user experience.                                                                                    │
   │ 1683  +                                                                                                          │
   │ 1684  +  **Key Success Factors:**                                                                                │
   │ 1685  +  1. Faithful preservation of business logic                                                              │
   │ 1686  +  2. Comprehensive data migration with validation                                                         │
   │ 1687  +  3. Modern, usable interface respecting learned workflows                                                │
   │ 1688  +  4. Robust database design with referential integrity                                                    │
   │ 1689  +  5. Thorough testing at all layers                                                                       │
   │ 1690  +  6. Clear documentation for users and developers                                                         │
   │ 1691  +                                                                                                          │
   │ 1692  +  **Next Steps:**                                                                                         │
   │ 1693  +  1. Review and approve specification                                                                     │
   │ 1694  +  2. Set up development environment                                                                       │
   │ 1695  +  3. Begin Phase 1 implementation                                                                         │
   │ 1696  +  4. Establish regular stakeholder check-ins                                                              │
   │ 1697  +                                                                                                          │
   │ 1698  +  ---                                                                                                     │
   │ 1699  +                                                                                                          │
   │ 1700  +  **Document Status:** Draft v1.0                                                                         │
   │ 1701  +  **Author:** Migration Team                                                                              │
   │ 1702  +  **Approval Required:** Project Stakeholders                                                             │
   │ 1703  +  **Target Start Date:** TBD                                                                              │
   │ 1704  +                                                                                                          │
   │ 1705  +  ---                                                                                                     │
   │ 1706  +                                                                                                          │
   │ 1707  +  **End of Part 3**                                                                                       │
   │ 1708  +                                                                                                          │
   │ 1709  +                                                                                                          │
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

 ● Perfect! I've successfully created the complete Part 3 specification document.
   The previous JSON parsing error was likely due to trying to create a file with
   complex content containing special characters in a single tool call, but by
   using the edit tool on the existing (nearly empty) file, we avoided that issue.

   The document now contains comprehensive specifications for migrating SOLON to
   .NET 10 WinForms, including:

     - Architecture design with modern 3-tier structure
     - Complete database schema with all tables, constraints, and triggers
     - Detailed UI specifications with layouts and mockups
     - Functional requirements (FR-001 through FR-010) covering all features
     - Non-functional requirements (performance, usability, security)
     - 18-week implementation roadmap
     - Risk assessment with mitigation strategies
     - Appendices with code samples and maintenance procedures

 D:\Git\SOLON[⎇ main]                                                                           claude-sonnet-4.5 (1x)
 ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 >  Enter @ to mention files or / for commands
 ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 Ctrl+c Exit · Ctrl+r Expand recent                                                           Remaining requests: 89.4%
‍


