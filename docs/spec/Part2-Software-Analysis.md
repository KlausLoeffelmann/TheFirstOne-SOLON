# SOLON - Massenermittlung für Bauunternehmer
## Part 2: Detailed Software Analysis

**Document Version:** 1.0  
**Date:** November 2025  
**Original Development Period:** circa 1988  

---

## Table of Contents

1. [Software Architecture Overview](#software-architecture-overview)
2. [Module Descriptions](#module-descriptions)
3. [Data Model and File Structures](#data-model-and-file-structures)
4. [User Interface Analysis](#user-interface-analysis)
5. [Functional Specifications](#functional-specifications)
6. [Integration Points](#integration-points)

---

## Software Architecture Overview

### Three-Tier Architecture

SOLON follows a modular architecture split into three main components:

```
┌─────────────────────────────────────────┐
│         SOLON.EXE (Main Module)         │
│  - Application Controller               │
│  - Menu System (F1-F15)                 │
│  - Project Management                   │
│  - Customer Data                        │
│  - Invoice Generation                   │
│  - Printing System                      │
└──────────────────┬──────────────────────┘
                   │
                   │ Calls via SHELL
                   ▼
┌─────────────────────────────────────────┐
│      PERIKLES.EXE (Position Module)     │
│  - Position Data Entry                  │
│  - Hierarchical Navigation              │
│  - Match Code Management                │
│  - Position Indexing                    │
└──────────────────┬──────────────────────┘
                   │
                   │ Shared Library
                   ▼
┌─────────────────────────────────────────┐
│         MYLIB (Utility Library)         │
│  - File System Operations               │
│  - UI Primitives                        │
│  - String/Number Formatting             │
│  - Screen Management (C routines)       │
└─────────────────────────────────────────┘
```

### Data Flow Architecture

```
User Input (Keyboard)
      ↓
Function Key Dispatcher
      ↓
┌─────────────┬──────────────┬────────────────┐
│  Project    │  Position    │   Invoice      │
│  Mgmt       │  Entry       │   Generation   │
└─────┬───────┴──────┬───────┴────────┬───────┘
      │              │                 │
      ▼              ▼                 ▼
┌──────────────────────────────────────────────┐
│         File System (Directory Tree)         │
│  C:\SOLON\                                   │
│    ├── {PROJECT}.PRJ\                        │
│    │   ├── PRJKTDEF.SOL (Project data)       │
│    │   ├── RECHDEF.SOL (Invoice data)        │
│    │   ├── POSITION.PRK (Position index)     │
│    │   └── 4SSYSTEM.PRK\                     │
│    │       └── LOSSYSTM.PRK\                 │
│    │           └── {TITLE}.TIT\              │
│    │               └── {POS}.POS (Position)  │
│    ├── HANDLE.S_P (Session handle)           │
│    ├── HANDLE.P_A (Position handle)          │
│    ├── LASTVALU.PRK (Last values)            │
│    ├── MEHRWERT.SOL (VAT rate)               │
│    └── KUNDKART.SOL\ (Customer database)     │
│        └── {CUSTNO}.KUN                      │
└──────────────────────────────────────────────┘
      │
      ▼
Printer Output (LPT1)
```

---

## Module Descriptions

### Module 1: SOLON.BAS (Main Application Controller)

**File:** `SOLON.BAS` (32,270 bytes)  
**Compiled to:** `SOLON.EXE`  
**Purpose:** Main application entry point and orchestrator

#### Key Responsibilities

1. **Application Startup**
   - Initialize screen (80×25 text mode)
   - Set color palette
   - Display splash screen
   - Load system configuration

2. **Main Menu System**
   - Function key dispatcher (F1-F15)
   - Context-sensitive help
   - Menu navigation

3. **Project Management (Auftragsverwaltung)**
   - Create new projects
   - Open existing projects
   - Project selection and listing
   - Project deletion

4. **Customer Data Management (Kundenverwaltung)**
   - Customer card file system
   - Customer search by number
   - Customer data entry/editing
   - Customer address management

5. **Invoice Processing (Rechnungswesen)**
   - Invoice parameter definition
   - Progress billing (Abschlagsrechnungen)
   - Final billing (Schlussabrechnung)
   - Discount/surcharge calculations
   - VAT calculation

6. **Print Management**
   - Print program selection
   - Output formatting
   - Printer initialization
   - Report generation

#### Main Menu Structure (F1-F15)

Based on code analysis, the menu structure is:

```
┌─────────────────────────────────────────────────┐
│  SOLON - Auftragsverwaltung (Order Management)  │
├─────────────────────────────────────────────────┤
│ F1  ... Auftrag anlegen/bearbeiten             │
│         (Create/Edit Order)                     │
│ F2  ... (Reserved/Not implemented)              │
│ F3  ... Druckprogramme (Print Programs)         │
│ F4  ... (Reserved)                              │
│ F5  ... (Reserved)                              │
│ F6  ... (Reserved)                              │
│ F7  ... (Reserved)                              │
│ F8  ... Löschprogramme (Delete Programs)        │
│ F9  ... Änderungsprogramme (Change Programs)    │
│ F10 ... Projekt-Verzeichnis Anzeigen            │
│         (Display Project Directory)             │
│ F11 ... Projekt-Verzeichnis drucken             │
│         (Print Project Directory)               │
│ F12 ... (Reserved)                              │
│ F13 ... Rechnungsbearbeitung (Invoice Proc.)    │
│ F14 ... Abschlagszahlungen definieren           │
│         (Define Progress Payments)              │
│ F15 ... Hauptselektor (Main Selector)           │
└─────────────────────────────────────────────────┘
```

#### Key Functions in SOLON.BAS

**AVMaske** (Order Master Mask)
- Purpose: Display/edit order master data
- Fields:
  - Match Code (quick search identifier)
  - Customer Number (Kundennummer)
  - Order Number (Auftragsnummer)
  - Sum Formation (4th Sum/Los/Title)
  - Wage Escalation Clause (Yes/No + percentage)
  - Material Price Clause (Yes/No + percentage)
  - Construction Measure Description (Baumaßnahme)
  - Progress Payment Number
  - Invoice Number
  - Final Settlement (Yes/No)

**AVMaskeAnlegen** (Create New Order)
- Validates customer exists
- Assigns order number
- Collects all order parameters
- Creates project directory structure
- Initializes project files
- Updates last value tracking

**AVMaskeAendern** (Modify Existing Order)
- Loads existing order data
- Allows field modification
- Validates changes
- Updates project files
- Maintains data integrity

**KMaskeBearbeiten** (Edit Customer Mask)
- Fields:
  - Title (Titel)
  - Name
  - Street (Straße)
  - Attention (z.Hd.)
  - City (Ort)
  - Telephone (Tel.)
- Stores in customer card file
- Search by customer number

**Rechnung** (Invoice Generation)
- Load project data
- Display invoice screen
- Calculate:
  - Security retention (Sicherheitseinbehalt)
  - Agreed discount (vereinbarter Nachlass)
  - Agreed surcharge (vereinbarter Zuschlag)
  - VAT (Mehrwertsteuer)
  - Cash discount (Skonto)
  - Construction insurance (Bauwesenversicherung)
- Generate invoice document
- Save invoice definition

**Abschlag** (Progress Payment Definition)
- Define progress payment schedule
- Enter payment amounts
- Link to document numbers
- Calculate percentages
- Store in ABSCHLG.DEF file

**DruckPrgChoice** (Print Program Selection)
```
┌─────────────────────────────────────────┐
│  Druckprogramme (Print Programs)        │
├─────────────────────────────────────────┤
│ F1  ... Massenermittlung gesamt         │
│ F2  ... Arbeitsausdruck                 │
│ F3  ... Massenermittlung; einzelne S.   │
│ F4  ... Rechnung; einzelne Seiten       │
│ F5  ... Massenermittlung Hochformat     │
│ F6  ... Rechnung Seiten von...bis       │
│ F7  ... Rechnung                        │
│ F8  ... Angebot                         │
│ F9  ... Rechnung auf Bildschirm         │
│ F10 ... Massenermittlung S. von...bis   │
│ F15 ... Auftragsverwaltung (Back)       │
└─────────────────────────────────────────┘
```

**ProjDel** (Project Deletion)
- Verify project exists
- Confirm deletion
- Recursively delete directory tree
- Update project index

**showproj** (Display Project List)
- Search for *.PRJ directories
- Display project names
- Show project dates
- Pagination support
- Interactive selection

**printprj** (Print Project List)
- Generate project overview report
- Format for printer
- Include project metadata
- Date stamp report

---

### Module 2: PERIKLES.BAS (Position Management)

**File:** `PERIKLES.BAS` (14,004 bytes)  
**Compiled to:** `PERIKLES.EXE`  
**Purpose:** Manage construction positions and hierarchical structure

#### Key Responsibilities

1. **Position Entry and Editing**
   - Create new positions
   - Edit existing positions
   - Position text entry
   - Dimension data entry

2. **Hierarchical Navigation**
   - Navigate 4-level hierarchy:
     - 4. Summe (4th Sum)
     - Los (Lot)
     - Titel (Title)
     - Position (Line Item)
   - Create folders as needed
   - Maintain hierarchical integrity

3. **Match Code Management**
   - Assign unique match codes to positions
   - Index positions by match code
   - Fast position lookup
   - Prevent duplicate match codes

4. **Position Indexing**
   - Maintain position number index
   - Sort positions for quick access
   - Update index on changes

5. **Integration with ARES Editor**
   - Launch external position editor
   - Pass position file path
   - Wait for editing completion
   - Reload modified data

#### Hierarchical Data Entry Flow

```
User starts PERIKLES
      ↓
Enter Match Code (for existing) or Skip
      ↓
Enter 4. Summe Number (e.g., "0010")
      ├─ If new: Create 0010.4SM directory
      └─ If exists: Navigate to it
      ↓
Enter 4. Summe Text (if new)
      ↓
Enter Los Number (e.g., "0010")
      ├─ If new: Create 0010.LOS directory
      └─ If exists: Navigate to it
      ↓
Enter Los Text (if new)
      ↓
Enter Titel Number (e.g., "0010")
      ├─ If new: Create 0010.TIT directory
      └─ If exists: Navigate to it
      ↓
Enter Titel Text (if new)
      ↓
Enter Position Number (e.g., "00010")
      ↓
Enter Extended Position Number (e.g., "#")
      ↓
Full Position ID: "0010.0010.0010.00010#"
      ↓
Assign Match Code (if new position)
      ↓
Launch ARES Editor OR Return to SOLON
```

#### Directory Naming Convention

The software uses a consistent naming pattern:

- **4. Summe:** `{NUMBER}.4SM` → Creates directory `4SSYSTEM.PRK\`
- **Los:** `{NUMBER}.LOS` → Creates directory `LOSSYSTM.PRK\`
- **Titel:** `{NUMBER}.TIT` → Creates directory `{NUMBER}.TIT\`
- **Position:** `{NUMBER}{CHAR}.POS` → Creates file `{NUMBER}{CHAR}.POS`

Example path:
```
C:\SOLON\10.PRJ\
  └─ 4SSYSTEM.PRK\
      └─ LOSSYSTM.PRK\
          └─ 0010.TIT\
              ├─ TITTEXT.PRK (Title text)
              └─ 00010#.POS (Position file)
```

#### Key Functions in PERIKLES.BAS

**SaveMatchCode**
- Store match code to position mapping
- Update position index file (POSITION.PRK)
- Maintain sorted order

**SortInsert**
- Insert position into sorted index
- Binary search for insertion point
- Maintain index integrity

**LoadMatchCode**
- Load position index from disk
- Build in-memory match code table
- Enable fast position lookup

**Positionsmaske** (Position Data Mask)
- Display position entry form
- Fields:
  - BV Nr. (Building Site Number)
  - Rg. Nr. (Invoice Number)
  - Position Number
  - Position Text (30 chars)
  - Unit Price (E.P.)
  - Amount/Quantity
  - Unit (EU - Einheit)
  - Labor Value
  - Position Total

**MakeFileHandle**
- Create handle file for external editor
- Write full position path
- Format:
  ```
  C:\SOLON\{PROJECT}.PRJ\4SSYSTEM.PRK\LOSSYSTM.PRK\
  {TITLE}.TIT\{POSITION}.POS
  ```
- Enables ARES to locate the file

#### Position Index Structure

The `POSITION.PRK` file contains:
```
Position Number (8 bytes, e.g., "00000100")
Match Code (variable, null-terminated)
Number of Dimensions (1 byte)
Number of Positions So Far (2 bytes)
[Additional index metadata]
```

This allows:
- Quick position lookup by number
- Match code search
- Position count tracking
- Hierarchical relationship preservation

---

### Module 3: MYLIB.BAS (Utility Library)

**File:** `MYLIB.BAS` (18,830 bytes)  
**Compiled to:** `MYLIB.QLB` (Quick Library) and linked into executables  
**Purpose:** Shared utility functions for both SOLON and PERIKLES

#### Categories of Functions

#### 1. File System Operations

**exist%(datei$, att%)**
- Check if file or directory exists
- Parameters:
  - `datei$`: File/directory path
  - `att%`: Attribute (16 = directory)
- Returns: -1 (true) or 0 (false)
- Implementation: Calls C function `cexist`

**FSFirst$(pfad$, attribute%)**
- Get first file in directory matching pattern
- DOS FindFirst wrapper
- Returns: Filename or empty string
- Updates: `attribute%` with file attributes

**FSNext$(attribute%)**
- Get next file in directory iteration
- DOS FindNext wrapper
- Returns: Filename or empty string
- Continues from last FSFirst

**FoldNotEmpty%(pfad$)**
- Check if directory contains files
- Excludes "." and ".." entries
- Returns: -1 if has contents, 0 if empty

**EraseMP(ordner$, joker$)**
- Recursively delete directory tree
- Parameters:
  - `ordner$`: Root directory
  - `joker$`: File wildcard pattern
- Handles nested directories
- Removes empty directories after file deletion

#### 2. String Manipulation

**PointKonv$(test$)**
- Convert German decimal comma to point
- Example: "123,45" → "123.45"
- Essential for numeric calculations

**ZerKill$(text$)**
- Remove trailing zero placeholders (█ characters)
- Used after input field editing
- Returns trimmed string

**InvInstr%(text$, char$)**
- Find first character NOT matching char$
- Inverse of INSTR function
- Returns position or 0

**InvRinstr%(text$, char$)**
- Find last character NOT matching char$ (from right)
- Inverse of RINSTR
- Used for trimming

**oz$(text$)** (ohne Zero - without zero)
- Replace leading zeros with spaces
- Format for display
- Preserves number alignment

**kstring$(text$)**
- Convert string for printer output
- Calls C function `konvstring`
- Handles special characters
- Escape sequence processing

#### 3. Numeric Formatting

**using$(value#, vorstell%, nachstell%)**
- Format number with German thousand separators
- Parameters:
  - `value#`: Number to format
  - `vorstell%`: Digits before decimal (1-11)
  - `nachstell%`: Digits after decimal (0-5)
- Features:
  - Thousand separators (periods)
  - Decimal comma
  - Leading spaces for alignment
  - Overflow protection (shows asterisks)
- Example: `using$(1234567.89, 10, 2)` → " 1.234.567,89"

**DMKonv$(text$, laenge%)**
- Convert string to Deutsche Mark format
- Parameters:
  - `text$`: Input number string
  - `laenge%`: Format specification
    - High byte: digits before comma
    - Low byte: digits after comma
- Handles:
  - Currency alignment
  - Negative values
  - Rounding to currency precision
- Example: `DMKonv$("1234.567", &H0B02)` → "    1234,57"

**round#(value#, nachstell%)**
- Round to specified decimal places
- Returns rounded double
- Uses banker's rounding (0.5 rounds to even)

**Formstr$(anz%, Wert&)**
- Format integer with leading zeros
- Parameters:
  - `anz%`: Total width
  - `Wert&`: Integer value
- Example: `Formstr$(8, 42)` → "00000042"

#### 4. User Interface Functions

**alert%(text$, default%, lin%, menue$, col%, revcol%)**
- Display inline menu with selection
- Parameters:
  - `text$`: Prompt text (max 40 chars)
  - `default%`: Default selection (0-based)
  - `lin%`: Line number (1-25)
  - `menue$`: Menu items separated by "|"
  - `col%`: Normal color attribute
  - `revcol%`: Reverse color (selection)
- Features:
  - Cursor key navigation
  - First letter selection
  - Return confirms
  - Returns: Selected item index
- Example: `alert%("Fortfahren?", 0, 12, "Ja|Nein", 7, 112)`

**balert%(Ausr%, text$, default%, menue$, col%, revcol%)**
- Display box alert dialog
- Parameters:
  - `Ausr%`: Vertical position (0=top, 1=center, 2=bottom)
  - `text$`: Multi-line text ("|" separates lines)
  - Other parameters same as alert%
- Features:
  - Draws border box
  - Centers text
  - Auto-sizes to content
  - Window save/restore
- Example: 
  ```basic
  result% = balert%(1, "Daten löschen?|Sind Sie sicher?", _
                    0, "Ja|Nein", 7, 112)
  ```

**finput$(xpos%, ypos%, laenge%, text$, tpe%, back%, col%)**
- Full-featured field input function
- Parameters:
  - `xpos%`, `ypos%`: Screen position (1-based)
  - `laenge%`: Field length
  - `text$`: Initial/result value
  - `tpe%`: Input type (see below)
  - `back%`: Returns exit key code
  - `col%`: Color attribute
- Input Types:
  - 0 = Text (TextType)
  - 1 = Numeric with formatting (NumType)
  - 2 = Deutsche Mark currency (DMType)
  - 3 = Date (DateType)
  - 4 = Float (FloatType)
  - 5 = Filename (FileType)
  - 6 = Filename without wildcards
- Features:
  - Full edit capabilities (Insert, Delete, Arrow keys)
  - Character validation by type
  - Automatic formatting on exit
  - Placeholder character (█) for empty positions
  - Returns exit key in `back%` parameter
  - Escape clears field

**SetLine(x%, y%, col%, text$)**
- Display text line at position
- Pads with spaces to right edge of screen
- Sets color attribute

**Settext(x%, y%, col%, text$)**
- Low-level text output (C routine)
- Direct screen buffer write
- Fast display update
- Bypasses BIOS for speed

**ClrScr**
- Clear screen
- Set to default colors (white on black)
- Reset cursor position

**SetPal**
- Initialize EGA/VGA color palette
- Set default 16-color palette
- Called at program start

#### 5. Date/Time Functions

**TotTime$**
- Get current date and time
- Calls C function `ctottime`
- Returns formatted string
- Format: "DD.MM.YYYY HH:MM:SS"
- Used for timestamps on reports

#### 6. Low-Level Screen Operations (C Functions)

These are implemented in C for performance:

**makewin(winnum%, x1%, y1%, x2%, y2%, col%)**
- Create window (save screen region)
- Parameters:
  - `winnum%`: Window number (0-9)
  - `x1%`, `y1%`: Top-left corner
  - `x2%`, `y2%`: Bottom-right corner
  - `col%`: Color attribute
- Saves screen contents for later restore

**rebuild(winnum%)**
- Restore saved window
- Redraws previous screen contents
- Enables popup dialogs

**frame(x1%, y1%, x2%, y2%, col%)**
- Draw box border
- Uses box-drawing characters:
  ```
  ╔═══╗
  ║   ║
  ╚═══╝
  ```
- Single or double line options

**ScrollUp(x1%, y1%, x2%, y2%, anz%, attr%)**
- Scroll screen region up
- Parameters:
  - Region coordinates
  - `anz%`: Number of lines to scroll
  - `attr%`: Fill attribute
- Direct BIOS interrupt call

**ScrollDown(x1%, y1%, x2%, y2%, anz%, attr%)**
- Scroll screen region down
- Same parameters as ScrollUp
- Used for scrolling lists

**repout(x1%, y1%, char$, rep%, attr%)**
- Repeat character on screen
- Fast fill operation
- Direct screen memory write
- Used for drawing lines, clearing areas

#### 7. Keyboard Input Functions

**ink$**
- Get keyboard input
- Returns:
  - Single character for ASCII keys
  - CHR$(0) + scan code for extended keys (F1-F12, arrows, etc.)
- Non-blocking check via `isinp%`
- Handles:
  - Function keys
  - Arrow keys
  - Insert/Delete
  - Page Up/Down
  - Home/End
  - Escape
- Example:
  ```basic
  k$ = ink$
  IF k$ = CHR$(0) + CHR$(59) THEN ' F1 key
      ' Handle F1
  END IF
  ```

**readasc%** (C function)
- Read ASCII value from keyboard buffer
- Low-level BIOS call

**readscan%** (C function)
- Read scan code from keyboard buffer
- Hardware-level access

**isinp%** (C function)
- Check if key is waiting in buffer
- Non-blocking test
- Returns: -1 if key available, 0 if not

#### 8. Math Helper Functions

**min%(val1%, val2%)**
- Return minimum of two integers
- Simple comparison

**max%(val1%, val2%)**
- Return maximum of two integers
- Simple comparison

---

## Data Model and File Structures

### Overall Data Organization

SOLON uses a **directory-tree-as-database** approach. Each entity in the domain maps to a directory or file:

```
C:\SOLON\
├─ {PROJECT}.PRJ\              ← Project (one directory per project)
│  ├─ PRJKTDEF.SOL             ← Project definition
│  ├─ RECHDEF.SOL              ← Invoice definition
│  ├─ ABSCHLG.DEF              ← Progress payment definition
│  ├─ POSITION.PRK             ← Position index (match codes)
│  ├─ MAINDAT.SPA              ← Main data cache
│  └─ 4SSYSTEM.PRK\            ← 4th Sum level (always named this)
│     └─ LOSSYSTM.PRK\         ← Lot level (always named this)
│        └─ {NNNN}.TIT\        ← Title level (NNNN = title number)
│           ├─ TITTEXT.PRK     ← Title text
│           └─ {NNNNN}{C}.POS  ← Position file
│                              (NNNNN = pos number, C = char)
├─ KUNDKART.SOL\               ← Customer database directory
│  └─ {CUSTNO}.KUN             ← Customer record files
├─ HANDLE.S_P                  ← Session handle (current project)
├─ HANDLE.P_A                  ← Position handle (for ARES)
├─ LASTVALU.PRK                ← Last used values (numbers)
├─ MEHRWERT.SOL                ← VAT rate
└─ FINPUT.TXT                  ← Last file input (for recall)
```

### File Format Specifications

#### PRJKTDEF.SOL (Project Definition)

Sequential text file, one value per line:

```
Line  1: Customer Number (8 digits, e.g., "00000100")
Line  2: Order Number (8 digits)
Line  3: Sum Formation (1 digit: 0=4.Sum, 1=Los, 2=Titel)
Line  4: Wage Escalation Flag (1 digit: 0=No, 1=Yes)
Line  5: Wage Escalation Year (4 digits, e.g., "1999")
Line  6: Material Price Flag (1 digit: 0=No, 1=Yes)
Line  7: Material Price Year (4 digits)
Line  8: Construction Measure Text (variable length)
Line  9: Customer Title (Herr/Frau/Firma, etc.)
Line 10: Customer Name
Line 11: Customer Street
Line 12: Customer Attention (z.Hd.)
Line 13: Customer City
Line 14: Customer Phone
Line 15: Progress Payment Number (8 digits)
Line 16: Invoice Number (8 digits)
Line 17: Final Settlement Flag (1 digit: 0=No, 1=Yes)
```

**Example:**
```
00000100
00000100
 2 
 0 
1999
 0 
1999
Dies ist der Baumaßnahmentext
Dies ist der Titel
Dies ist de Name
Das hier sit die Straße
Dies ist das z.Hd.
Dies ist der Ort
Hier steht die Telefonnr.
00000010
00000100
 1
```

#### RECHDEF.SOL (Invoice Definition)

Sequential text file with financial calculations:

```
Line  1: Invoice Number (8 digits)
Line  2: Progress Payment Number (8 digits)
Line  3: Security Retention Percentage (double)
Line  4: Security Retention Amount DM (double)
Line  5: Agreed Discount Percentage (double)
Line  6: Agreed Discount Amount DM (double)
Line  7: Agreed Surcharge Percentage (double)
Line  8: Agreed Surcharge Amount DM (double)
Line  9: [Reserved] Percentage (double)
Line 10: [Reserved] Amount DM (double)
Line 11: VAT Percentage (double)
Line 12: Cash Discount Percentage (double)
Line 13: Cash Discount Amount DM (double)
Line 14: Construction Insurance Percentage (double)
Line 15: Construction Insurance Amount DM (double)
Line 16: [Reserved] Percentage (double)
Line 17: [Reserved] Amount DM (double)
Line 18: Text field (variable, multi-line)
```

All monetary amounts in Deutsche Mark (DM) with 2 decimal places.

#### POSITION.PRK (Position Index)

Binary file containing sorted position index:

```
Record Structure (variable length):
  - Position Number: 8 bytes ASCII
  - Match Code: Variable length, null-terminated
  - Dimension Count: 1 byte
  - Total Positions: 2 bytes (integer)
```

Used for:
- Fast position lookup by match code
- Position count tracking
- Sorted iteration over positions

#### {POSITION}.POS (Position Data File)

Sequential text file containing position details:

```
Line  1: Position Text (variable, █ for empty chars)
Line  2: Position Number formatted (e.g., "110.10")
Line  3: Position Number internal (e.g., " 110.1 ")
Line  4: [Reserved] (typically " 0 ")
Line  5: Unit Price multiplier (integer, e.g., "100")
Line  6: Unit Price formatted (e.g., " 100 ")
Line  7: [Empty line]
Line  8: Number of Dimensions (integer, e.g., " 3 ")
Line  9: [Reserved] (typically " 1 ")
Line 10: [Reserved] (typically " 0 ")
Line 11: Long Text field (variable, multi-line, █ padding)
Line 12: [Reserved]
Lines 13-19: Dimension entries (each 40 bytes)
  - Dimension text/description
  - Followed by 8 calculation results (each ~15 bytes)
Line 20+: Calculation results summary
```

**Example:**
```
Hier steht der Positionstext█████████
110.10
 110.1 
 0 
100
 100 
 
 3 
 1 
 0 
Hier steht der Text für diesen ██████Text...
 0 
12█████████████████████████████████
 12 

 0 

 0 

 0 

 0 

 0 
      12,000        0,000         0,000    0,000          0,000       0,000
```

#### MAINDAT.SPA (Main Data Cache)

Quick-access cache file containing frequently used project data:

```
Line  1: Match Code (variable)
Line  2: Customer Number (8 digits)
Line  3: Construction Measure Text (variable)
Line  4: [Calculated totals - cached]
Line  5+: Additional cached data
```

Purpose: Avoid re-reading entire project structure for common operations.

#### KUNDKART.SOL\{CUSTNO}.KUN (Customer Record)

Customer data file, one per customer:

```
Line 1: Title (Titel)
Line 2: Name
Line 3: Street (Straße)
Line 4: Attention (z.Hd.)
Line 5: City (Ort)
Line 6: Telephone (Tel.)
```

Filename is customer number (e.g., `00000100.KUN`).

#### LASTVALU.PRK (Last Values)

Tracks last used numbers for auto-increment:

```
Line 1: Last 4. Summe number (8 digits)
Line 2: Last Los number (8 digits)
Line 3: Last Titel number (8 digits)
Line 4: Last Position number (8 digits)
```

Enables suggesting next available number to user.

#### MEHRWERT.SOL (VAT Rate)

Single-line file containing current VAT percentage:

```
 14
```

Typical values: 14%, 15%, 16%, 19% (depending on era).

#### HANDLE Files (Communication Files)

**HANDLE.S_P** (Session Project Handle)
```
Line 1: Current project name (without .PRJ extension)
```

**HANDLE.P_A** (Position Handle for ARES)
```
Full path to current position file, formatted as:
C:\SOLON\{PROJECT}.PRJ\4SSYSTEM.PRK\LOSSYSTM.PRK\
{TITLE}.TIT\{POSITION}.POS
```

These files enable inter-process communication between SOLON and PERIKLES/ARES.

---

## User Interface Analysis

### Screen Layout Philosophy

SOLON uses a consistent full-screen text-mode interface:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Line 1: Title Bar / Status                                    [Date] [Time] │
├─────────────────────────────────────────────────────────────────────────────┤
│ Lines 2-3: Instructions / Current Context                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│ Lines 4-23: Main Content Area                                               │
│             - Menus                                                          │
│             - Data Entry Forms                                               │
│             - Lists and Reports                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│ Line 24: Status Messages / Nachr.: [Message]                                │
│ Line 25: Function Key Hints (when applicable)                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Color Scheme

Based on EGA capabilities (16 colors):

- **Normal Text:** White on Black (attribute 7 = 0x07)
- **Headers:** White on Blue (attribute 31 = 0x1F)
- **Selected Item:** Black on White (attribute 112 = 0x70)
- **Input Fields:** Yellow on Black (attribute 14 = 0x0E) with █ placeholders
- **Borders:** Light Gray on Black (attribute 7)
- **Status Messages:** Cyan on Black (attribute 11 = 0x0B)
- **Errors:** Red on Black (attribute 12 = 0x0C)

### Input Field Conventions

All input fields use consistent behavior:

1. **Field Placeholder:** Empty positions show █ character
2. **Cursor:** Block cursor at current position
3. **Navigation:**
   - Arrow Left/Right: Move within field
   - Arrow Up/Down: Move to previous/next field
   - Home: Jump to field start
   - End: Jump to field end
4. **Editing:**
   - Character keys: Insert at cursor
   - Backspace: Delete previous character
   - Delete: Delete at cursor
   - Insert: Toggle insert/overwrite mode
   - Escape: Clear entire field
5. **Completion:**
   - Enter: Accept and move to next field
   - Tab: Skip to next field (if implemented)

### Message System

**Nachr.:** (Nachricht = Message) appears on line 24:

```
Nachr.: Eingabe der Kundennummer
        (Input customer number)

Nachr.: Projekt wird angelegt. Bitte warten...
        (Project is being created. Please wait...)

Nachr.: Fehler beim Öffnen der Datei!
        (Error opening file!)
```

Types of messages:
- **Prompts:** Guide user input
- **Progress:** Inform during long operations
- **Confirmations:** Confirm actions
- **Errors:** Report problems

### Dialog Boxes

SOLON uses `balert%` for confirmations:

```
╔═══════════════════════════════════════╗
║  Daten löschen?                       ║
║  Sind Sie sicher?                     ║
║                                       ║
║       [ Ja ]    [ Nein ]              ║
╚═══════════════════════════════════════╝
```

Features:
- Center on screen or at specific position
- Auto-size to content
- Keyboard navigation (cursor keys, first letter)
- Return confirms selection
- Escape cancels (selects last option typically)

### Form Layout Patterns

**Master Data Forms:**
```
╔══════════════════════════════════════════════════════════╗
║ Match-Code:  ██████████     Kundennummer: ████████      ║
║ Auftragsnummer: ████████                                 ║
║                                                          ║
║ Summenbildung: 4.Summe/Los/Titel                        ║
║ Lohngleitklausel:       JA/NEIN                          ║
║ Stoffpreisklausel:      JA/NEIN                          ║
║                                                          ║
║ ┌────────────────────────────────────────────────────┐  ║
║ │ Kundenanschrift                                    │  ║
║ ├────────────────────────────────────────────────────┤  ║
║ │ Titel:  ██████████████████████████████████        │  ║
║ │ Name:   ██████████████████████████████████        │  ║
║ │ Str.:   ██████████████████████████████████        │  ║
║ │ z.Hd.:  ██████████████████████████████████        │  ║
║ │ Ort:    ██████████████████████████████████        │  ║
║ │ Tel.:   ██████████████████████████████████        │  ║
║ └────────────────────────────────────────────────────┘  ║
║                                                          ║
║ Baußmaßnahme: ██████████████████████████████████████   ║
╚══════════════════════════════════════════════════════════╝
```

**List Displays:**
```
╔══════════════════════════════════════════════════════════╗
║ Projekt-Verzeichnis                          Stand: ...  ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║ Projekt: 10      Kunde: Mustermann GmbH                 ║
║ Projekt: 20      Kunde: Beispiel AG                     ║
║ Projekt: 30      Kunde: Test Bauunternehmen             ║
║ ...                                                      ║
║                                                          ║
║ [Taste] für weiter...                                   ║
╚══════════════════════════════════════════════════════════╝
```

### Function Key Help

At bottom of screen or in separate help panel:

```
F1=Hilfe  F3=Drucken  F10=Liste  ESC=Zurück
```

---

## Functional Specifications

### Core Business Processes

#### Process 1: Create New Project

**Actor:** User (Construction Office Worker)  
**Goal:** Set up new construction project in system

**Steps:**

1. **Start SOLON** → Main menu appears
2. **Press F1** → "Auftrag anlegen/bearbeiten"
3. **System prompts:** "Nachr.: Eingabe des Match-Codes"
   - User presses Enter (skip) for new project
4. **System prompts:** "Nachr.: Eingabe der Kundennummer"
   - User enters customer number (8 digits)
   - System validates customer exists in KUNDKART.SOL
   - If not found: Option to create customer card
5. **System prompts:** "Nachr.: Eingabe der Auftragsnummer"
   - User enters unique order number (8 digits)
   - System validates no duplicate
6. **System prompts:** "Nachr.: Höchste Summenbildung?"
   - Options: 4. Summe | LOS | Titel
   - Determines hierarchical depth for project
7. **System prompts:** "Nachr.: Lohngleitklausel?"
   - Options: JA | NEIN
   - If JA: Enter reference year
8. **System prompts:** "Nachr.: Stoffpreisklausel?"
   - Options: JA | NEIN
   - If JA: Enter reference year
9. **System prompts:** "Nachr.: Eingabe des Baumaßnahmentextes"
   - User enters project description (variable length)
10. **System asks:** "Kundenmaske bearbeiten?"
    - Options: JA | NEIN
    - If JA: Edit customer address fields
11. **System asks:** "Eingabe der Abschlagsrechnungs-Nummer"
    - User enters progress payment tracking number (optional)
12. **System asks:** "Eingabe der Rechnungsnummer"
    - User enters invoice number for this project
13. **System asks:** "Alle Eingaben korrekt?"
    - Options: JA | NEIN
    - If NEIN: Returns to start of form
    - If JA: Proceeds to create
14. **System:** "Nachr.: Baumaßnahme wird angelegt. Bitte warten..."
    - Creates directory: `C:\SOLON\{ORDERNO}.PRJ\`
    - Writes `PRJKTDEF.SOL` with all data
    - Initializes `POSITION.PRK` (empty index)
    - Creates `MAINDAT.SPA` cache
    - Updates `LASTVALU.PRK`
15. **System returns** to main menu

**Result:** Project directory structure created, ready for position entry.

---

#### Process 2: Enter Position Data

**Actor:** User  
**Goal:** Add construction line item to project

**Steps:**

1. **From SOLON main menu:** System writes current project to `HANDLE.S_P`
2. **System launches:** `PERIKLES.EXE` via SHELL command
3. **PERIKLES starts:** Reads `HANDLE.S_P` to know current project
4. **System prompts:** "Nachr.: MATCH-CODE Eingabe"
   - User can enter existing match code to edit position
   - Or press Enter to create new position
5. **If new position:**
   - **System prompts:** "Nachr.: Eingabe der 4. (übergeordneten) Summennummer"
   - User enters 4-digit number (e.g., "0010")
   - If new: System asks for 4. Summe text
   - System creates: `4SSYSTEM.PRK\` if needed
   
6. **System prompts:** "Nachr.: Eingabe der LOS-Nummer"
   - User enters 4-digit lot number (e.g., "0010")
   - If new: System asks for Los text
   - System creates: `LOSSYSTM.PRK\` if needed

7. **System prompts:** "Nachr.: Eingabe der TITEL-Nummer"
   - User enters 4-digit title number (e.g., "0010")
   - If new: System asks for Titel text
   - System creates: `{NNNN}.TIT\` directory

8. **System prompts:** "Nachr.: Eingabe der POSITIONS-Nummer"
   - User enters position number (e.g., "00010")

9. **System prompts:** "Nachr.: Eingabe der erweiterten POSITIONS-Nummer"
   - User enters character (e.g., "#")
   - Forms complete position ID: "00010#"

10. **System prompts:** "Nachr.: Eingabe des Positions-Matchcodes"
    - User enters short identifier (e.g., "BETON1")
    - System validates uniqueness
    - If duplicate: Error and re-prompt

11. **System:**
    - Creates position file: `{NNNN}.TIT\{NNNNN}{C}.POS`
    - Writes `HANDLE.P_A` with full path
    - Updates `POSITION.PRK` index

12. **System launches:** `D:\ARES` (external editor)
    - ARES reads `HANDLE.P_A` to find position file
    - User enters:
      - Position text
      - Dimensions (length, width, height, quantity)
      - Unit price
      - Unit (m², m³, Stk., etc.)
      - Calculation formulas
    - ARES saves data to position file
    - ARES exits

13. **PERIKLES resumes:** Control returns after ARES exits

14. **System prompts:** "Nachr.: OK"
    - Returns to SOLON main menu

**Result:** Position created in hierarchical structure, ready for invoicing.

---

#### Process 3: Generate Invoice

**Actor:** User  
**Goal:** Create invoice document with all calculations

**Steps:**

1. **From SOLON main menu:** Press **F13** → "Rechnungsbearbeitung"

2. **System displays:** Invoice entry screen with fields

3. **User enters/reviews:**
   - Match-Code (auto-filled from current project)
   - Rechnungsnummer (invoice number)
   - Abschlagsnummer (progress payment number)
   - Baumaßnahme (project description - auto-filled)

4. **User enters financial adjustments:**
   - **Sicherheitseinbehalt** (Security Retention)
     - Percentage (e.g., "5")
     - System calculates DM amount
   
   - **Vereinbarter Nachlass** (Agreed Discount)
     - Percentage (e.g., "2")
     - System calculates DM amount
   
   - **Vereinbarter Zuschlag** (Agreed Surcharge)
     - Percentage (optional)
     - System calculates DM amount
   
   - **Mehrwertsteuer** (VAT)
     - Percentage (loaded from MEHRWERT.SOL, e.g., "14")
     - System calculates DM amount
     - **Required field** - system enforces entry
   
   - **Vereinbarter Skonto** (Cash Discount)
     - Percentage (e.g., "2")
     - System calculates DM amount
   
   - **Bauwesenversicherung** (Construction Insurance)
     - Percentage
     - System calculates DM amount

5. **User enters:** Text field (invoice notes, payment terms)

6. **System calculates:**
   ```
   Subtotal (from all positions)
   - Security Retention
   - Agreed Discount
   + Agreed Surcharge
   = Net Amount
   + VAT
   = Gross Amount
   - Cash Discount
   - Construction Insurance
   = Invoice Total
   ```

7. **System asks:** "Nachr.: Eingabe OK?"
   - Options: Ja | Nein
   - If Nein: Return to editing
   - If Ja: Proceed to save

8. **System:**
   - Saves to `RECHDEF.SOL` in project directory
   - Stores all percentages and amounts
   - Timestamps invoice

9. **System returns** to main menu

10. **User selects:** Press **F3** → "Druckprogramme"

11. **Select:** **F7** → "Rechnung" (Invoice)

12. **System generates:**
    - Formatted invoice document
    - Sends to printer (LPT1)
    - Includes:
      - Customer address
      - Project description
      - Position summary or detail
      - All financial calculations
      - Invoice total
      - Payment terms

**Result:** Printed invoice document ready for mailing.

---

#### Process 4: Progress Payment Schedule

**Actor:** User  
**Goal:** Define progress payment milestones

**Steps:**

1. **From SOLON main menu:** Press **F14** → "Abschlagszahlungen definieren"

2. **System prompts:** "Nachr.: Project Name"
   - User enters project number

3. **System displays:** Progress payment entry screen
   ```
   ╔═══════════════════════════════════════════════════════╗
   ║ Eingabe NETTO-Abschläge                               ║
   ║                                                       ║
   ║ Projekt: {PROJECT}                                    ║
   ║                                                       ║
   ║ [List of progress payments]                           ║
   ║                                                       ║
   ║ AZ: {seq}  Dokum: {docno}  {amount} EU  {percent}%   ║
   ║ ...                                                   ║
   ╚═══════════════════════════════════════════════════════╝
   ```

4. **For each progress payment:**
   - **AZ** (Aktenzeichen): Document reference number
   - **Dokum**: Internal document number
   - **Amount**: Payment amount in EU (currency units)
   - **Percent**: Percentage of total project

5. **User navigates:**
   - Arrow keys: Move between fields
   - Enter: Next payment entry
   - Insert: Add new payment
   - Delete: Remove payment entry

6. **System auto-calculates:**
   - Running total of all payments
   - Remaining balance
   - Percentage complete

7. **System validates:**
   - Total doesn't exceed project value
   - All required fields filled

8. **User confirms:** Completion of entry

9. **System saves:** `ABSCHLG.DEF` in project directory

10. **System returns** to main menu

**Result:** Progress payment schedule defined, ready for billing.

---

### Data Validation Rules

#### Customer Number
- Format: 8 digits
- Range: 00000001 - 99999999
- Must exist in KUNDKART.SOL for existing orders
- Auto-incremented for new customers

#### Order Number
- Format: 8 digits
- Range: 00000001 - 99999999
- Must be unique across all projects
- No duplicates allowed

#### Match Code
- Format: Variable length alphanumeric
- Case-sensitive
- Must be unique within project
- Used for quick position lookup
- No special characters (reserved for internal use)

#### Position Numbers
- Format: 4-5 digits + 1 character
- Examples: "00010#", "01234A"
- Must be unique within title
- Sequential numbering recommended

#### Percentages
- Range: 0.00 - 100.00
- Two decimal places
- Display with comma (German format)
- Stored as double precision

#### Currency (Deutsche Mark)
- Range: -999,999,999.99 to 999,999,999.99
- Two decimal places mandatory
- Display with thousand separators (periods)
- Decimal comma
- Right-aligned for printing

#### Dates
- Format: DD.MM.YYYY
- Validation: Valid calendar date
- Used for wage/material price clause reference years

---

## Integration Points

### SOLON ↔ PERIKLES Communication

**Mechanism:** File-based handoff

1. **SOLON writes:** Current project name to `HANDLE.S_P`
2. **SOLON executes:** `SHELL "D:\PERIKLES"`
3. **PERIKLES reads:** `HANDLE.S_P` on startup
4. **PERIKLES operates:** User enters/edits positions
5. **PERIKLES writes:** Updated position files
6. **PERIKLES exits:** Control returns to SOLON
7. **SOLON refreshes:** Re-reads project data if needed

**Data Shared:**
- Current project context
- Position modifications
- Index updates (POSITION.PRK)

---

### PERIKLES ↔ ARES Communication

**Mechanism:** File-based handoff + path passing

1. **PERIKLES creates:** Position file if new
2. **PERIKLES writes:** Full path to `HANDLE.P_A`
   ```
   C:\SOLON\10.PRJ\4SSYSTEM.PRK\LOSSYSTM.PRK\0010.TIT\00010#.POS
   ```
3. **PERIKLES executes:** `SHELL "D:\ARES"`
4. **ARES reads:** `HANDLE.P_A` to get file path
5. **ARES loads:** Position file for editing
6. **ARES provides:** Enhanced editing capabilities:
   - Multi-line text
   - Dimension calculations
   - Formula evaluation
   - Unit price management
7. **ARES saves:** Updated position file
8. **ARES exits:** Control returns to PERIKLES
9. **PERIKLES:** Ready for next position or return to SOLON

**Why External Editor?**
- Memory constraints (PERIKLES stays small)
- Specialized editing features
- Potentially written in C/Assembler for speed
- Modular architecture

---

### Printer Interface

**Output Device:** LPT1 (Parallel Port)

**Printing Process:**

1. **User selects:** Print program from menu
2. **System checks:** Printer status via `prtstat%` function
3. **System initializes:** Printer via `initprt()` (C function)
4. **System formats:** Report/invoice data
   - Text-based layout
   - Fixed-width fonts
   - Box-drawing characters for borders
   - Escape sequences for formatting
5. **System sends:** Line-by-line to printer
6. **System uses:** `kstring$()` for character conversion
7. **System supports:**
   - Epson ESC/P codes
   - HP PCL codes (basic)
   - Form feed for page breaks
   - Line feed control

**Print Programs Available:**
- Massenermittlung gesamt (Complete quantity takeoff)
- Arbeitsausdruck (Working copy)
- Massenermittlung einzelne Seiten (Selected pages)
- Rechnung einzelne Seiten (Invoice pages)
- Massenermittlung Hochformat (Portrait format)
- Rechnung Seiten von...bis (Invoice page range)
- Rechnung (Complete invoice)
- Angebot (Quote/Offer)
- Rechnung auf Bildschirm (Invoice on screen - preview)

---

### File System Dependencies

**DOS Services Used:**
- INT 21h functions:
  - File open/create/close
  - File read/write
  - Directory create/delete
  - Directory change
  - Find first/next file
  - Get/set file attributes

**Directory Operations:**
- `MKDIR` - Create directory
- `RMDIR` - Remove directory
- `CHDIR` - Change directory
- Recursive tree walking
- Path construction

**File Locking:**
- None (single-user application)
- No concurrent access protection
- Network deployment not supported

---

## Summary

SOLON demonstrates a well-architected DOS application for the German construction industry, circa 1988:

**Strengths:**
- Clear separation of concerns (three-module architecture)
- Elegant directory-as-database approach
- Comprehensive domain knowledge implementation
- User-friendly text-mode interface
- Robust input validation
- Professional invoice generation

**Design Patterns:**
- MVC (Model-View-Controller) approach
- Utility library pattern
- File-based persistence
- External editor integration
- Function key-driven navigation

**Technical Achievements:**
- C/BASIC integration for performance
- Direct screen buffer manipulation
- Memory-efficient design
- Hierarchical data modeling
- Inter-process communication via files

This software served real business needs for approximately a decade, successfully automating the complex task of construction quantity takeoff and billing in the German market.

---

**End of Part 2**

*Next: Part 3 - Modern Migration Specifications*
