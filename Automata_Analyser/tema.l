    // INSERT NAME HERE
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <iostream>
    #include <map>
    #include <string>
    #include <vector>
    
    #define GLOBAL 0
    #define AUTOMATA 1
    #define GRAMMAR 2

    using namespace std;

    int states = 0; // numarul de stari din automat
    int first_letter = 1; // imi spune daca e prima litera afisata din alfabet
    int is_final_state = 0; // imi spune daca automatul are stari finale
    char name[50]; // numele variabilei
    char initial_state[100]; // numele starii de unde incepe tranzitia
    char new_stack[1000]; // stringul care descrie stiva dupa tranzitie
    char transition_str[100000]; // stringul care descrie functia de tranzitie
    string current_transition; // string care descrie tranzitia pentru o valoare din variabila
    char variable_name[100]; // numele variabilei
    int variable_place; // locul unde e declarata varibila (global sau local in automat/gramatica)
    char variabile_values[100]; // string care contine valorile unei varibile 
    bool variable = false; // imi zice daca inputul la tranzitie e variabila sau nu
    map<string, string> global_variables; // retin variabilele globale
    map<string, string> local_variables; // retin variabilel locale
    vector<string> variable_transitions; // retin tranzitiile pentru fiecare valoare ale variabilei
%}

    // optiune sa scap de erorile de compilare pentru c++
%option noyywrap

letter [A-Za-z]
alphanum [A-Za-z0-9]
stack_chars [A-Za-z0-9&]
number [0-9]

    // starile folosite
%x TYPE GRAMMAR_ELEMENTS LETTERS PRINT_LETTERS AUTOMATA_ELEMENTS
%x AUTOMATA_ALPHABET STATES INITIAL_STATE FINAL_STATES
%x AUTOMATA_LETTERS AUTOMATA_PRINT TRANSITION
%x INPUT STACK NEW_STACK END_STATE STACK_ALPHABET
%x VARIABLE VARIABLE_VALUES

%%

    /* Ignora comentariile simple */
<INITIAL>"%".* {}
<TRANSITION>"%".* {}
<TYPE>"%".* {}
<AUTOMATA_ELEMENTS>"%".* {}
<AUTOMATA_LETTERS>"%".* {}
<AUTOMATA_PRINT>"%".* {}
<GRAMMAR_ELEMENTS>"%".* {}
<LETTERS>"%".* {}
<PRINT_LETTERS>"%".* {}
<FINAL_STATES>"%".* {}
<INITIAL_STATE>"%".* {}
<STACK>"%".* {}
<END_STATE>"%".* {}
<NEW_STACK>"%".* {}
<STACK_ALPHABET>"%".* {}
<VARIABLE>"%".* {}
<VARIABLE_VALUES>"%".* {}

    /* Ignora comentariile multi-line */
<INITIAL>"/*"[.\n]*"*/" {}
<TRANSITION>"/*"[.\n]*"*/" {}
<TYPE>"/*"[.\n]*"*/" {}
<AUTOMATA_ELEMENTS>"/*"[.\n]*"*/" {}
<AUTOMATA_PRINT>"/*"[.\n]*"*/" {}
<AUTOMATA_LETTERS>"/*"[.\n]*"*/" {}
<GRAMMAR_ELEMENTS>"/*"[.\n]*"*/" {}
<LETTERS>"/*"[.\n]*"*/" {}
<PRINT_LETTERS>"/*"[.\n]*"*/" {}
<STATES>"/*"[.\n]*"*/" {}
<FINAL_STATES>"/*"[.\n]*"*/" {}
<INITIAL_STATE>"/*"[.\n]*"*/" {}
<STACK>"/*"[.\n]*"*/" {}
<END_STATE>"/*"[.\n]*"*/" {}
<NEW_STACK>"/*"[.\n]*"*/" {}
<STACK_ALPHABET>"/*"[.\n]*"*/" {}
<VARIABLE>"/*"[.\n]*"*/" {}
<VARIABLE_VALUES>"/*"[.\n]*"*/" {}

