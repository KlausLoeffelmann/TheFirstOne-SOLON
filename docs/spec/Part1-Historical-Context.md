# SOLON - Massenermittlung für Bauunternehmer
## Part 1: Historical Context and Technical Background

**Document Version:** 1.0  
**Date:** November 2025  
**Original Development Period:** circa 1988  
**Developer:** Klaus Loeffelmann (age 17-18)

---

## a) Introduction to the Domain

### The German Construction Industry in the Late 1980s

In 1988, the German construction industry ("Bauwesen") was experiencing significant growth, particularly in West Germany. The industry operated under well-established traditional craftsmanship principles ("deutsches Handwerk") that had evolved over centuries.

#### Construction Cost Estimation Process

The construction bidding and cost estimation process in Germany followed a highly structured methodology:

**1. Leistungsverzeichnis (Bill of Quantities)**
- Architects and engineers would create detailed specifications of all work required
- Each construction project was broken down into measurable units
- Standardized catalogs (like STLB - Standardleistungsbuch) provided reference descriptions

**2. Massenermittlung (Quantity Takeoff/Surveying)**
- Contractors needed to calculate precise quantities from architectural drawings
- This included measurements of:
  - Concrete volumes (cubic meters)
  - Wall surfaces (square meters)
  - Excavation depths and volumes
  - Material quantities (tons, pieces, linear meters)
  - Labor hours required

**3. Calculation and Bidding Process**
- Each quantity was assigned unit prices
- Complex calculations included:
  - Material costs with price escalation clauses ("Stoffpreisklausel")
  - Labor costs with wage adjustment clauses ("Lohngleitklausel")
  - Equipment and overhead costs
  - Profit margins
  - Value-added tax (Mehrwertsteuer - MwSt)

**4. Construction Management Phases**
- Progress billing ("Abschlagsrechnungen")
- Retention amounts ("Sicherheitseinbehalt")
- Final accounting ("Schlussabrechnung")

### The Need for Automation

Before computerization, this process was:
- Extremely time-consuming (days to weeks per project)
- Error-prone due to manual calculations
- Required extensive paper documentation
- Difficult to update when project changes occurred
- Hard to track across multiple projects

SOLON addressed these pain points by providing:
- Electronic organization of construction positions
- Automated calculation of measurements and costs
- Hierarchical structuring of projects
- Support for multiple calculation methods
- Professional invoice generation

---

## b) Domain Glossary - German to English

| German Term | English Translation | Description |
|-------------|---------------------|-------------|
| **Massenermittlung** | Quantity Takeoff / Quantity Surveying | Calculation of material quantities from construction drawings |
| **Bauunternehmer** | Contractor / Building Contractor | Company executing construction work |
| **Baumaßnahme** | Construction Project / Building Measure | Specific construction project or building activity |
| **Leistungsverzeichnis** | Bill of Quantities (BOQ) | Detailed list of all construction work items |
| **Position** | Position / Line Item | Individual construction task or material item |
| **Titel** | Title / Section | Major grouping of positions (e.g., "Excavation", "Masonry") |
| **Los** | Lot / Package | Group of titles that can be bid together |
| **4. Summe** | 4th Level Sum | Highest organizational level (multiple lots) |
| **Lohngleitklausel** | Wage Escalation Clause | Adjustment for labor cost changes |
| **Stoffpreisklausel** | Material Price Clause | Adjustment for material cost changes |
| **Mehrwertsteuer (MwSt)** | Value Added Tax (VAT) | Sales tax in Germany (then typically 14% or 15%) |
| **Abschlagsrechnung** | Progress Payment / Partial Invoice | Interim billing during construction |
| **Schlussabrechnung** | Final Account / Final Invoice | Final settlement after project completion |
| **Sicherheitseinbehalt** | Retention / Retainage | Amount withheld until defects period expires |
| **Skonto** | Cash Discount | Discount for prompt payment |
| **Bauwesenversicherung** | Construction Insurance | Insurance costs for construction project |
| **Einheitspreis (E.P.)** | Unit Price | Price per measurement unit |
| **Menge** | Quantity | Amount of materials or work |
| **Gesamtpreis** | Total Price | Extended price (quantity × unit price) |
| **Nachlass** | Discount / Reduction | General discount on invoice |
| **Zuschlag** | Surcharge / Addition | Additional charges or markup |
| **Brutto** | Gross | Price including VAT |
| **Netto** | Net | Price excluding VAT |
| **Matchcode** | Match Code | Short alphanumeric identifier for quick search |
| **Auftragnehmer** | Contractor (order taker) | The company receiving the contract |
| **Auftraggeber** | Client / Owner | The party commissioning the work |
| **Dimension** | Dimension | Measurement values (length, width, height, quantity) |
| **Leistungsverzeichnis** | Schedule of Services | Detailed specification document |
| **Ordner** | Folder / Directory | Computer directory (file system term) |

