erase mylib.lib
erase mylib.qlb
lib mylib.lib+mylib.obj;
link/q mylib.lib,mylib.qlb,nul,bqlb41.lib; /ST 4000
