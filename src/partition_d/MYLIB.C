#include <d:\include\dos.h>
#include <d:\include\string.h>
#include <d:\include\bios.h>
#include <d:\include\stdio.h>
#include <d:\include\io.h>
#include <d:\include\time.h>

typedef unsigned char BYTE;
typedef struct velb far * VP;
typedef BYTE BOOL;
union REGS reg;

struct bas_zk{
			int zb_len;
			char near *zb_addr;
	     };

struct DirStruct {
			BYTE            Reserviert[21];
			BYTE            Attribute;
			unsigned int    Zeit;
			unsigned int    datum;
			unsigned long   DatGr;
			char            DatName[13];
		};

struct velb
	{
		BYTE zeichen,attribut;
	};

#ifndef MK_FP
#define MK_FP(seg,ofs) ((void far *) ((unsigned long) (seg)<<16|(ofs)))
#endif

#define TRUE 1
#define FALSE 0

#define CRT_START ((unsigned far *) MK_FP(0x40,0x4E))
#define ADDR_6845 ((unsigned far *) MK_FP(0x40,0x63))

#define NORMAL          0x07
#define HELL            0x0F
#define INVERS          0x70
#define UNTERSTRICHEN   0x01
#define BLINKEN         0x80

static BYTE scr_buf[4][2081];                            /* 5 Fenster fÅr Bildschirm */
static BYTE col_buf[4][2081];                            /* 5 Fenster fÅr Farbdefinitionen */
static char konchar[255];                                /* Characterkonvertierungstabellen */

static int win_x1[4],win_y1[4],win_x2[4],win_y2[4];
static VP vptr;
static double zehner[12]={1.0,10.0,100.0,1000.0,10000.0,100000.0,1000000.0,10000000.0,100000000.0,1000000000.0,10000000000.0};
struct DirStruct SearchEntry;

/**************************************************************/
/***                                                        ***/
/***        Errechnen des Basisspeichers der aktuellen      ***/
/***                 Bildschirmseite.                       ***/
/***                                                        ***/
/***                                                        ***/
/**************************************************************/

void get_videoram()

{
	vptr=(VP) MK_FP( (*ADDR_6845 == 0x3B4) ? 0xb000 : 0xb800,0);
}

/**************************************************************/
/***                                                        ***/
/***             Gibt ein Zeichen wiederholt auf dem        ***/
/***             Bildschirm aus.                            ***/
/***                                                        ***/
/***                                                        ***/
/**************************************************************/

void fortran repout(int x1,int y1,int character,int wdh,int attribute)

{
	register VP lptr;
	register BYTE i;

	get_videoram();
	lptr=(VP) ((BYTE far *) vptr + *CRT_START)+ (y1-1)*80+ x1-40;
	for (i=0; i<wdh; ++lptr,++i)
		{
			lptr->zeichen=character;
			lptr->attribut=attribute;
		}

}

/**************************************************************/
/***                                                        ***/
/***         Zeichnet einen Rahmen in einer bestimmten      ***/
/***         Farbe bzw. Attribute                           ***/
/***                                                        ***/
/***                                                        ***/
/**************************************************************/

void fortran frame(int x1,int y1,int x2,int y2,int att)

{
	int count;

	repout(x1,y1,218,1,att);
	repout(x1+1,y1,196,x2-x1-1,att);
	repout(x2,y1,191,1,att);
	repout(x1,y2,192,1,att);
	repout(x1+1,y2,196,x2-x1-1,att);
	repout(x2,y2,217,1,att);

	for(count=y1+1;count<y2;count++)

	{
		repout(x1,count,179,1,att);
		repout(x2,count,179,1,att);
	}

}

/**************************************************************/
/***                                                        ***/
/***             Rettet einen Bildschirmbereich             ***/
/***             in einen von fÅnf mîglichen Fenster-       ***/
/***             speichern                                  ***/
/***                                                        ***/
/**************************************************************/

void fortran makewin(int winnum,int x1,int y1,int x2,int y2,int attribute)