<INITIAL>"variable" {
    variable_place = GLOBAL; // retin ca e variabila globala
    BEGIN(VARIABLE); // incep sa ii caut numele
} // Gasesc declararea unei variabile globale;

<GRAMMAR_ELEMENTS>"variable" {
    variable_place = GRAMMAR; // retin ca e variabila locala in gramatica
    BEGIN(VARIABLE); // incep sa ii caut numele
} // Gasesc declararea unei variabile in gramatica;

<AUTOMATA_ELEMENTS>"variable" {
    variable_place = AUTOMATA; // retin ca e variabila local in automat
    BEGIN(VARIABLE); // incep sa ii caut numele
} // Gasesc declararea unei variabile in automat;

<VARIABLE>[a-zA-z0-9_]+ {
    strcpy(variable_name, yytext); // copiez numele varibilei
    strcpy(variabile_values, "");
    BEGIN(VARIABLE_VALUES); // incep sa caut valorile
} // Iau denumirea variabilei

<VARIABLE_VALUES>{letter}|{number} {
    strcat(variabile_values, yytext); // am gasit o valoare, o adaug in string
} // Iau valorile variabilei

<VARIABLE_VALUES>"}" { // am gasit acolada inchisa, deci am terminat valorile
    // convertesc in string numele si valorile
    string name = string(variable_name);
    string values = string(variabile_values);
    
    // le adaug in map-ul lor corespunzator vizibilitatii 
    if (variable_place == GLOBAL) {
        global_variables[name] = values;
        BEGIN(INITIAL);    
    }
    else {
        local_variables[name] = values;
        if (variable_place == AUTOMATA) {
            BEGIN(AUTOMATA_ELEMENTS);
        } else {
            BEGIN(GRAMMAR_ELEMENTS);
        }
    }
} // Am terminat de prelucrat variabila

<INITIAL>[a-zA-z0-9_]+ {
    strcpy(name, yytext); // retin numele ca nu stiu ce este inca
    BEGIN(TYPE);
} // Gasesc un cuvant inseamna ca e numele gramaticii/automatului

<TYPE>"Grammar" {
    printf("Numele gramaticii: %s\n", name);
    BEGIN(GRAMMAR_ELEMENTS);
} // Daca e gramatica fac lucrurile de gramatica

<GRAMMAR_ELEMENTS>"alphabet" {
    printf("Tipul gramaticii: -\n"); // Nu am implementat tipul gramaticii
    printf("Alfabetul gramaticii: {");
    BEGIN(LETTERS);    
} // Incep sa afisez alfabetul gramaticii

<LETTERS>"{" {
    first_letter = 1;
    BEGIN(PRINT_LETTERS);
} // Incep sa iterez prin literele/simbolurile alfabetului

<PRINT_LETTERS>{alphanum} {
    if (!first_letter) { // Daca nu e prima litera afisez spatiile si virgula
        printf(" , ");
    } else {
        first_letter = 0; // Daca e prima litera o afisez doar pe ea
    }
    printf("%s", yytext);
} // Am gasit o litera/cifra o afisez

<PRINT_LETTERS>"}" { // Am gasit acolada deci am terminat cu alfabetul gramaticii
    printf("}\n");
    BEGIN(GRAMMAR_ELEMENTS);
} // Am gasit '}' se termina

<GRAMMAR_ELEMENTS>";;" {
    local_variables.clear(); // Sterg variabilele locale
    printf("\n");
    BEGIN(INITIAL); // Incep sa caut urmatorul automat/gramatica
} // Am gasit ';;' se termina gramatica

<TYPE>"PushDownAutomata" {
    is_final_state = 0; // Nu stiu daca are stari finale
    printf("Numele automatului: %s\n", name);
    printf("Tipul automatului: Automat cu stiva\n");
    BEGIN(AUTOMATA_ELEMENTS);
} // Daca e automat fac lucrurile de automat

