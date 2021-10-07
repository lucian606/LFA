      //334CC ILIESCU LUCIAN-MARIUS
%{
int space_count = 0;
int attributes_found = 0;
%}

letter [A-Za-z]
alphanum [a-z0-9]

%x TAG ATRIBUTE VALUE PRINT

%%
<INITIAL>"<?"[^>]*">" {
} //Daca gasesc un tag ce incepe cu '?' il ignor

<INITIAL>"<!--"[.\n]*"-->" {
} //Ignora comentariile

<INITIAL>"<!"[^>]*">" {
} // Daca gasesc un tag ce incepe cu '!' il ignor

<INITIAL>"</"{alphanum}+">" {
      space_count--;
} // Daca gasesc inchiderea unui tag scad numaru de spatii

<INITIAL>"<" {
      attributes_found = 0;
      BEGIN(TAG);
} // Daca gasesc '<' deschid un tag

<TAG>{alphanum}+ {
      for (int i = 0; i < space_count; i++) {
            printf(" ");
      }
      space_count++;
      printf("%s", yytext);
      BEGIN(ATRIBUTE);
} // Primul cuvant in starea TAG este numele tagului afisez si caut atributele

<TAG>"<!--"[.\n]+"-->" {
} //Ignora comentariile

<ATRIBUTE>">" {
      printf("\n");
      BEGIN(INITIAL);
} // Daca gasesc '>' inchid tagul

<ATRIBUTE>"/>" {
      printf("\n");
      space_count--;
      BEGIN(INITIAL);
} // Daca gasesc '/>' inchid tagul si scad numarul de spatii

<ATRIBUTE>[^ \n"=">]+ {
      if(attributes_found == 0) {
            printf(" ::");
            attributes_found = 1;
      }
      printf(" %s :", yytext);
      BEGIN(VALUE);
} // Daca gasesc un atribut il afisez si ii caut valoarea

<ATRIBUTE>.|\n {}

<ATRIBUTE>"<!--"[.\n]+"-->" {
} //Ignora comentariile

<VALUE>\" {
      BEGIN(PRINT);
} // Daca gasesc ghilimele inseamna ca incep sa afisez valoarea

<VALUE>.|\n {}

<VALUE>"<!--"[.\n]+"-->" {
} //Ignora comentariile


<PRINT>\" {
      printf("  ;");
      BEGIN(ATRIBUTE);
} // Daca am gasit ghilemele imediat ce am inceput sa caut (valoare goala)

<PRINT>[^\"<]* {
      printf(" %s ;", yytext);
      BEGIN(ATRIBUTE);
} // Afisez tot ce gasesc pana la ""

<PRINT>"<!--"[.\n]+"-->" {
} //Ignora comentariile

<INITIAL>.|\n {}
%% 

int main(int argc, char *argv[]){
      FILE *f = fopen(argv[1], "r");
      yyin = f;
      yylex();  
      return 0; 
}