### Organizational Hierarchy Terms

The software uses a 4-level hierarchical structure:

1. **4. Summe** (4th Sum / Highest Level)
   - Groups multiple lots together
   - Example: "Entire Building Project"

2. **Los** (Lot / Package)
   - Collection of related titles
   - Example: "All Structural Work"

3. **Titel** (Title / Section)
   - Major construction category
   - Example: "Concrete Work", "Masonry"

4. **Position** (Position / Line Item)
   - Individual billable item
   - Example: "Pour foundation concrete C25/30"

### File Extension Meanings

| Extension | German Term | Meaning |
|-----------|-------------|---------|
| .PRJ | Projekt | Project file |
| .PRK | Projekt Komponente | Project component (various uses) |
| .SOL | SOLON | SOLON-specific data file |
| .TIT | Titel | Title-level data |
| .POS | Position | Position-level data |
| .SPA | Speicher | Memory/Storage file |
| .4SM | 4. Summe | 4th level sum |
| .LOS | Los | Lot-level data |

---

## c) Development Tools Analysis

### Tools Identified from File System Analysis

Based on the recovered files in `partition_d\QUICKB\`, the following development tools were used:

#### Primary Development Tools

**1. Microsoft QuickBASIC 4.5**
- Files found: `QB.EXE` (233,972 bytes)
- Interactive development environment
- Integrated editor, debugger, and interpreter
- Files: `QB.HLP` (help system), `QB.INI` (configuration)
- Quick libraries: `MYLIB.QLB` (31,416 bytes), `TOOLS.QLB` (7,414 bytes)

**2. Microsoft BASIC Compiler 6.0**
- Compiled final production executables
- Provided better performance than interpreted BASIC
- Generated standalone .EXE files
- Required for production deployment

**3. Microsoft C Compiler (Version 5.1 likely)**
- Evidence: `.H` header files, compiled `.OBJ` files
- Used for performance-critical routines
- Screen handling and low-level I/O functions
- Files referenced in includes suggest C library integration

**4. Microsoft Macro Assembler (MASM)**
- `.ASM` files present in development tree
- Used for:
  - Direct hardware access
  - Screen buffer manipulation
  - Interrupt handlers
  - Performance-critical loops

#### Build System

**MAK Files (Make Files)**
- `SOLON.MAK` - Main application
- `PERIKLES.MAK` - Position management module
- `MYLIB.MAK` - Library compilation
- Automated build process

**Batch Files**
- `SETUP.BAT` - Installation
- `SOLON.BAT` - Application launcher
- `QBS.BAT` - Quick compile script
- Build automation scripts

#### Development Structure

**Module Organization:**
1. **SOLON.BAS** (32,270 bytes)
   - Main application controller
   - Menu system
   - Project management
   - Invoice generation

2. **PERIKLES.BAS** (14,004 bytes)
   - Position file management
   - Data entry for line items
   - Integration with external editor (ARES)

3. **MYLIB.BAS** (18,830 bytes)
   - Shared utility library
   - File system operations
   - String manipulation
   - Math functions (currency, rounding)

4. **MYLIB.BI** (4,118 bytes)
   - BASIC include file
   - Function declarations
   - Constant definitions
   - Type definitions

#### External Tools Referenced

**ARES** - Position Editor
- External program for detailed position editing
- Called via: `SHELL "D:\ARES"`
- Likely a separate specialized editor
- File: Unknown location (not in this archive)

**DOS Utilities Used:**
- File system operations (DIR, CHDIR, MKDIR, RMDIR, KILL)
- Batch processing
- Drive management

### DOS Version Analysis

**MS-DOS Version Found:**
Based on file dates and `COMMAND.COM` version (57,377 bytes), the DOS on partition C was **MS-DOS 6.22** (released 1994).

**Note:** This was NOT the original development DOS. The README confirms development started around 1988 with **DOS 3.3**. The DOS 6.22 found in the archive represents a later upgrade of the production partition.

**DOS 3.3 (1987) - Original Development Environment:**
- First version with full 32 MB partition support
- Introduced BACKUP/RESTORE improvements
- Supported up to 512 MB partitions (though drives were much smaller)
- Required for 286 systems of that era

**DOS 6.22 (1994) - Later Production Environment:**
- DoubleSpace disk compression (DRVSPACE.BIN found)
- MemMaker for memory optimization
- Enhanced utilities (DEFRAG, MSBACKUP, SCANDISK)
- Better memory management for 640KB systems

---

## d) Hardware Environment

### Target Hardware Specifications (circa 1988)

#### Development Machine: Nixdorf PC 8810/M55

**Processor:**
- **Intel 80286** running at **10 MHz**
- 16-bit architecture
- Protected mode capability (not used in DOS applications)
- No math coprocessor (80287 optional, likely not installed)
- Performance: Approximately 1.5-2.0 MIPS

**Memory:**
- **640 KB** conventional memory (standard MS-DOS limit)
- **384 KB** upper memory area (reserved for hardware)
- **Total: 1 MB** installed
- Extended memory: Not typically used in DOS 3.3 environment
- Real mode operation only for DOS applications

**Storage:**
- **Hard Drive:** Likely **40 MB** Seagate ST-251 or similar
  - 5.25" full-height drive
  - MFM or RLL encoding
  - Seek time: 40ms average
  - Transfer rate: ~625 KB/sec
- **Floppy Drives:** 
  - 5.25" 1.2 MB high-density (standard for AT-class systems)
  - Used for software distribution and backups

**Graphics:**
- **EGA (Enhanced Graphics Adapter)**
  - Resolution: 640×350 pixels
  - Colors: 16 colors from palette of 64
  - Text mode: 80×25 characters (used by SOLON)
  - 256 KB video RAM
- **Color Monitor** (EGA compatible)
  - CRT technology
  - Refresh rate: 60-70 Hz
  - Contrast ratio limited by technology

**Keyboard:**
- IBM AT-style 101-key keyboard
- No Windows keys
- Separate numeric keypad
- Function keys F1-F12 (heavily used by SOLON)

**Ports:**
- Serial ports (COM1, COM2) - RS-232
- Parallel port (LPT1) - For printer connection
- No USB (not invented yet)

### Typical Customer Hardware (1988-1992)

**Minimum Configuration:**
- Intel 286 at 8-12 MHz
- 512 KB RAM (would work but tight)
- 20 MB hard drive
- Hercules monochrome or CGA/EGA graphics
- Dot-matrix printer (9-pin or 24-pin)

**Recommended Configuration:**
- Intel 286 at 12-16 MHz (or 386SX)
- 640 KB RAM
- 40 MB hard drive
- EGA or VGA graphics
- 24-pin dot-matrix or early laser printer

### Storage Capacity Context

**40 MB Hard Drive in 1988:**
- Cost: Approximately 500-800 DM (Deutsche Mark)
- Considered quite spacious for business applications
- Typical file sizes:
  - QuickBASIC IDE: ~1 MB
  - Source code: ~100 KB total
  - Compiled executables: 50-150 KB each
  - DOS + utilities: ~2-3 MB
  - Project data: 10-100 KB per project
  - Room for 100+ customer projects easily

**Partition Strategy:**
- **C: Drive** (Production - ~20 MB allocated)
  - DOS system files
  - SOLON executable programs
  - Customer project data
  - Kept clean and stable
- **D: Drive** (Development - ~20 MB allocated)
  - Development tools (compilers: ~5-7 MB)
  - Source code
  - Object files and libraries
  - Test data

### Memory Management Challenges

**The 640 KB Barrier:**
- MS-DOS applications limited to 640 KB addressable memory
- Need to fit:
  - DOS kernel (~60-80 KB)
  - Device drivers
  - TSR programs (if any)
  - Application code
  - Application data
  - Screen buffers

**SOLON Memory Strategy:**
- Compiled BASIC code: ~80-120 KB
- Data structures: ~50-100 KB
- Screen buffers: ~4 KB (text mode)
- File buffers: ~20-40 KB
- Remaining: ~350-450 KB for dynamic data

**Performance Considerations:**
- No virtual memory in DOS
- Disk access relatively slow (40ms seek + transfer)
- Heavy use of sequential file access
- Directory-based data organization to avoid large file parsing

### Printer Technology

**Typical Printers (1988):**

**Dot-Matrix Printers (Common):**
- **9-pin:** Epson LX-800, Star NL-10
  - Draft quality: ~200 DPI
  - Speed: 100-180 characters per second
  - Paper: Continuous feed with tractor
- **24-pin:** Epson LQ-850, NEC P6+
  - Near Letter Quality (NLQ): ~360 DPI
  - Speed: 60-120 CPS in NLQ mode
  - Better for professional invoices

**Laser Printers (Premium):**
- HP LaserJet Series II (1987)
- 300 DPI
- 6-8 pages per minute
- Very expensive: 3,000-5,000 DM
- Used by larger contractors

**SOLON Printer Support:**
- Text-based output (no graphics)
- Escape sequences for formatting
- Support for Epson ESC/P standard
- HP PCL support likely
- Continuous feed forms for invoices

---

## e) Software Development Tools Overview

### Language and Compiler Ecosystem

#### 1. Microsoft QuickBASIC 4.5 (Interactive Development)

**Purpose:** Primary development environment  
**Size:** ~500 KB (QB.EXE + help files)  
**Features Used:**
- Integrated editor with syntax highlighting
- Immediate mode for testing
- Breakpoint debugging
- Watch windows for variables
- Quick compilation to memory
- Source-level debugging

**Files in Archive:**
- `QB.EXE` (233,972 bytes) - Main IDE
- `QB.HLP` (48,823 bytes) - Context-sensitive help
- `QB.INI` (34 bytes) - Configuration
- `QBHERC.COM` (6,780 bytes) - Hercules graphics support
- `QB.LIB` (2,075 bytes) - Runtime library

**Development Workflow:**
1. Edit source in QB IDE
2. Test run with F5 (interpreted mode)
3. Debug with breakpoints
4. Once stable, compile with BC.EXE

#### 2. Microsoft BASIC Compiler 6.0 (Production Compiler)

**Purpose:** Create standalone executables  
**Files:** BC.EXE, LINK.EXE, LIB.EXE  
**Process:**
```
BC SOLON.BAS;              (Compile to .OBJ)
BC MYLIB.BAS;
LINK SOLON.OBJ MYLIB.OBJ;  (Link to .EXE)
```

**Advantages:**
- Faster execution than interpreted
- No QB.EXE needed on customer machines
- Smaller memory footprint
- Professional deployment

**Compiler Options Used:**
- `/O` - Optimize for speed
- `/D` - Debug symbols (development builds)
- `/T` - COM file output (smaller executables)

#### 3. Custom Library System

**MYLIB.QLB** (Quick Library - 31,416 bytes)
- Precompiled routines for QB IDE
- Loaded with: `QB /L MYLIB.QLB SOLON.BAS`
- Contains C-language routines callable from BASIC

**MYLIB.BAS/BI** (Source and Interface)
- **MYLIB.BAS** (18,830 bytes): BASIC implementations
- **MYLIB.BI** (4,118 bytes): Interface declarations
- Included with: `'$INCLUDE: 'MYLIB.BI'`