<AUTOMATA_ELEMENTS>"alphabet" {
    printf("Alfabetul de intrare: {");
    BEGIN(AUTOMATA_LETTERS);
} // Cand gasesc alfabetul automatului incep sa afisez elementele acestuia

<AUTOMATA_LETTERS>"{" {
    first_letter = 1;
    BEGIN(AUTOMATA_PRINT);
} // Incep sa iterez prin literele alfabetului

<AUTOMATA_PRINT>{alphanum} {
    if (!first_letter) {
        printf(" , ");
    } else {
        first_letter = 0;
    }
    printf("%s", yytext);
} // Am gasit o litera/cifra o afisez

<AUTOMATA_PRINT>"}" {
    printf("}\n");
    BEGIN(AUTOMATA_ELEMENTS); // Incep sa caut restul de elemente ale automatului
} // Am gasit '}' se termina

<AUTOMATA_ELEMENTS>"stack_alphabet" {
    BEGIN(STACK_ALPHABET);
} // Am gasit alfabetul stivei (ignor tot alfabetul stivei am pus starea sa nu faca match doare pe "alphabet")

<STACK_ALPHABET>";" {
    BEGIN(AUTOMATA_ELEMENTS);
} // Il ignor si trec peste continut

<AUTOMATA_ELEMENTS>"states" {
    states = 0;
    BEGIN(STATES); // Incep sa iterez prin stari
} // Cand gasesc starile automatului incep sa le numar

<STATES>{letter}{number}+ {
    states++;
} // Am gasit o stare cresc contorul

<STATES>"}" {
    printf("Numarul de stari: %d\n", states);
    BEGIN(AUTOMATA_ELEMENTS);
} // Cand gasesc } inseamna ca am terminat cu starile le afisez si caut restul de elemente

<AUTOMATA_ELEMENTS>"initial_state" {
    BEGIN(INITIAL_STATE);
} // Incep sa caut starea initiala

<INITIAL_STATE>{letter}{number}+ {
    printf("Stare initiala: %s\n", yytext);
    BEGIN(AUTOMATA_ELEMENTS);
} // Afisez starea initiala

<AUTOMATA_ELEMENTS>"final_states" {
    is_final_state = 1;
    states = 0; // numarul de stari finale
    printf("Starile finale: {");
    BEGIN(FINAL_STATES);
} // Incep sa caut starile finale

<FINAL_STATES>{letter}{number}+ {
    if (states > 0) { // daca e prima stare nu afisez virula si spatiu
        printf(", ");
    }
    states++;
    printf("%s", yytext);
} // Afisez starea finala

<FINAL_STATES>"}" {
    printf("}\n");
    BEGIN(AUTOMATA_ELEMENTS);
} // Am gasit "}" inseamna ca am afisat toate starile finale

<AUTOMATA_ELEMENTS>{letter}{number}+ {
    strcpy(initial_state, yytext); // retin starea de unde incep tranzitia
    BEGIN(TRANSITION);
} // Am gasit o stare din care plec deci incep sa fac functia de tranzitie

<TRANSITION>{letter}|{number}|[a-zA-Z0-9_]+ {
    const char delimiter_str[10] = ", ";
    current_transition = "";
    // Verific daca simbolul meu este o variabila
    if(local_variables.count(yytext) > 0) { // Verific daca e locala
        variable_transitions.clear();
        for (char c : local_variables[yytext]) {
            current_transition = "";
            current_transition += "\tm(";
            current_transition += initial_state;
            current_transition += ", ";
            current_transition += c;
            current_transition += ", ";
            variable = true;
            variable_transitions.push_back(current_transition);
        }
    } else if (global_variables.count(yytext) > 0) {
        variable_transitions.clear();
        for (char c : global_variables[yytext]) { // Verific daca e globala
            current_transition = "";            
            current_transition += "\tm(";
            current_transition += initial_state;
            current_transition += ", ";
            current_transition += c;
            current_transition += ", ";
            variable = true;
            variable_transitions.push_back(current_transition);
        }
    } else { // E simbol din alfabet
        variable = false;
        strcat(transition_str, "\tm(");
        strcat(transition_str, initial_state);
        strcat(transition_str, delimiter_str);
        strcat(transition_str, yytext);    
        strcat(transition_str, delimiter_str);
    }
    BEGIN(STACK); // Incep sa preiau elementele din stiva
} // Am gasit simbolul cu care trec in alta stare