{

	register VP lptr;
	register int x_count,y_count;

	get_videoram();

	win_x1[winnum]=x1; win_y1[winnum]=y1; win_x2[winnum]=x2; win_y2[winnum]=y2;

	if (attribute!=0)
		for (y_count=y1; y_count<y2+1; y_count++)
			{
			for(x_count=x1; x_count<x2+1; x_count++)
				{

				lptr = (VP) ((BYTE far *) vptr + *CRT_START)+(y_count-1)*80+(x_count-1)-39;
				scr_buf[winnum][y_count*80+x_count]=lptr->zeichen;
				col_buf[winnum][y_count*80+x_count]=lptr->attribut;
				lptr->zeichen=32;
				lptr->attribut=attribute;

				}

			}

	else

		for (y_count=y1; y_count<y2+1; y_count++)
			{
			for(x_count=x1; x_count<x2+1; x_count++)
				{

				lptr = (VP) ((BYTE far *) vptr + *CRT_START)+(y_count-1)*80+(x_count-1)-39;
				scr_buf[winnum][y_count*80+x_count]=lptr->zeichen;
				col_buf[winnum][y_count*80+x_count]=lptr->attribut;

				}

			}


}

/**************************************************************/
/***                                                        ***/
/***       Stellt einen der fÅnf Bildschirmbereiche         ***/
/***       wieder  her.                                     ***/
/***                                                        ***/
/***                                                        ***/
/**************************************************************/

void fortran rebuild(int winnum)

{
	register VP lptr;
	register int x_count, y_count;

	get_videoram();
	for (y_count=win_y1[winnum]; y_count<win_y2[winnum]+1; y_count++)
		for(x_count=win_x1[winnum]; x_count<win_x2[winnum]+1; x_count++)

		{
			lptr = (VP) ((BYTE far *) vptr + *CRT_START)+(y_count-1)*80+(x_count-1)-39;
			lptr->zeichen=scr_buf[winnum][y_count*80+x_count];
			lptr->attribut=col_buf[winnum][y_count*80+x_count];
		}

}

/**************************************************************/
/***                                                        ***/
/***       Rollt einen Bildschirmausschnitt um eine         ***/
/***       bestimmte Anzahl von Zeilen nach oben            ***/
/***                                                        ***/
/**************************************************************/

void fortran scrollup(int x1,int y1,int x2,int y2,int anzz,int attribut)

{
	reg.h.ah=6;
	reg.h.al=anzz;
	reg.h.ch=y1;
	reg.h.cl=x1;
	reg.h.dh=y2;
	reg.h.dl=x2;
	reg.h.bh=attribut;
	int86(0x10,&reg,&reg);
}

/**************************************************************/
/***                                                        ***/
/***       Rollt einen Bildschirmbereich um eine bestimmte  ***/
/***       Anzahl von Zeichen nach unten.                   ***/
/***                                                        ***/
/**************************************************************/

void fortran scrolldown(int x1,int y1,int x2,int y2,int anzz,int attribut)

{
	reg.h.ah=7;
	reg.h.al=anzz;
	reg.h.ch=y1;
	reg.h.cl=x1;
	reg.h.dh=y2;
	reg.h.dl=x2;
	reg.h.bh=attribut;
	int86(0x10,&reg,&reg);

}

/**************************************************************/
/***                                                        ***/
/***      Gibt einen beliebigen Text in einer               ***/
/***      bestimmten Farbe auf dem Bildschirm aus.          ***/
/***                                                        ***/
/**************************************************************/

void settext(spalte,zeile,farbe, text)

int *spalte, *zeile,*farbe;
struct bas_zk *text;

{

	register VP lptr;
	register BYTE i;
	char *Testtext;
	int laenge;

	Testtext=text->zb_addr;
	laenge=text->zb_len;

	get_videoram();

	lptr=(VP) ((BYTE far *) vptr + *CRT_START)+ (*zeile-1)*80+ *spalte-40;
	for (i=0; i<laenge; ++lptr, ++i)
	{
		lptr->zeichen=*Testtext++;
		lptr->attribut=*farbe;
	}

}

/**************************************************************/
/***                                                        ***/
/***       Setzt die Konvertierungstabellen fÅr Bildschirm  ***/
/***       bzw. Druckerausgabe zurÅck.                      ***/
/***                                                        ***/
/**************************************************************/

void fortran reskonvert()

{
	int count;

	for (count=-128; count<127; count++)
	{
	konchar[count]=count;
	}


}


/**************************************************************/
/***                                                        ***/
/***      Gibt einen beliebigen Text in einer               ***/
/***      bestimmten Farbe auf dem Bildschirm aus.          ***/
/***      Zeichen werden dabei anhand der Konvertierungs-   ***/
/***      tabelle ersetzt.                                  ***/
/***                                                        ***/
/**************************************************************/

void konvtext(spalte,zeile,farbe, text)

int *spalte, *zeile,*farbe;
struct bas_zk *text;

{

	register VP lptr;
	register BYTE i;
	char *Testtext;
	int laenge;