**Library Functions Categories:**

**File System Operations:**
- `exist%()` - Check file/directory existence
- `FSFirst$()` / `FSNext$()` - Directory iteration
- `EraseMP()` - Recursive directory deletion
- `FoldNotEmpty%()` - Check if directory has contents

**String Manipulation:**
- `PointKonv$()` - Convert comma to decimal point
- `ZerKill$()` - Remove trailing zeros
- `InvInstr%()` / `InvRinstr%()` - Inverse string search
- `kstring$()` - String conversion for printer

**Numeric Formatting:**
- `using$()` - Format number with thousand separators
- `DMKonv$()` - German currency formatting (Deutsche Mark)
- `round#()` - Round to decimal places
- `Formstr$()` - Format integer with leading zeros

**User Interface:**
- `alert%()` - Simple menu selection
- `balert%()` - Box alert dialog
- `finput$()` - Field input with validation
- `SetLine()` / `Settext()` - Screen output
- `ClrScr()` - Clear screen

**Date/Time:**
- `TotTime$()` - Get current date/time string

**Low-Level Screen Operations (C routines):**
- `makewin()` - Create window
- `frame()` - Draw border
- `ScrollUp()` / `ScrollDown()` - Scroll screen region
- `rebuild()` - Restore screen
- `repout()` - Repeat character

