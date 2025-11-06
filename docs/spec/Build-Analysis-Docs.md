# Software Analysis and Specification Ask

This is my first commercial software I wrote almost 40 years ago (around 1988 I think). It is a 

"Massenermittlung fuer Bauunternehmer", 

what ever that translates to American English.

I want to create the detailed specs for the app based on the software as it is, so that we can migrate it to .NET 10 and WinForms. I can tell you what I remember so far. 

a) It was developed, I think, 
   - on a 286 compatible PC
   - running MS DOS which might have been common or even new around 1988. Maybe 3.3 or 4.0. 
   - I think I wrote some screen support libraries I needed very performant in C. 
   - I wrote most of the software in Quick Basic, I think, but we used the Basic Compiler - I think it was 6.0, to get it the performance it needed. 
   - The development was done on Partition/Drive D. 
   - Drive C contained the/a respecitve working version. I did everything file- and directory-structure based, meaning, that the level of material organization (Title, Los, Positions, Sub Positions - I honestly do not remember the Level names), where most likely respective folder structures. 
   
I would love you to create 3 spec docs in total:

## Part 1: Development Environment, Tooling, Hardware and Domain Introduction

  - Introduction into the domain with the background of the German craftman ship at the time and the general approach to do things when building houses. 
  - A short glossary, which typical domain terms were/are used and what their equivalent is in english. 
  - An analysis, what tools likely have been used at the time. I know the current DOS of the drive copy was later upgraded. It was not the versions at the time. 
  - A short description over what was possible in terms of hardware, memory, harddisc at the time. The machine had a Intel 80286 in the 10 mhz version? If I remember correctly it had an EGA Adapter, and a 40 MByte Harddisc (likely Seagate ST 251?) - and we had a color monitor. 
  - I think that model PC had 640 KB, likely even 1 MB if that was already common at the time? I forgot. 
  - A short overview over the software development tools I used, best from directory scan / file analysis.

## Part 2: Software description from User Perspectiver

I would like a detail description of the software, what it did, what names were used and what the individual modules were doing. 

## Part 3: Exact Specs for .NET 10 WinForms Migration

And then, in Part 3, we should have the exact specs, with which we would be able to create a WinForms version, which would be able to read the old data but would base the new GUI Software on a SQLite data base. 

For those 3 Parts please create one respective Markdown document and put it in the `docs/specs` folder.