	Testtext=text->zb_addr;
	laenge=text->zb_len;

	get_videoram();

	lptr=(VP) ((BYTE far *) vptr + *CRT_START)+ (*zeile-1)*80+ *spalte-40;
	for (i=0; i<laenge; ++lptr, ++i)
	{
		lptr->zeichen=konchar[*Testtext++];
		lptr->attribut=*farbe;
	}

}

/**************************************************************/
/***                                                        ***/
/***      Gibt einen beliebigen Text auf dem                ***/
/***      Drucker aus.                                      ***/
/***      Zeichen werden dabei anhand der Konvertierungs-   ***/
/***      tabelle ersetzt.                                  ***/
/***                                                        ***/
/**************************************************************/

void konvprinter(text)
struct bas_zk *text;

{
	char *Testtext;
	int laenge, count;

	Testtext=text->zb_addr;
	laenge=text->zb_len;

	for(count=0; count<laenge; _bios_printer(_PRINTER_WRITE,0,konchar[*Testtext++]),count++);

}

/**************************************************************/
/***                                                        ***/
/***      Wandelt einen String anhand der Konvertierungs-   ***/
/***      tabelle um.                                       ***/
/***                                                        ***/
/**************************************************************/

void konvstring(text)
struct bas_zk *text;

{
	char *Temptext;
	char *Temp2text=(char *)malloc(512);

	int laenge, count;

	Temptext=text->zb_addr;
	laenge=text->zb_len;

	for(count=0; count<laenge; Temp2text[count]=konchar[*Temptext++],count++);
	strcpy(text->zb_addr,Temp2text);
	free(Temp2text);
}

/**************************************************************/
/***                                                        ***/
/***      Ermittelt einen absoluten Dateinamen              ***/
/***                                                        ***/
/**************************************************************/

void gettemp(text)
struct bas_zk *text;
{
	char *temp="tmXXXXXX";
	temp=mktemp(temp);
	strcpy(text->zb_addr,temp);
}


/**************************************************************/
/***                                                        ***/
/***        Definiert ein Zeichen in der Konvertierungs-    ***/
/***        tabelle um.                                     ***/
/***                                                        ***/
/**************************************************************/

void fortran setkonvert(int org,int new)

{
	konchar[org]=new;
}

/**************************************************************/
/***                                                        ***/
/***          Set DTA                                       ***/
/***                                                        ***/
/**************************************************************/

void SetDTA(Offset)
unsigned int Offset;

{
	union REGS Register;
	struct SREGS Segmente;

	segread(&Segmente);
	Register.h.ah=0x1A;
	Register.x.dx=Offset;
	intdosx(&Register,&Register,&Segmente);

}

/**************************************************************/
/***                                                        ***/
/***          SFIRST                                        ***/
/***                                                        ***/
/**************************************************************/

BYTE GetFirst(Pfad,Attribute)
char *Pfad;
unsigned int Attribute;

{
	union REGS Register;
	struct SREGS Segmente;
	segread(&Segmente);
	Register.h.ah=0x4E;
	Register.x.cx=Attribute;
	Register.x.dx=(unsigned int) Pfad;
	intdosx(&Register, &Register, &Segmente);
	return(!Register.x.cflag);
}




/**************************************************************/
/***                                                        ***/
/***        PrÅft, ob angegebene Datei vorhanden ist, oder  ***/
/***        nicht. Dabei kînnen auch Verzeichnisse          ***/
/***        ÅberprÅft werden. Datei wird von BASIC aus      ***/
/***        aufgerufen. Text mu· mit CHR$(0) abgesch. sein  ***/
/***                                                        ***/
/**************************************************************/

int cexist(text,attribute)

int *attribute;
struct bas_zk *text;

{
	char *Testtext;
	struct DirStruct Entry;
	int laenge;

	Testtext=text->zb_addr;
	laenge=text->zb_len;

	SetDTA(&Entry);
	return(GetFirst(Testtext,*attribute));

}

/**************************************************************/
/***                                                        ***/
/***        Ermittelt Wochentag, Systemzeit und Datum,      ***/
/***        gibt diese an eine BASIC Zeichenkette wieder.   ***/
/***        Zeichenkette mu· 26 Bytes lang sein.            ***/
/***                                                        ***/
/**************************************************************/

void ctottime(datum)
struct bas_zk *datum;

{
	time_t zeit;
	time(&zeit);
	strcpy (datum->zb_addr, ctime(&zeit));
}