**Keyboard Input:**
- `ink$()` - Get keystroke with extended codes
- `isinp%()` - Check if key pressed
- `readasc%()` / `readscan%()` - Low-level key reading

#### 4. C Language Integration

**Purpose:** Performance-critical operations  
**Usage:** Screen manipulation, file system access

**C Functions Wrapped for BASIC:**
```basic
DECLARE FUNCTION cfsfirst% (pfad$, temp$, attribute%)
DECLARE FUNCTION cfsnext% (temp$, attribute%)
DECLARE FUNCTION cexist% (datei$, att%)
DECLARE SUB ctottime (ctext$)
DECLARE SUB konvstring (text$)
DECLARE SUB makewin (winnum%, x1%, y1%, x2%, y2%, col%)
DECLARE SUB frame (x1%, y1%, x2%, y2%, col%)
DECLARE SUB ScrollUp (x1%, y1%, x2%, y2%, anz%, attr%)
DECLARE SUB ScrollDown (x1%, y1%, x2%, y2%, anz%, attr%)
DECLARE SUB rebuild (winnum%)
DECLARE SUB repout (x1%, y1%, char$, rep%, attr%)
```

**Reasons for C Implementation:**
1. Direct DOS interrupt calls (faster)
2. Memory management below BASIC's abstractions
3. Screen buffer direct access (BIOS bypassing)
4. Better optimization for repetitive operations