<STACK>{stack_chars}+ {
    if (!variable) { // Daca am avut simbol il adaug la sirul functiei de tranzitie
        strcat(transition_str, yytext);
        strcat(transition_str, ") = (");
    } else { // Daca e variabila modific sirul fiecarei valori ale variabilei
        for (int i = 0; i < variable_transitions.size(); i++) {
            variable_transitions[i] += yytext;
            variable_transitions[i] += ") = (";
        }
    }
    BEGIN(NEW_STACK); // Incep sa caut stiva dupa tranzitie
} // Am gasit stiva initiala

<NEW_STACK>{stack_chars}+ { // Am gasit stiva modificata
    strcpy(new_stack, "");
    strcpy(new_stack, yytext); // Ii retin continutul
    BEGIN(END_STATE); // Incep sa caut starea finala
} // Retin continutul stivei dupa ce fac tranzitia

<END_STATE>{letter}{number}+ { // Am gasit starea finala
    if (!variable) { // Daca am simbol, adaug tranzitia la functia de tranzitie
        strcat(transition_str, yytext);
        strcat(transition_str, ", ");
        strcat(transition_str, new_stack);
        strcat(transition_str, ")\n");
    } else { // Daca am avut variabila adaug tranzitiile pentru fiecare valoare a variabilei
        variable = false;
        for (int i = 0; i < variable_transitions.size(); i++) {
            variable_transitions[i] += yytext;
            variable_transitions[i] += ", ";
            variable_transitions[i] += new_stack;
            variable_transitions[i] += ")\n";     
            strcat(transition_str, variable_transitions[i].c_str());             
        }
    }
    BEGIN(TRANSITION); // Caut urmatoarea tranzitie
} // Am gasit starea noua, afisez stiva noua si starea

<TRANSITION>")" {
    BEGIN(AUTOMATA_ELEMENTS);
} // Am gasit ")" inseamna ca se termina tranzitiile

<AUTOMATA_ELEMENTS>";;" {
    local_variables.clear(); // sterg varibilele locale
    if (is_final_state == 0) {
        printf("Starile finale: {}\n");
    } // daca nu are stari finale, afisez mesaj ca nu are

    // afisez functia de tranzitie
    printf("Functia de tranzitie:\n");
    printf("%s\n",transition_str);
    
    // sterg continutul starii de tranzitie si numele starii initiale
    strcpy(transition_str, "");
    strcpy(initial_state, "");    
    BEGIN(INITIAL);
} // Am gasit ;; se termina automatul

 /* Ignor tot ce nu imi face match pe ceva ca sa nu mi le afiseze by default */
<INITIAL>.|\n {}
<TYPE>.|\n {}
<AUTOMATA_ELEMENTS>.|\n {}
<AUTOMATA_LETTERS>.|\n {}
<AUTOMATA_PRINT>.|\n {}
<GRAMMAR_ELEMENTS>.|\n {}
<LETTERS>.|\n {}
<PRINT_LETTERS>.|\n {}
<STATES>.|\n {}
<FINAL_STATES>.|\n {}
<INITIAL_STATE>.|\n {}
<TRANSITION>.|\n {}
<STACK>.|\n {}
<NEW_STACK>.|\n {}
<END_STATE>.|\n {}
<STACK_ALPHABET>.|\n {}
<VARIABLE>.|\n {}
<VARIABLE_VALUES>.|\n {}
%%

int main(int argc, char *argv[]){
    FILE *fp; 
    fp = fopen(argv[1],"r"); 
    yyin = fp;     
    yylex();
    return 0;
}