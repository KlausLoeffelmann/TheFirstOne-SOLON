# SOLON - Massenermittlung für Bauunternehmer
## Part 3: Migration Specification for .NET 10 WinForms

**Document Version:** 1.0  
**Date:** November 2025  
**Target Platform:** .NET 10, Windows 10/11  
**Target Framework:** WinForms with SQLite backend  
**Migration Strategy:** Greenfield development with legacy data import  

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Migration Goals and Principles](#migration-goals-and-principles)
3. [Architecture Design](#architecture-design)
4. [Data Migration Strategy](#data-migration-strategy)
5. [Database Schema Design](#database-schema-design)
6. [User Interface Specifications](#user-interface-specifications)
7. [Functional Requirements](#functional-requirements)
8. [Non-Functional Requirements](#non-functional-requirements)
9. [Implementation Roadmap](#implementation-roadmap)
10. [Risk Assessment](#risk-assessment)

---

## Executive Summary

This document specifies the complete migration of the DOS-based SOLON construction cost estimation system to a modern .NET 10 WinForms application. The new system will:

- **Preserve** all original functionality and domain logic
- **Import** existing DOS file-based data into SQLite
- **Modernize** the user interface while respecting workflow patterns
- **Extend** capabilities with modern features (undo/redo, search, reporting)
- **Maintain** compatibility with German construction industry standards

### Key Success Criteria

| Criterion | Target |
|-----------|--------|
| Data Migration | 100% of DOS projects readable |
| Feature Parity | All original features implemented |
| Performance | Sub-second response for typical operations |
| Usability | Intuitive for users familiar with DOS version |
| Reliability | Zero data loss, full transaction support |

---

## Migration Goals and Principles

### Primary Goals

1. **Preserve Business Value**
   - Maintain all calculation logic exactly as original
   - Support existing workflow patterns
   - Keep domain terminology consistent

2. **Modernize Technology Stack**
   - Replace file-based storage with SQLite relational database
   - Use modern UI patterns (context menus, toolbars, keyboard shortcuts)
   - Support contemporary Windows (10/11, high DPI, dark mode)

3. **Enhance Capabilities**
   - Add search across all projects
   - Implement undo/redo
   - Support export to Excel/PDF
   - Enable data backup/restore
   - Add audit trail

4. **Ensure Data Safety**
   - ACID transactions for all operations
   - Automatic backup functionality
   - Data validation and integrity constraints
   - Import verification tools

### Design Principles

**Principle 1: Respect the Domain**
- Keep German terminology in UI where appropriate
- Maintain 4-level hierarchy (4.Summe → Los → Titel → Position)
- Preserve calculation rules and formulas

**Principle 2: Progressive Disclosure**
- Show hierarchy clearly (TreeView)
- Display details on demand
- Support keyboard-driven power users

**Principle 3: Data Integrity First**
- All mutations in transactions
- Referential integrity enforced
- Input validation at database and UI layers

**Principle 4: Maintain Workflow Continuity**
- Honor original F-key conventions where practical
- Support rapid data entry patterns
- Minimize clicks for common operations

---

## Architecture Design

### Application Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│                      (WinForms)                              │
├──────────────┬──────────────┬──────────────┬────────────────┤
│ Main Window  │ Project Tree │ Position     │ Invoice        │
│ (MDI Parent) │ Explorer     │ Editor       │ Generator      │
└──────────────┴──────────────┴──────────────┴────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  Business Logic Layer                        │
│                  (Domain Services)                           │
├──────────────┬──────────────┬──────────────┬────────────────┤
│ Project      │ Position     │ Calculation  │ Reporting      │
│ Manager      │ Service      │ Engine       │ Service        │
└──────────────┴──────────────┴──────────────┴────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    Data Access Layer                         │
│                  (Repository Pattern)                        │
├──────────────┬──────────────┬──────────────┬────────────────┤
│ Project      │ Position     │ Customer     │ Import         │
│ Repository   │ Repository   │ Repository   │ Service        │
└──────────────┴──────────────┴──────────────┴────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                   SQLite Database                            │
│               (Single-file, transactional)                   │
└─────────────────────────────────────────────────────────────┘
```

### Technology Stack

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| Framework | .NET 10 | Latest LTS, modern C# features |
| UI | WinForms | Native Windows, familiar patterns |
| Database | SQLite | Single-file, embedded, no server |
| ORM | Dapper or EF Core | Type-safe queries, migration support |
| Reporting | FastReport / Crystal | Professional invoice generation |
| Testing | xUnit + FluentAssertions | Comprehensive test coverage |
| Logging | Serilog | Structured logging |

### Project Structure

```
Solon.sln
│
├─── Solon.Core/                    # Domain models, interfaces
│    ├─── Models/
│    │    ├─── Project.cs
│    │    ├─── FourthSum.cs
│    │    ├─── Lot.cs
│    │    ├─── Title.cs
│    │    ├─── Position.cs
│    │    ├─── Customer.cs
│    │    └─── Invoice.cs
│    ├─── Interfaces/
│    ├─── Enums/
│    └─── Constants/
│
├─── Solon.Data/                    # Data access, repositories
│    ├─── SolonDbContext.cs
│    ├─── Repositories/
│    ├─── Migrations/
│    └─── Import/
│         └─── DosImporter.cs
│
├─── Solon.Business/                # Business logic, services
│    ├─── Services/
│    │    ├─── ProjectService.cs
│    │    ├─── PositionService.cs
│    │    ├─── CalculationEngine.cs
│    │    └─── InvoiceService.cs
│    └─── Validators/
│
├─── Solon.WinForms/                # UI layer
│    ├─── Forms/
│    │    ├─── MainForm.cs
│    │    ├─── ProjectExplorerForm.cs
│    │    ├─── PositionEditorForm.cs
│    │    ├─── CustomerForm.cs
│    │    └─── InvoiceForm.cs
│    ├─── Controls/
│    ├─── Dialogs/
│    └─── Resources/
│
├─── Solon.Reporting/               # Report generation
│    ├─── Templates/
│    └─── Generators/
│
└─── Solon.Tests/                   # Unit and integration tests
     ├─── Unit/
     └─── Integration/
```

---

## Data Migration Strategy

### Phase 1: Analysis and Import Tool

**Objective:** Read all DOS project data and validate structure

**Implementation:**
1. Create `DosProjectScanner` class
   - Recursively scan C:\ partition structure
   - Identify all .PRJ directories
   - Catalog files by extension
   - Detect encoding (likely CP437 or CP850)

2. Create `DosDataReader` classes
   - `ProjectDefinitionReader` (.SOL files)
   - `PositionReader` (.POS files)
   - `TitleReader` (.TIT files)
   - `CustomerReader` (KUNDEN.DAT)

3. Build validation report
   - Count projects, titles, positions
   - Identify file format inconsistencies
   - Flag unreadable files
   - Generate migration readiness report

### Phase 2: Schema Mapping

**DOS Structure → SQLite Schema**

| DOS Element | SQLite Table | Notes |
|-------------|--------------|-------|
| Project directory | `Projects` | Single record per project |
| PRJKTDEF.SOL | `Projects` | Project metadata |
| 4SUMME*.4SM | `FourthSums` | Highest level grouping |
| LOS*.PRK | `Lots` | Lot grouping |
| *.TIT directory | `Titles` | Title records |
| *.POS file | `Positions` | Position details |
| KUNDEN.DAT | `Customers` | Customer master data |
| POSITION.PRK | `PositionIndex` | Match code index |

### Phase 3: Data Import Process

**Import Algorithm:**

```csharp
public class DosImporter
{
    public async Task<ImportResult> ImportProject(string dosProjectPath)
    {
        using var transaction = await _dbContext.Database.BeginTransactionAsync();
        
        try
        {
            // 1. Read project definition
            var projectDef = ReadProjectDefinition(dosProjectPath);
            var project = MapToProject(projectDef);
            await _projectRepo.AddAsync(project);
            
            // 2. Import hierarchy
            await ImportFourthSums(dosProjectPath, project.Id);
            await ImportLots(dosProjectPath, project.Id);
            await ImportTitles(dosProjectPath, project.Id);
            await ImportPositions(dosProjectPath, project.Id);
            
            // 3. Import customers if referenced
            await ImportReferencedCustomers(projectDef);
            
            // 4. Validate totals
            var validationResult = ValidateImportedData(project.Id);
            if (!validationResult.IsValid)
            {
                throw new ImportValidationException(validationResult.Errors);
            }
            
            await transaction.CommitAsync();
            return ImportResult.Success(project.Id);
        }
        catch (Exception ex)
        {
            await transaction.RollbackAsync();
            return ImportResult.Failure(ex.Message);
        }
    }
}
```

### Phase 4: Import Verification

**Verification Steps:**
1. Compare record counts (DOS vs SQLite)
2. Recalculate all totals and compare
3. Verify hierarchy integrity (all children have parents)
4. Check for data loss (field truncation, encoding issues)
5. Generate detailed import log

**Import UI:**
- Progress dialog with detailed status
- Preview mode (dry run without commit)
- Selective import (choose specific projects)
- Error reporting with retry capability

---

## Database Schema Design

### Core Tables

#### Projects Table

```sql
CREATE TABLE Projects (
    ProjectId INTEGER PRIMARY KEY AUTOINCREMENT,
    ProjectNumber TEXT NOT NULL UNIQUE,  -- e.g., "10", "20"
    ProjectName TEXT NOT NULL,           -- e.g., "Sample Project"
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CustomerId INTEGER,
    Status TEXT CHECK(Status IN ('Active', 'Archived', 'Completed')),
    Notes TEXT,
    -- Original DOS paths for reference
    OriginalDosPath TEXT,
    ImportedDate DATETIME,
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);

CREATE INDEX IX_Projects_ProjectNumber ON Projects(ProjectNumber);
CREATE INDEX IX_Projects_CustomerId ON Projects(CustomerId);
```

#### FourthSums Table

```sql
CREATE TABLE FourthSums (
    FourthSumId INTEGER PRIMARY KEY AUTOINCREMENT,
    ProjectId INTEGER NOT NULL,
    Code TEXT NOT NULL,              -- e.g., "4SSYSTEM"
    Description TEXT NOT NULL,
    SortOrder INTEGER NOT NULL,
    TotalAmount DECIMAL(18,2),       -- Calculated total
    FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId) ON DELETE CASCADE,
    UNIQUE(ProjectId, Code)
);

CREATE INDEX IX_FourthSums_ProjectId ON FourthSums(ProjectId);
```

#### Lots Table

```sql
CREATE TABLE Lots (
    LotId INTEGER PRIMARY KEY AUTOINCREMENT,
    FourthSumId INTEGER NOT NULL,
    Code TEXT NOT NULL,              -- e.g., "LOSSYSTM"
    Description TEXT NOT NULL,
    SortOrder INTEGER NOT NULL,
    TotalAmount DECIMAL(18,2),
    FOREIGN KEY (FourthSumId) REFERENCES FourthSums(FourthSumId) ON DELETE CASCADE,
    UNIQUE(FourthSumId, Code)
);

CREATE INDEX IX_Lots_FourthSumId ON Lots(FourthSumId);
```

#### Titles Table

```sql
CREATE TABLE Titles (
    TitleId INTEGER PRIMARY KEY AUTOINCREMENT,
    LotId INTEGER NOT NULL,
    TitleNumber TEXT NOT NULL,       -- e.g., "0010"
    Description TEXT NOT NULL,
    SortOrder INTEGER NOT NULL,
    TotalAmount DECIMAL(18,2),
    PositionCount INTEGER DEFAULT 0,
    FOREIGN KEY (LotId) REFERENCES Lots(LotId) ON DELETE CASCADE,
    UNIQUE(LotId, TitleNumber)
);

CREATE INDEX IX_Titles_LotId ON Titles(LotId);
```

#### Positions Table

```sql
CREATE TABLE Positions (
    PositionId INTEGER PRIMARY KEY AUTOINCREMENT,
    TitleId INTEGER NOT NULL,
    PositionNumber TEXT NOT NULL,    -- e.g., "00010#"
    MatchCode TEXT,                  -- Quick search code
    ShortDescription TEXT NOT NULL,  -- Brief description
    LongDescription TEXT,            -- Detailed specification
    -- Dimension fields
    Dimension1 DECIMAL(18,3),        -- Length, width, or quantity
    Dimension2 DECIMAL(18,3),        -- Width or height
    Dimension3 DECIMAL(18,3),        -- Height or depth
    CalculatedQuantity DECIMAL(18,3), -- Result of dimension calculation
    Unit TEXT,                       -- e.g., "m³", "m²", "Stk"
    -- Pricing
    UnitPrice DECIMAL(18,4),         -- Price per unit (Einheitspreis)
    TotalPrice DECIMAL(18,2),        -- Calculated: Quantity * UnitPrice
    -- Metadata
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (TitleId) REFERENCES Titles(TitleId) ON DELETE CASCADE,
    UNIQUE(TitleId, PositionNumber)
);

CREATE INDEX IX_Positions_TitleId ON Positions(TitleId);
CREATE INDEX IX_Positions_MatchCode ON Positions(MatchCode);
CREATE INDEX IX_Positions_PositionNumber ON Positions(PositionNumber);
```

#### Customers Table

```sql
CREATE TABLE Customers (
    CustomerId INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerNumber TEXT NOT NULL UNIQUE,
    CompanyName TEXT NOT NULL,
    ContactPerson TEXT,
    Street TEXT,
    PostalCode TEXT,
    City TEXT,
    Country TEXT DEFAULT 'Deutschland',
    Phone TEXT,
    Fax TEXT,
    Email TEXT,
    TaxId TEXT,                      -- Steuernummer
    VatId TEXT,                      -- USt-IdNr
    PaymentTerms TEXT,               -- e.g., "14 Tage 2% Skonto, 30 Tage netto"
    DefaultDiscount DECIMAL(5,2),    -- Default discount percentage
    Notes TEXT,
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL
);

CREATE INDEX IX_Customers_CustomerNumber ON Customers(CustomerNumber);
```

#### Invoices Table

```sql
CREATE TABLE Invoices (
    InvoiceId INTEGER PRIMARY KEY AUTOINCREMENT,
    ProjectId INTEGER NOT NULL,
    CustomerId INTEGER NOT NULL,
    InvoiceNumber TEXT NOT NULL UNIQUE,
    InvoiceDate DATE NOT NULL,
    InvoiceType TEXT CHECK(InvoiceType IN ('Angebot', 'Rechnung', 'Abschlag', 'Schlussrechnung')),
    -- Amounts
    NetAmount DECIMAL(18,2) NOT NULL,
    VatRate DECIMAL(5,2) NOT NULL,   -- e.g., 19.00 for 19%
    VatAmount DECIMAL(18,2) NOT NULL,
    GrossAmount DECIMAL(18,2) NOT NULL,
    -- Adjustments
    DiscountPercent DECIMAL(5,2),
    DiscountAmount DECIMAL(18,2),
    SurchargeAmount DECIMAL(18,2),
    RetentionPercent DECIMAL(5,2),
    RetentionAmount DECIMAL(18,2),
    -- Payment
    PaymentTerms TEXT,
    DueDate DATE,
    PaidDate DATE,
    PaidAmount DECIMAL(18,2),
    -- Content
    HeaderText TEXT,
    FooterText TEXT,
    Notes TEXT,
    -- Metadata
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    PrintedDate DATETIME,
    FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId),
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);

CREATE INDEX IX_Invoices_ProjectId ON Invoices(ProjectId);
CREATE INDEX IX_Invoices_CustomerId ON Invoices(CustomerId);
CREATE INDEX IX_Invoices_InvoiceNumber ON Invoices(InvoiceNumber);
```

#### InvoiceLineItems Table

```sql
CREATE TABLE InvoiceLineItems (
    LineItemId INTEGER PRIMARY KEY AUTOINCREMENT,
    InvoiceId INTEGER NOT NULL,
    PositionId INTEGER,              -- NULL for free-text items
    LineNumber INTEGER NOT NULL,
    Description TEXT NOT NULL,
    Quantity DECIMAL(18,3),
    Unit TEXT,
    UnitPrice DECIMAL(18,4),
    TotalPrice DECIMAL(18,2),
    FOREIGN KEY (InvoiceId) REFERENCES Invoices(InvoiceId) ON DELETE CASCADE,
    FOREIGN KEY (PositionId) REFERENCES Positions(PositionId)
);

CREATE INDEX IX_InvoiceLineItems_InvoiceId ON InvoiceLineItems(InvoiceId);
```

### Supporting Tables

#### AuditLog Table

```sql
CREATE TABLE AuditLog (
    AuditId INTEGER PRIMARY KEY AUTOINCREMENT,
    TableName TEXT NOT NULL,
    RecordId INTEGER NOT NULL,
    Operation TEXT CHECK(Operation IN ('INSERT', 'UPDATE', 'DELETE')),
    OldValues TEXT,                  -- JSON
    NewValues TEXT,                  -- JSON
    ChangedBy TEXT,
    ChangedDate DATETIME NOT NULL
);

CREATE INDEX IX_AuditLog_TableName ON AuditLog(TableName, RecordId);
```

#### Settings Table

```sql
CREATE TABLE Settings (
    SettingKey TEXT PRIMARY KEY,
    SettingValue TEXT,
    Description TEXT,
    ModifiedDate DATETIME NOT NULL
);

-- Default settings
INSERT INTO Settings VALUES 
    ('DefaultVatRate', '19.00', 'Default VAT rate in percent', datetime('now')),
    ('CompanyName', '', 'Company name for invoices', datetime('now')),
    ('CompanyAddress', '', 'Company address for invoices', datetime('now')),
    ('InvoiceNumberPrefix', 'RE', 'Prefix for invoice numbers', datetime('now')),
    ('NextInvoiceNumber', '1', 'Next invoice number', datetime('now'));
```

### Database Constraints and Business Rules

**Calculated Fields (via Triggers):**

```sql
-- Automatically update Position.TotalPrice
CREATE TRIGGER trg_Position_CalculateTotalPrice
AFTER INSERT ON Positions
BEGIN
    UPDATE Positions 
    SET TotalPrice = CalculatedQuantity * UnitPrice
    WHERE PositionId = NEW.PositionId;
END;

CREATE TRIGGER trg_Position_UpdateTotalPrice
AFTER UPDATE OF CalculatedQuantity, UnitPrice ON Positions
BEGIN
    UPDATE Positions 
    SET TotalPrice = NEW.CalculatedQuantity * NEW.UnitPrice
    WHERE PositionId = NEW.PositionId;
END;

-- Update Title totals
CREATE TRIGGER trg_Title_UpdateTotal
AFTER UPDATE OF TotalPrice ON Positions
BEGIN
    UPDATE Titles
    SET TotalAmount = (
        SELECT COALESCE(SUM(TotalPrice), 0)
        FROM Positions
        WHERE TitleId = NEW.TitleId
    )
    WHERE TitleId = NEW.TitleId;
END;

-- Update Lot totals
CREATE TRIGGER trg_Lot_UpdateTotal
AFTER UPDATE OF TotalAmount ON Titles
BEGIN
    UPDATE Lots
    SET TotalAmount = (
        SELECT COALESCE(SUM(TotalAmount), 0)
        FROM Titles
        WHERE LotId = (SELECT LotId FROM Titles WHERE TitleId = NEW.TitleId)
    )
    WHERE LotId = (SELECT LotId FROM Titles WHERE TitleId = NEW.TitleId);
END;
```

---

## User Interface Specifications

### Main Window (MDI Container)

**Layout:**

```
╔═══════════════════════════════════════════════════════════════╗
║ SOLON - Massenermittlung                                  [_][□][X]
╠═══════════════════════════════════════════════════════════════╣
║ [File] [Edit] [Project] [Position] [Invoice] [Tools] [Help]  ║
╠═══════════════════════════════════════════════════════════════╣
║ [New] [Open] [Save] | [Cut] [Copy] [Paste] | [Print] [PDF]   ║
╠════════════════════╦══════════════════════════════════════════╣
║ Project Explorer   ║                                          ║
║ ┬ 10 - Sample Proj ║   [Position Editor / Invoice View]      ║
║ ├─┬ 4SSYSTEM       ║                                          ║
║ │ └─┬ LOSSYSTM     ║      (MDI Child Window Area)            ║
║ │   └─┬ 0010 Titel ║                                          ║
║ │     ├─ Pos 00010#║                                          ║
║ │     └─ Pos 00020#║                                          ║
║ └─┬ Other 4Sum     ║                                          ║
║   └─ ...           ║                                          ║
║                    ║                                          ║
║ [+] [-] [Edit]     ║                                          ║
╠════════════════════╩══════════════════════════════════════════╣
║ Ready | Project: 10 | Positions: 234 | Total: 123.456,78 EUR ║
╚═══════════════════════════════════════════════════════════════╝
```

**Menu Structure:**

**File Menu:**
- New Project (Ctrl+N)
- Open Project (Ctrl+O)
- Close Project
- ---
- Import DOS Project (Ctrl+I)
- Export to Excel
- ---
- Recent Projects ▶
- ---
- Exit (Alt+F4)

**Edit Menu:**
- Undo (Ctrl+Z)
- Redo (Ctrl+Y)
- ---
- Cut (Ctrl+X)
- Copy (Ctrl+C)
- Paste (Ctrl+V)
- Delete (Del)
- ---
- Find (Ctrl+F)
- Find Next (F3)

**Project Menu:**
- Project Properties
- Project Settings
- ---
- Add 4th Sum
- Add Lot
- Add Title
- ---
- Recalculate Totals
- Validate Hierarchy

**Position Menu:**
- New Position (Ins)
- Edit Position (Enter)
- Delete Position (Del)
- Duplicate Position (Ctrl+D)
- ---
- Position Properties
- Match Code Manager

**Invoice Menu:**
- Generate Invoice
- Generate Quote (Angebot)
- Partial Invoice (Abschlag)
- Final Invoice (Schlussrechnung)
- ---
- Invoice Templates
- Invoice History

**Tools Menu:**
- Customer Management
- Settings
- Backup Database
- Restore Database
- ---
- Database Maintenance
- Import Log Viewer

**Help Menu:**
- User Manual (F1)
- About SOLON

### Project Explorer (Dockable Panel)

**TreeView Configuration:**
- Icons for each level (distinctive visual hierarchy)
- Context menu per node type
- Drag-and-drop support for reordering
- Double-click to edit
- Bold font for totals

**Node Context Menus:**

**Project Node:**
- Open
- Properties
- Close
- ---
- Delete Project

**4th Sum Node:**
- Add Lot
- Edit
- Delete
- ---
- Expand All
- Collapse All

**Lot Node:**
- Add Title
- Edit
- Delete
- ---
- Move to Different 4th Sum

**Title Node:**
- Add Position
- Edit
- Delete
- ---
- Move to Different Lot
- ---
- Print Title Report

**Position Node:**
- Edit
- Duplicate
- Delete
- ---
- View History

### Position Editor Form

**Layout (Modal Dialog or MDI Child):**

```
╔═══════════════════════════════════════════════════════════════╗
║ Position Editor - Title 0010                          [_][□][X]
╠═══════════════════════════════════════════════════════════════╣
║ Position Number: [00010#    ]  Match Code: [BETP25   ]       ║
║                                                                ║
║ Short Description:                                             ║
║ ┌────────────────────────────────────────────────────────────┐║
║ │ Beton C25/30, Fundament                                    │║
║ └────────────────────────────────────────────────────────────┘║
║                                                                ║
║ Long Description:                                              ║
║ ┌────────────────────────────────────────────────────────────┐║
║ │ Fundamentbeton C25/30 gemäß DIN 1045                       │║
║ │ einschließlich Schalung, Bewehrung und Verdichtung        │║
║ │                                                            │║
║ └────────────────────────────────────────────────────────────┘║
║                                                                ║
║ ┌─ Dimensions ─────────────────────────────────────────────┐ ║
║ │ Dim 1: [  12.50] × Dim 2: [   8.00] × Dim 3: [  0.40]   │ ║
║ │                                                           │ ║
║ │ Calculated Quantity: [  40.00]  Unit: [m³ ▼]            │ ║
║ └───────────────────────────────────────────────────────────┘ ║
║                                                                ║
║ ┌─ Pricing ────────────────────────────────────────────────┐ ║
║ │ Unit Price:      [    125.50] EUR/m³                     │ ║
║ │ Total Price:     [  5,020.00] EUR                        │ ║
║ └───────────────────────────────────────────────────────────┘ ║
║                                                                ║
║ Notes:                                                         ║
║ ┌────────────────────────────────────────────────────────────┐║
║ │                                                            │║
║ └────────────────────────────────────────────────────────────┘║
║                                                                ║
║                           [OK]  [Cancel]  [Apply]             ║
╚═══════════════════════════════════════════════════════════════╝
```

**Field Validation:**
- Position Number: Required, unique within Title
- Short Description: Required, max 80 characters
- Dimensions: Numeric, 3 decimal places
- Unit Price: Numeric, 4 decimal places
- Auto-calculate Total Price on any change

**Keyboard Shortcuts:**
- Ctrl+S: Save and stay open
- Enter: Save and close (if valid)
- Esc: Cancel changes
- F2: Edit match code
- Tab: Navigate fields logically

### Customer Management Form

**Layout (MDI Child or Modal):**

```
╔═══════════════════════════════════════════════════════════════╗
║ Customer Management                                   [_][□][X]
╠═══════════════════════════════════════════════════════════════╣
║ [New] [Edit] [Delete] [Search...]                             ║
╠═══════════════════════════════════════════════════════════════╣
║ ┌────────────────────────────────────────────────────────────┐║
║ │ No.  │ Company Name        │ City        │ Phone          │║
║ ├──────┼─────────────────────┼─────────────┼────────────────┤║
║ │ 1001 │ Müller GmbH         │ München     │ 089-12345     │║
║ │ 1002 │ Schmidt AG          │ Stuttgart   │ 0711-98765    │║
║ │ 1003 │ Weber & Co KG       │ Frankfurt   │ 069-55555     │║
║ │ ...  │                     │             │                │║
║ └────────────────────────────────────────────────────────────┘║
║                                                                ║
║ 127 customers total                           [Close]         ║
╚═══════════════════════════════════════════════════════════════╝
```

**Customer Detail Form:**
- Tabbed interface (General, Address, Financial, Projects, Notes)
- Auto-complete for City based on PostalCode
- Validation for TaxId, VatId formats
- List of associated projects

### Invoice Generator Form

**Wizard-style Interface:**

**Step 1: Select Type**
- Quote (Angebot)
- Invoice (Rechnung)
- Partial Invoice (Abschlagsrechnung)
- Final Invoice (Schlussrechnung)

**Step 2: Select Positions**
- Tree view with checkboxes
- Select all / Deselect all
- Preview quantities and amounts

**Step 3: Adjustments**
- Discount percentage
- Surcharges
- Retention amount
- VAT rate (default 19%)

**Step 4: Invoice Details**
- Invoice number (auto-generated, editable)
- Invoice date
- Payment terms
- Header text / Footer text

**Step 5: Preview and Print**
- PDF preview
- Print to printer
- Save as PDF
- Email (future feature)

---

## Functional Requirements

### FR-001: Project Management

**FR-001.1: Create New Project**
- User enters project number and name
- System validates uniqueness of project number
- System creates project with default structure (if configured)
- System sets CreatedDate, ModifiedDate to current timestamp

**FR-001.2: Open Existing Project**
- User selects project from list or recent projects
- System loads project hierarchy into tree view
- System displays project summary in status bar

**FR-001.3: Import DOS Project**
- User selects DOS project directory
- System scans directory structure
- System displays import preview (record counts)
- User confirms import
- System imports all data transactionally
- System generates import log
- System displays success message with statistics

**FR-001.4: Close Project**
- System prompts to save if unsaved changes exist
- System closes all child windows for that project
- System removes project from tree view

**FR-001.5: Delete Project**
- User selects project and chooses Delete
- System prompts for confirmation
- System deletes project and all related data (cascade)
- System logs deletion in audit log

### FR-002: Hierarchy Management

**FR-002.1: Add 4th Sum**
- User right-clicks project node and selects Add 4th Sum
- System prompts for Code and Description
- System validates uniqueness within project
- System creates 4th Sum with auto-assigned SortOrder
- System refreshes tree view

**FR-002.2: Add Lot**
- User right-clicks 4th Sum node and selects Add Lot
- System prompts for Code and Description
- System validates uniqueness within 4th Sum
- System creates Lot with auto-assigned SortOrder
- System refreshes tree view

**FR-002.3: Add Title**
- User right-clicks Lot node and selects Add Title
- System prompts for Title Number and Description
- System validates uniqueness within Lot
- System creates Title with auto-assigned SortOrder
- System refreshes tree view

**FR-002.4: Reorder Items**
- User drags node to new position
- System updates SortOrder values
- System saves changes
- System refreshes tree view

**FR-002.5: Move Items**
- User drags Title to different Lot
- System prompts for confirmation
- System updates parent relationship
- System recalculates totals for old and new parent
- System refreshes tree view

### FR-003: Position Management

**FR-003.1: Add Position**
- User right-clicks Title node or presses Insert key
- System opens Position Editor with empty form
- User enters position data
- System validates all fields
- System calculates TotalPrice
- System saves position
- System updates Title total
- System refreshes tree view

**FR-003.2: Edit Position**
- User double-clicks position or presses Enter
- System opens Position Editor with existing data
- User modifies fields
- System validates changes
- System recalculates TotalPrice if needed
- System saves changes
- System updates Title total if price changed
- System refreshes tree view

**FR-003.3: Delete Position**
- User selects position and presses Delete or chooses Delete from menu
- System prompts for confirmation
- System checks if position is referenced in any invoices
- If referenced, system warns and asks to proceed
- System deletes position (soft delete if referenced)
- System updates Title total
- System refreshes tree view

**FR-003.4: Duplicate Position**
- User selects position and presses Ctrl+D
- System creates copy with incremented position number
- System opens Position Editor for new position
- User modifies as needed
- System saves new position

**FR-003.5: Match Code Search**
- User enters match code in search field
- System searches all positions in current project
- System displays matching positions in results list
- User selects position from results
- System navigates tree view to position and opens editor

### FR-004: Calculation Engine

**FR-004.1: Position Total Calculation**
- When user changes Dimension1, Dimension2, or Dimension3:
  - System calculates: CalculatedQuantity = Dim1 × Dim2 × Dim3
  - System rounds to 3 decimal places
- When user changes CalculatedQuantity or UnitPrice:
  - System calculates: TotalPrice = CalculatedQuantity × UnitPrice
  - System rounds to 2 decimal places

**FR-004.2: Title Total Calculation**
- When any position price changes in Title:
  - System sums all TotalPrice values in Title
  - System updates Title.TotalAmount
  - System triggers Lot total calculation

**FR-004.3: Lot Total Calculation**
- When any Title total changes in Lot:
  - System sums all TotalAmount values in Lot
  - System updates Lot.TotalAmount
  - System triggers 4th Sum total calculation

**FR-004.4: 4th Sum Total Calculation**
- When any Lot total changes in 4th Sum:
  - System sums all TotalAmount values in 4th Sum
  - System updates FourthSum.TotalAmount
  - System triggers project total recalculation

**FR-004.5: Manual Recalculation**
- User selects Recalculate Totals from Project menu
- System recalculates all totals bottom-up (Position → Title → Lot → 4thSum)
- System displays confirmation message with updated totals

### FR-005: Invoice Generation

**FR-005.1: Create Quote**
- User selects Generate Invoice → Quote
- System opens Invoice Wizard
- User follows wizard steps
- System generates invoice record with InvoiceType = 'Angebot'
- System creates line items for selected positions
- System does NOT mark positions as billed
- System generates PDF or sends to printer

**FR-005.2: Create Invoice**
- User selects Generate Invoice → Invoice
- System opens Invoice Wizard
- User selects positions (can be subset)
- User enters adjustments, payment terms
- System generates invoice with unique InvoiceNumber
- System calculates NetAmount, VatAmount, GrossAmount
- System creates invoice record and line items
- System generates PDF or sends to printer

**FR-005.3: Create Partial Invoice**
- User selects Generate Invoice → Partial Invoice
- System opens Invoice Wizard
- System shows previously billed amounts
- User selects additional positions or partial quantities
- System creates invoice with InvoiceType = 'Abschlag'
- System tracks billed amounts
- System generates PDF or sends to printer

**FR-005.4: Create Final Invoice**
- User selects Generate Invoice → Final Invoice
- System calculates total project amount
- System subtracts all previous partial invoices
- System applies retention release if configured
- System creates invoice with InvoiceType = 'Schlussrechnung'
- System marks project as fully invoiced
- System generates PDF or sends to printer

**FR-005.5: Invoice Template**
- System uses configurable template for invoice layout
- Template includes:
  - Company logo and information
  - Customer information
  - Invoice number, date
  - Line items table (Position #, Description, Qty, Unit, Unit Price, Total)
  - Subtotal, discount, surcharges
  - VAT calculation
  - Gross total
  - Payment terms
  - Footer text

### FR-006: Customer Management

**FR-006.1: Add Customer**
- User opens Customer Management and clicks New
- System opens Customer Detail Form
- User enters customer data
- System validates required fields (Company Name, Customer Number)
- System checks uniqueness of Customer Number
- System saves customer
- System adds to customer list

**FR-006.2: Edit Customer**
- User selects customer and clicks Edit
- System opens Customer Detail Form with existing data
- User modifies fields
- System validates changes
- System saves customer
- System updates customer list

**FR-006.3: Delete Customer**
- User selects customer and clicks Delete
- System checks if customer is referenced in any projects
- If referenced, system prevents deletion and shows message
- If not referenced, system prompts for confirmation
- System deletes customer
- System updates customer list

**FR-006.4: Search Customer**
- User enters search term in search field
- System searches CustomerNumber, CompanyName, ContactPerson
- System filters customer list to matches
- User can clear search to show all

### FR-007: Data Import/Export

**FR-007.1: Import DOS Project**
- See FR-001.3

**FR-007.2: Export to Excel**
- User selects Export to Excel from File menu
- User selects export scope (Current Project, Selected Titles, All Projects)
- System generates Excel file with worksheets:
  - Project Summary
  - Hierarchy (4th Sums, Lots, Titles)
  - Position Details
  - Totals by Level
- System opens Excel file or prompts to save

**FR-007.3: Export to PDF**
- User selects Export to PDF
- User selects report type (Project Report, Position List, Invoice)
- System generates PDF using configured template
- System opens PDF viewer or prompts to save

**FR-007.4: Backup Database**
- User selects Backup Database from Tools menu
- System prompts for backup location
- System creates timestamped copy of SQLite database file
- System creates backup log entry
- System displays confirmation message

**FR-007.5: Restore Database**
- User selects Restore Database from Tools menu
- User selects backup file
- System validates backup file
- System prompts for confirmation (warns data will be replaced)
- System closes all open projects
- System replaces current database with backup
- System reopens application
- System displays confirmation message

### FR-008: Search and Navigation

**FR-008.1: Global Search**
- User presses Ctrl+F or selects Find from Edit menu
- System opens Search dialog
- User enters search term
- User selects search scope (Position Description, Match Code, All Text)
- User optionally limits to current project or searches all projects
- System executes search
- System displays results list with:
  - Project Number
  - Hierarchy path (4thSum → Lot → Title → Position)
  - Matching text snippet
- User double-clicks result
- System navigates to position and opens editor

**FR-008.2: Find Next**
- User presses F3 or selects Find Next from Edit menu
- System navigates to next search result
- System highlights match in editor

**FR-008.3: Recent Projects**
- User selects File → Recent Projects
- System displays submenu with last 10 opened projects
- User selects project
- System opens selected project

**FR-008.4: Jump to Position**
- User presses Ctrl+G (Go To)
- System opens Jump dialog
- User enters Position Number or Match Code
- System finds matching position in current project
- System navigates tree view and opens editor

### FR-009: Undo/Redo Support

**FR-009.1: Undo**
- User presses Ctrl+Z or selects Undo from Edit menu
- System reverts last change
- Supported operations:
  - Position add/edit/delete
  - Hierarchy item add/edit/delete
  - Customer add/edit/delete
- System updates UI to reflect reverted state
- System updates status bar with undo description

**FR-009.2: Redo**
- User presses Ctrl+Y or selects Redo from Edit menu
- System reapplies last undone change
- System updates UI to reflect reapplied state
- System updates status bar with redo description

**FR-009.3: Undo History**
- System maintains undo stack of last 50 operations per project
- System clears undo stack when project is closed
- System disables Undo menu item when stack is empty

### FR-010: Settings and Configuration

**FR-010.1: Application Settings**
- User selects Tools → Settings
- System opens Settings dialog with tabs:
  - General (UI preferences, date formats)
  - Invoice (default VAT rate, invoice numbering)
  - Company (company info for invoices)
  - Database (backup location, auto-backup interval)
  - Advanced (logging level, performance options)
- User modifies settings
- System validates settings
- System saves to Settings table
- System applies settings immediately where possible

**FR-010.2: Project-Specific Settings**
- User selects Project → Project Settings
- System opens Project Settings dialog
- User configures:
  - Default VAT rate for this project
  - Retention percentage
  - Default discount
  - Invoice header/footer templates
- System saves to project record
- System applies to future invoices for this project

---

## Non-Functional Requirements

### NFR-001: Performance

**NFR-001.1: Response Time**
- Project open: < 1 second for typical project (< 5000 positions)
- Position save: < 100 ms
- Tree view refresh: < 500 ms
- Search results: < 2 seconds for full database search
- Invoice generation: < 3 seconds

**NFR-001.2: Scalability**
- Support projects with up to 50,000 positions
- Support database with up to 1000 projects
- Support customer database with up to 10,000 customers

**NFR-001.3: Memory Usage**
- Maximum working set: 500 MB for typical usage
- Application startup: < 3 seconds on modern hardware

### NFR-002: Usability

**NFR-002.1: Learnability**
- Users familiar with DOS version should be productive within 1 hour
- New users should complete basic tasks within 2 hours with documentation

**NFR-002.2: Accessibility**
- Full keyboard navigation support
- High-contrast mode support
- Screen reader compatibility (NVDA, JAWS)
- Scalable UI for high DPI displays

**NFR-002.3: User Interface**
- Consistent with Windows UI guidelines
- Responsive (no UI freezing during operations)
- Clear error messages with suggested actions
- Confirmation dialogs for destructive operations

### NFR-003: Reliability

**NFR-003.1: Data Integrity**
- Zero data loss under normal operation
- Transactional consistency (all-or-nothing for multi-table operations)
- Automatic backup before major operations (project delete, import)
- Referential integrity enforced by database constraints

**NFR-003.2: Error Handling**
- Graceful degradation on errors
- User-friendly error messages
- Detailed error logging for troubleshooting
- Automatic error reporting (optional, with user consent)

**NFR-003.3: Availability**
- Application startup success rate: > 99.9%
- No data corruption on unexpected shutdown
- Database recovery on corruption

### NFR-004: Maintainability

**NFR-004.1: Code Quality**
- Unit test coverage: > 80% for business logic
- Integration test coverage: > 60% for data access layer
- XML documentation for all public APIs
- Code analysis (StyleCop, SonarAnalyzer) with zero warnings

**NFR-004.2: Logging**
- Structured logging with Serilog
- Log levels: Trace, Debug, Information, Warning, Error, Fatal
- Log rotation (daily, max 30 days)
- Performance logging for slow operations (> 1 second)

**NFR-004.3: Configuration**
- Externalized configuration (appsettings.json)
- Environment-specific overrides
- No hardcoded paths or connection strings

### NFR-005: Security

**NFR-005.1: Data Protection**
- Database file encryption (optional)
- Sensitive data (customer financial info) encrypted at rest
- Secure backup storage recommendations

**NFR-005.2: User Authentication**
- Single-user application (no multi-user authentication in v1)
- Audit log for all data modifications
- User identification via Windows username

**NFR-005.3: Input Validation**
- All user input validated before processing
- SQL injection prevention (parameterized queries)
- Path traversal prevention (file operations)

### NFR-006: Portability

**NFR-006.1: Platform Support**
- Windows 10 (version 1809 or later)
- Windows 11
- Both 32-bit and 64-bit (prefer 64-bit)

**NFR-006.2: Dependencies**
- .NET 10 Runtime (bundled with installer)
- No external database server required
- Minimal 3rd-party dependencies

---

## Implementation Roadmap

### Phase 1: Foundation (Weeks 1-4)

**Week 1-2: Project Setup and Core Infrastructure**
- Create solution structure
- Set up CI/CD pipeline (GitHub Actions or Azure DevOps)
- Implement Solon.Core (domain models, interfaces)
- Implement Solon.Data (DbContext, repositories)
- Create database schema and migrations
- Write unit tests for core models

**Week 3-4: DOS Import and Data Migration**
- Implement DosProjectScanner
- Implement file format readers (SOL, POS, TIT, etc.)
- Build import service with validation
- Create import UI (console app or simple WinForms)
- Test with sample DOS projects
- Generate import documentation

**Deliverables:**
- Working database schema
- DOS import tool with 100% success rate on test projects
- Foundation code with > 80% test coverage

### Phase 2: Business Logic (Weeks 5-8)

**Week 5-6: Business Services**
- Implement ProjectService
- Implement PositionService with calculation engine
- Implement CustomerService
- Implement validation logic
- Write comprehensive unit tests

**Week 7-8: Invoice Generation**
- Implement InvoiceService
- Create invoice calculation logic
- Implement PDF generation (evaluate FastReport, QuestPDF, or iText)
- Create invoice templates
- Test invoice calculations against DOS-generated invoices

**Deliverables:**
- Complete business logic layer
- Invoice generation with PDF output
- Business logic tests with > 85% coverage

### Phase 3: User Interface (Weeks 9-14)

**Week 9-10: Main Window and Project Explorer**
- Create MDI main window
- Implement menu system
- Build project tree view with icons
- Implement context menus
- Add drag-and-drop support

**Week 11-12: Position Editor and Dialogs**
- Create Position Editor form
- Implement field validation and auto-calculation
- Build Customer Management form
- Create Project Settings dialog
- Implement Application Settings dialog

**Week 13-14: Invoice UI and Reporting**
- Build Invoice Wizard
- Implement invoice preview
- Create print dialog
- Add export functionality (Excel, PDF)
- Implement search dialog and global search

**Deliverables:**
- Complete WinForms UI
- All forms functional and tested
- UI meets accessibility standards

### Phase 4: Advanced Features (Weeks 15-16)

**Week 15: Undo/Redo and Search**
- Implement Command pattern for undo/redo
- Build undo stack management
- Implement global search with highlighting
- Add Jump To Position feature
- Create recent projects list

**Week 16: Polish and Optimization**
- Performance profiling and optimization
- Memory leak detection and fixes
- UI responsiveness improvements
- Icon and visual design refinement
- Keyboard shortcut testing

**Deliverables:**
- Undo/redo fully functional
- Search with < 2 second response time
- Polished, responsive UI

### Phase 5: Testing and Documentation (Weeks 17-18)

**Week 17: Testing**
- Integration testing (UI + Business + Data)
- End-to-end testing scenarios
- Performance testing (large projects)
- Stress testing (boundary conditions)
- User acceptance testing (UAT) with stakeholders

**Week 18: Documentation and Deployment**
- User manual (PDF and online help)
- Administrator guide (installation, backup, troubleshooting)
- Developer documentation (architecture, API docs)
- Create installer (WiX or ClickOnce)
- Deployment testing

**Deliverables:**
- Complete test suite (unit + integration + E2E)
- Comprehensive documentation
- Production-ready installer

### Phase 6: Deployment and Support (Week 19+)

**Week 19: Beta Deployment**
- Deploy to selected beta users
- Monitor usage and collect feedback
- Fix critical bugs
- Refine UI based on feedback

**Week 20+: Production Release and Support**
- Public release
- Monitor for issues
- Provide user support
- Plan v1.1 enhancements

---

## Risk Assessment

### Technical Risks

**Risk 1: DOS Data Format Ambiguity**
- **Probability:** Medium
- **Impact:** High
- **Mitigation:**
  - Analyze multiple DOS project samples
  - Create comprehensive format documentation
  - Build flexible parser with error tolerance
  - Provide manual correction tools for edge cases

**Risk 2: Performance with Large Projects**
- **Probability:** Low
- **Impact:** Medium
- **Mitigation:**
  - Profile early and often
  - Implement lazy loading for tree view
  - Use database indices effectively
  - Consider pagination for very large position lists

**Risk 3: PDF Generation Library Limitations**
- **Probability:** Low
- **Impact:** Medium
- **Mitigation:**
  - Evaluate multiple libraries early
  - Create abstraction layer for PDF generation
  - Fallback to HTML + browser printing if needed

**Risk 4: Complex Calculation Logic Bugs**
- **Probability:** Medium
- **Impact:** High
- **Mitigation:**
  - Comprehensive unit tests for calculation engine
  - Cross-validate with DOS version outputs
  - Independent code review of calculation logic
  - Create test cases from real-world projects

### Business Risks

**Risk 5: User Resistance to UI Changes**
- **Probability:** Medium
- **Impact:** Medium
- **Mitigation:**
  - Preserve familiar workflows where possible
  - Provide extensive training materials
  - Implement "classic" keyboard shortcuts
  - Collect early user feedback

**Risk 6: Data Migration Issues**
- **Probability:** Medium
- **Impact:** High
- **Mitigation:**
  - Never modify original DOS files
  - Provide preview mode for imports
  - Create detailed import logs
  - Support selective re-import of failed items

**Risk 7: Hidden DOS Features**
- **Probability:** Medium
- **Impact:** Medium
- **Mitigation:**
  - Interview original users
  - Analyze DOS code thoroughly
  - Implement analytics to track feature usage
  - Plan for quick feature additions post-launch

### Organizational Risks

**Risk 8: Timeline Pressure**
- **Probability:** Medium
- **Impact:** Medium
- **Mitigation:**
  - Prioritize features (MVP vs nice-to-have)
  - Use iterative development
  - Plan for phased rollout
  - Maintain technical debt log

**Risk 9: Key Person Dependency**
- **Probability:** Low
- **Impact:** High
- **Mitigation:**
  - Comprehensive code documentation
  - Pair programming for critical components
  - Knowledge sharing sessions
  - Architecture documentation

---

## Appendices

### Appendix A: Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Ctrl+N | New Project |
| Ctrl+O | Open Project |
| Ctrl+S | Save |
| Ctrl+Z | Undo |
| Ctrl+Y | Redo |
| Ctrl+F | Find |
| F3 | Find Next |
| Ctrl+G | Go To Position |
| Ctrl+I | Import DOS Project |
| Ins | New Position |
| Enter | Edit Position |
| Del | Delete Position |
| Ctrl+D | Duplicate Position |
| F1 | Help |

### Appendix B: Database Maintenance

**Vacuum Database:**
```sql
VACUUM;
```
Run monthly or after large deletions.

**Analyze Tables:**
```sql
ANALYZE;
```
Run after major data imports.

**Integrity Check:**
```sql
PRAGMA integrity_check;
```
Run before backups.

### Appendix C: Sample Migration Script

```csharp
public class MigrationSample
{
    public async Task MigrateAllProjectsAsync(string dosRootPath)
    {
        var scanner = new DosProjectScanner();
        var projects = await scanner.ScanDirectoryAsync(dosRootPath);
        
        var results = new List<ImportResult>();
        
        foreach (var projectPath in projects)
        {
            var importer = new DosImporter(_dbContext);
            var result = await importer.ImportProjectAsync(projectPath);
            results.Add(result);
            
            if (result.IsSuccess)
            {
                Console.WriteLine($"✓ Imported: {projectPath}");
            }
            else
            {
                Console.WriteLine($"✗ Failed: {projectPath}");
                Console.WriteLine($"  Error: {result.ErrorMessage}");
            }
        }
        
        GenerateMigrationReport(results);
    }
}
```

### Appendix D: Unit Test Examples

**Position Calculation Test:**
```csharp
[Fact]
public void Position_CalculatesTotalPrice_Correctly()
{
    // Arrange
    var position = new Position
    {
        Dimension1 = 12.5m,
        Dimension2 = 8.0m,
        Dimension3 = 0.4m,
        UnitPrice = 125.50m
    };
    
    // Act
    position.CalculateQuantity();
    position.CalculateTotalPrice();
    
    // Assert
    Assert.Equal(40.0m, position.CalculatedQuantity);
    Assert.Equal(5020.0m, position.TotalPrice);
}
```

**Hierarchy Total Calculation Test:**
```csharp
[Fact]
public async Task Title_UpdatesTotal_WhenPositionPriceChanges()
{
    // Arrange
    var title = CreateSampleTitle();
    await _titleRepo.AddAsync(title);
    
    var position = new Position 
    { 
        TitleId = title.TitleId, 
        CalculatedQuantity = 10m, 
        UnitPrice = 100m 
    };
    await _positionRepo.AddAsync(position);
    
    // Act
    position.UnitPrice = 150m;
    await _positionRepo.UpdateAsync(position);
    
    // Assert
    var updatedTitle = await _titleRepo.GetByIdAsync(title.TitleId);
    Assert.Equal(1500m, updatedTitle.TotalAmount);
}
```

---

## Conclusion

This specification provides a complete blueprint for migrating the SOLON DOS application to .NET 10 WinForms. The migration preserves all domain functionality while modernizing the technical foundation and user experience.

**Key Success Factors:**
1. Faithful preservation of business logic
2. Comprehensive data migration with validation
3. Modern, usable interface respecting learned workflows
4. Robust database design with referential integrity
5. Thorough testing at all layers
6. Clear documentation for users and developers

**Next Steps:**
1. Review and approve specification
2. Set up development environment
3. Begin Phase 1 implementation
4. Establish regular stakeholder check-ins

---

**Document Status:** Draft v1.0  
**Author:** Migration Team  
**Approval Required:** Project Stakeholders  
**Target Start Date:** TBD

---

**End of Part 3**