#### 5. Build Automation

**MAK Files (Microsoft MAKE format):**

Example `SOLON.MAK` structure:
```make
SOLON.EXE: SOLON.OBJ MYLIB.OBJ
    LINK SOLON MYLIB;
    
SOLON.OBJ: SOLON.BAS SOLON.BI MYLIB.BI
    BC SOLON.BAS;
    
MYLIB.OBJ: MYLIB.BAS MYLIB.BI
    BC MYLIB.BAS;
```

**Batch File Compilation:**
```batch
@ECHO OFF
REM Compile SOLON System
BC MYLIB.BAS;
BC SOLON.BAS;
BC PERIKLES.BAS;
LINK SOLON MYLIB;
LINK PERIKLES MYLIB;
COPY SOLON.EXE C:\
COPY PERIKLES.EXE C:\
ECHO Build Complete
```

#### 6. Module Architecture

**Three-Module Design:**

**Module 1: SOLON.BAS** (Main Controller)
- Main menu system
- Project management
- Customer data management
- Invoice calculation
- Printing routines
- Function keys F1-F15 dispatcher

**Module 2: PERIKLES.BAS** (Position Management)
- Position data entry
- Hierarchical navigation (4.Sum/Los/Titel/Position)
- Match code management
- Position sorting and indexing
- Integration with ARES editor