/**************************************************************/
/***                                                        ***/
/***        Ermittelt den ersten vorkommanden Dateinamen,   ***/
/***        setzt gleichzeitig Pfad fÅr die weitere Suche.  ***/
/***        Gibt den BASIC-Namen und eine Fehlernummer      ***/
/***        zurÅck.                                         ***/
/***                                                        ***/
/**************************************************************/

int cfsfirst(basic_dn,basic_back,attribute)
struct bas_zk *basic_dn;
struct bas_zk *basic_back;
int *attribute;

{
	int temp;

	SetDTA(&SearchEntry);
	temp=GetFirst(basic_dn->zb_addr,*attribute);
	*attribute=SearchEntry.Attribute;
	strcpy(basic_back->zb_addr,SearchEntry.DatName);
	return(temp);

}

/**************************************************************/
/***                                                        ***/
/***        Ermittelt den nÑchsten vorkommanden Dateinamen. ***/
/***        Gibt den BASIC-Namen und eine Fehlernummer      ***/
/***        zurÅck.                                         ***/
/***                                                        ***/
/**************************************************************/

int cfsnext(basic_back,Attribute)
struct bas_zk *basic_back;
int *Attribute;

{
	int temp;
	union REGS Register;

	Register.h.ah=0x4f;
	intdos(&Register, &Register);
	*Attribute=SearchEntry.Attribute;
	strcpy(basic_back->zb_addr,SearchEntry.DatName);
	return(!Register.x.cflag);
}

long fortran dfree(int drivenum)
{
	struct diskfree_t Splatz;

	_dos_getdiskfree((unsigned) drivenum,&Splatz);
	return((long) Splatz.avail_clusters * Splatz.sectors_per_cluster * Splatz.bytes_per_sector);
}


int rinstr(text,chr)
struct bas_zk *text;
struct bas_zk *chr;

{
	register int i;
	register char *temp;

	temp=text->zb_addr;
	temp+=(text->zb_len-1);

	for(i=text->zb_len; i>0; i--)
		if (*temp-- == *chr->zb_addr) break;

	return(i);
}

int rinvinstr(text,chr)
struct bas_zk *text;
struct bas_zk *chr;

{
	register int i;
	register char *temp;

	temp=text->zb_addr;
	temp+=(text->zb_len-1);

	for(i=text->zb_len; i>0; i--)
		if (*temp-- != *chr->zb_addr) break;

	return(i);
}

int invinstr(text,chr)
struct bas_zk *text;
struct bas_zk *chr;

{
	register int i;
	register char *temp;

	temp=text->zb_addr;

	for(i=0; i<text->zb_len+1; i++)
		if (*temp++ != *chr->zb_addr) break;

	return(i);
}



unsigned fortran readasc()

{
	return(_bios_keybrd(_KEYBRD_READ));
}

unsigned fortran readscan()

{
	return((unsigned char) (_bios_keybrd(_KEYBRD_READ) >> 8));
}
unsigned fortran isinp()

{
	return(_bios_keybrd(_KEYBRD_READY));
}


unsigned fortran shiftleft(value)

int value;

{
	return((unsigned char) (value >> 8));
}



unsigned fortran shiftstat()

{
	return((unsigned char) _bios_keybrd(_KEYBRD_SHIFTSTATUS));
}

unsigned fortran prtstat(int prtnr)

{
	return((unsigned char) _bios_printer(_PRINTER_STATUS,(unsigned) prtnr));
}

void fortran initprt(int prtnr)

{
	_bios_printer(_PRINTER_INIT,(unsigned) prtnr);
}

void fortran boot()
{
	union REGS reg;
	int86(0x19,&reg,&reg);
}

int fortran chdrive(int drivenr)

{
	unsigned *Laufwerke;

	_dos_setdrive((unsigned) drivenr,Laufwerke);
	return((unsigned char) *Laufwerke);
}

/*** Spezielle Routinen fÅr die UnterstÅtzung des Moduls FormText.bas ***/

int aesearch(t,start,ende)
struct bas_zk *t;
int *start;
int *ende;

{
	register int i;
	register char *temp;

	temp=t->zb_addr;
	for(i=*start-1; i<*ende; i++)
	       {
	       if ((*temp == (unsigned char) '∫') | (*temp++ == (unsigned char) 'Ÿ')) break;
	       }
	return(i+1);
}

int not250(t,start,ende)
struct bas_zk *t;
int *start;
int *ende;

{
	register int i;
	register char *temp;

	temp=t->zb_addr;
	for(i=*start-1; i<*ende; i++)
	       {
	       if ((*temp++ != (unsigned char) '˙')) break;
	       }
	return(i+1);
}