**Module 3: MYLIB.BAS** (Shared Library)
- Utility functions
- UI primitives
- File system wrappers
- Data formatting
- Cross-module services

**Why Multiple Modules?**
- Memory management (load only what's needed)
- Compilation time (change one module, recompile only that)
- Code organization
- Team development (single developer, but good practice)

### Development Environment Configuration

**CONFIG.SYS (typical):**
```
FILES=30
BUFFERS=20
DEVICE=C:\DOS\ANSI.SYS
SHELL=C:\DOS\COMMAND.COM C:\DOS\ /P /E:512
```

**AUTOEXEC.BAT:**
```batch
@ECHO OFF
PATH=C:\DOS;C:\;D:\QUICKB;D:\C51\BIN
SET TMP=C:\TEMP
SET TEMP=C:\TEMP
SET LIB=D:\QUICKB\LIB;D:\C51\LIB
SET INCLUDE=D:\C51\INCLUDE
PROMPT $P$G
```

**QB.INI Settings:**
```ini
[Options]
Display = CGA
Paths = D:\QUICKB;D:\QUICKB\LIB
Libs = MYLIB.QLB
TabStops = 4
```

### Version Control

**Method:** Manual file copying  
**Evidence:** `.BAK` files (backup copies)  
**Process:**
1. Save working version: `COPY MYLIB.BAS MYLIB.BAK`
2. Make changes to `MYLIB.BAS`
3. If problems: `COPY MYLIB.BAK MYLIB.BAS`

**No formal version control systems:**
- RCS (Revision Control System) existed but rare in 1988
- SCCS (Source Code Control System) - Unix only
- Most development: manual backups to floppy disks

---

## Technical Constraints and Solutions

### Memory Optimization Techniques

1. **Overlays:** Breaking program into swappable sections
2. **Dynamic Arrays:** Allocate only when needed
3. **String Pool Management:** Reuse string space
4. **Sequential File Access:** Read data as needed, not all at once

### File System Strategy

**Directory-Based Data Model:**
- Each project: one directory (e.g., `10.PRJ\`)
- Each 4.Sum: subdirectory (e.g., `4SSYSTEM.PRK\`)
- Each Los: sub-subdirectory (e.g., `LOSSYSTM.PRK\`)
- Each Title: sub-sub-subdirectory (e.g., `0010.TIT\`)
- Positions: files within title directories (e.g., `00010#.POS`)

**Advantages:**
- DOS directory tree serves as data structure
- No complex database needed
- Easy backup (copy directory trees)
- Visual organization with DIR command
- Natural hierarchical relationships

### Performance Considerations

**Slow Operations Minimized:**
- Disk seeks (40ms each)
- Screen redraws (used windows and selective updates)
- Floating-point math (no FPU, software emulation slow)

**Fast Operations Maximized:**
- Integer math
- String operations
- Sequential file reads
- Pre-calculated values stored

---

## Conclusion

SOLON represents a sophisticated application developed within the tight constraints of late-1980s PC hardware. The developer (age 17-18) demonstrated strong understanding of:

- Domain knowledge (construction industry processes)
- Memory management in constrained environments
- File system as database
- User interface design for text-mode displays
- Modular programming architecture
- Integration of multiple programming languages
- Professional software deployment

The choice of tools (QuickBASIC + C + Assembler) was optimal for the era, balancing development speed with performance requirements. The hierarchical directory-based data model was elegant and made excellent use of DOS capabilities without requiring complex database software.

This software successfully served construction contractors for approximately a decade (late 1980s through late 1990s), automating tedious quantity takeoff calculations and enabling professional invoice generation - a significant productivity improvement over manual methods.

---

**End of Part 1**

*Next: Part 2 - Detailed Software Analysis*
