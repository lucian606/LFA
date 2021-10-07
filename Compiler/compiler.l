    // 334CC IOAN MIRCEA-PETRU
%{
    #include <bits/stdc++.h>
    #define CHAR 0
    #define SIGNED_CHAR 1
    #define UNSIGNED_CHAR 2
    #define SHORT 3
    #define SHORT_INT 4
    #define SIGNED_SHORT 5
    #define SIGNED_SHORT_INT 6
    #define UNSIGNED_SHORT 7
    #define UNSIGNED_SHORT_INT 8
    #define INT 9
    #define SIGNED 10
    #define SIGNED_INT 11
    #define UNSIGNED 12
    #define UNSIGNED_INT 13
    #define LONG 14
    #define LONG_INT 15
    #define SIGNED_LONG 16
    #define SIGNED_LONG_INT 17
    #define UNSIGNED_LONG 18
    #define UNSIGNED_LONG_INT 19    
    #define LONG_LONG 20
    #define LONG_LONG_INT 21
    #define SIGNED_LONG_LONG 22
    #define SIGNED_LONG_LONG_INT 23
    #define UNSIGNED_LONG_LONG 24
    #define UNSIGNED_LONG_LONG_INT 25    
    #define FLOAT 26
    #define DOUBLE 27
    #define LONG_DOUBLE 28
    using namespace std;
    string function_type;
    string function_name;
    string function_args;
    bool is_spaced;
    int brackets = 0;
    int array_brackets = 0;
    int variables_count = 0;
    int variables_type;
    map<string, vector<string>> local_variables;
%}

name_chars [a-zA-Z0-9_\[\]]

%option noyywrap

%x FUNCTION_NAME ARGS VARIABLES TYPES VALUES ARRAY

%%
    /* Ignor variabile globale */
<INITIAL>[^;()]*";" {}
    /* Caut tipul functiei */
<INITIAL>"void" {
    function_type = "void";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"int" {
    function_type = "int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed" {
    function_type = "signed";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"int" {
    function_type = "signed int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"char" {
    function_type = "char";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"char" {
    function_type = "signed char";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"char" {
    function_type = "unsigned char";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"short" {
    function_type = "short";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"short"[ \n]+"int" {
    function_type = "short int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"short" {
    function_type = "signed short";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"short"[ \n]+"int" {
    function_type = "signed short int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"short" {
    function_type = "unsigned short";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"short"[ \n]+"int" {
    function_type = "unsigned short int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned" {
    function_type = "unsigned";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"int"  {
    function_type = "unsigned int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"long" {
    function_type = "long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"long"[ \n]+"int" {
    function_type = "long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"long" {
    function_type = "signed long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"long"[ \n]+"int" {
    function_type = "signed long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"long" {
    function_type = "unsigned long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"long"[ \n]+"int" {
    function_type = "unsigned long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"long"[ \n]+"long" {
    function_type = "long long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"long"[ \n]+"long"[ \n]+"int" {
    function_type = "long long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"long"[ \n]+"long" {
    function_type = "signed long long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"signed"[ \n]+"long"[ \n]+"long"[ \n]+"int" {
    function_type = "signed long long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"long"[ \n]+"long" {
    function_type = "unsigned long long";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"unsigned"[ \n]+"long"[ \n]+"long"[ \n]+"int" {
    function_type = "unsigned long long int";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"float" {
    function_type = "float";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"double" {
    function_type = "double";
    BEGIN(FUNCTION_NAME);
}

<INITIAL>"long"[ \n]+"double" {
    function_type = "long double";
    BEGIN(FUNCTION_NAME);
}

    /*Iau numele functiei*/
<FUNCTION_NAME>{name_chars}+ {
    function_name = yytext;
    function_args = "";
    is_spaced = true;
    BEGIN(ARGS);
}
    /*Iau argumentele*/
<ARGS>[(a-zA-Z0-9_\[\]] {
    is_spaced = false;
    function_args += yytext;
}

<ARGS>"," {
    function_args += yytext;
    function_args += " ";
    is_spaced = true;
}

<ARGS>" " {
    if (!is_spaced) {
        function_args += yytext;
    }
    is_spaced = true;
}

<ARGS>")" {
    function_args+=")";
    string function = function_type + " " + function_name + function_args;
    printf("%s\n", function.c_str());
    printf("\ttip intors: %s\n", function_type.c_str());    
    printf("\tnume: %s\n", function_name.c_str());
    BEGIN(TYPES);
}

    /* Iau tipul variabilei */
<TYPES>"int" {
    variables_type = INT;
    BEGIN(VARIABLES);
}

<TYPES>"signed" {
    variables_type = SIGNED;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"int" {
    variables_type = SIGNED_INT;
    BEGIN(VARIABLES);
}

<TYPES>"char" {
    variables_type = CHAR;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"char" {
    variables_type = SIGNED_CHAR;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"char" {
    variables_type = UNSIGNED_CHAR;
    BEGIN(VARIABLES);
}

<TYPES>"short" {
    variables_type = SHORT;
    BEGIN(VARIABLES);
}

<TYPES>"short"[ \n]+"int" {
    variables_type = SHORT_INT;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"short" {
    variables_type = SIGNED_SHORT;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"short"[ \n]+"int" {
    variables_type = SIGNED_SHORT_INT;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"short" {
    variables_type = UNSIGNED_SHORT;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"short"[ \n]+"int" {
    variables_type = UNSIGNED_SHORT_INT;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned" {
    variables_type = UNSIGNED;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"int" {
    variables_type = UNSIGNED_INT;
    BEGIN(VARIABLES);
}

<TYPES>"long" {
    variables_type = LONG;
    BEGIN(VARIABLES);
}

<TYPES>"long"[ \n]+"int" {
    variables_type = LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"long" {
    variables_type = SIGNED_LONG;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"long"[ \n]+"int" {
    variables_type = SIGNED_LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"long" {
    variables_type = UNSIGNED_LONG;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"long"[ \n]+"int" {
    variables_type = UNSIGNED_LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"long"[ \n]+"long" {
    variables_type = LONG_LONG;
    BEGIN(VARIABLES);
}

<TYPES>"long"[ \n]+"long"[ \n]+"int" {
    variables_type = LONG_LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"long"[ \n]+"long" {
    variables_type = SIGNED_LONG_LONG;
    BEGIN(VARIABLES);
}

<TYPES>"signed"[ \n]+"long"[ \n]+"long"[ \n]+"int" {
    variables_type = SIGNED_LONG_LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"long"[ \n]+"long" {
    variables_type = UNSIGNED_LONG_LONG;
    BEGIN(VARIABLES);
}

<TYPES>"unsigned"[ \n]+"long"[ \n]+"long"[ \n]+"int" {
    variables_type = UNSIGNED_LONG_LONG_INT;
    BEGIN(VARIABLES);
}

<TYPES>"float" {
    variables_type = FLOAT;
    BEGIN(VARIABLES);
}

<TYPES>"double" {
    variables_type = DOUBLE;
    BEGIN(VARIABLES);
}

<TYPES>"long"[ \n]+"double" {
    variables_type = LONG_DOUBLE;
    BEGIN(VARIABLES);
}

    /* Ignor cuvintele care au tipuri in nume gen "intentionat" sau casturile */
<TYPES>[)(a-zA-Z0-9_\[\]]+ {}

    /* Iau numele variabilei */
<VARIABLES>{name_chars}+ {
    variables_count++;
    switch(variables_type) {
        case CHAR:
            local_variables["char"].push_back(yytext);
        break;
        case SIGNED_CHAR:
            local_variables["signed char"].push_back(yytext);
        break;
        case UNSIGNED_CHAR:
            local_variables["unsigned char"].push_back(yytext);
        break;
        case SHORT:
            local_variables["short"].push_back(yytext);
        break;        
        case SHORT_INT:
            local_variables["short int"].push_back(yytext);
        break;      
        case SIGNED_SHORT:
            local_variables["signed short"].push_back(yytext);
        break;    
        case SIGNED_SHORT_INT:
            local_variables["signed short int"].push_back(yytext);
        break;       
        case UNSIGNED_SHORT:
            local_variables["unsigned short"].push_back(yytext);
        break;
        case UNSIGNED_SHORT_INT:
            local_variables["unsigned short int"].push_back(yytext);
        break;
        case INT:
            local_variables["int"].push_back(yytext);
        break;
        case SIGNED:
            local_variables["signed"].push_back(yytext);
        break;
        case SIGNED_INT:
            local_variables["signed int"].push_back(yytext);
        break;
        case UNSIGNED:
            local_variables["unsigned"].push_back(yytext);
        break;
        case UNSIGNED_INT:
            local_variables["unsigned int"].push_back(yytext);
        break;                                                     
        case LONG:
            local_variables["long"].push_back(yytext);
        break;
        case LONG_INT:
            local_variables["long int"].push_back(yytext);
        break;    
        case SIGNED_LONG:
            local_variables["signed long"].push_back(yytext);
        break;
        case SIGNED_LONG_INT:
            local_variables["signed long int"].push_back(yytext);
        break;     
        case UNSIGNED_LONG:
            local_variables["unsigned long"].push_back(yytext);
        break;
        case UNSIGNED_LONG_INT:
            local_variables["unsigned long int"].push_back(yytext);
        break;
        case LONG_LONG:
            local_variables["long long"].push_back(yytext);
        break;
        case LONG_LONG_INT:
            local_variables["long long int"].push_back(yytext);
        break;
        case SIGNED_LONG_LONG:
            local_variables["signed long long"].push_back(yytext);
        break;
        case SIGNED_LONG_LONG_INT:
            local_variables["signed long long int"].push_back(yytext);
        break;                       
        case UNSIGNED_LONG_LONG:
            local_variables["unsigned long long"].push_back(yytext);
        break;
        case UNSIGNED_LONG_LONG_INT:
            local_variables["unsigned long long int"].push_back(yytext);
        break;
        case FLOAT:
            local_variables["float"].push_back(yytext);
        break;
        case DOUBLE:
            local_variables["double"].push_back(yytext);
        break;
        case LONG_DOUBLE:
            local_variables["long double"].push_back(yytext);
        break;                           
    }
    BEGIN(VALUES);
}

    /* Se declara vector */
<VALUES>"{" {
    array_brackets = 1;
    BEGIN(ARRAY);
}

    /* Se declara vector in vector */
<ARRAY>"{" {
    array_brackets++;
}

    /* Se inchide un vector in vector */
<ARRAY>"}" {
    array_brackets--;
    if (!array_brackets) {
        BEGIN(VALUES);
    }
}

    /* Am gasit virgula/punct si virgula, deci gata variabila */
<VALUES>"," {
    BEGIN(VARIABLES);
}

<VALUES>";" {
    BEGIN(TYPES);
}

    /* Deschid acolada */
<TYPES>"{" {
    brackets++;
}

    /* Inchid acolada */
<TYPES>"}" {
    brackets--;
    if(!brackets) {
        BEGIN(INITIAL);
        printf("\tvariabile locale: %d (", variables_count);
        string output = "";
        vector<string> map_keys;
        for (auto const& element : local_variables) {
            map_keys.push_back(element.first);
        }
        for (int j = 0; j < map_keys.size(); j++) {
            string type = map_keys[j];
            output += type;
            for (int i = 0; i < local_variables[type].size(); i++) {
                if (i == local_variables[type].size() - 1) {
                    output += " ";
                    output += local_variables[type][i];
                    if (j < map_keys.size() - 1) {
                        output += ";\n\t\t\t     ";
                    }
                } else {
                    output += " ";
                    output += local_variables[type][i];
                    output += ",";              
                }
            }
        }
        printf("%s)\n\n", output.c_str());
        variables_count = 0;
        map_keys.clear();
        local_variables.clear();
        function_name = "";
        function_args = "";
        function_type = "";
    }
}

    /*ignor include-urile*/
<INITIAL>"#".* {}
    /*ignor comentariile de o linie*/
<INITIAL,FUNCTION_NAME,ARGS,VARIABLES,TYPES,VALUES,ARRAY>"//".* {}
    /*ignor comentariile multi-line*/
<INITIAL,FUNCTION_NAME,ARGS,VARIABLES,TYPES,VALUES,ARRAY>[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] {}
    /*suprascriu regula default*/
<INITIAL,FUNCTION_NAME,ARGS,VARIABLES,TYPES,VALUES,ARRAY>.|\n {}
%%

int main(int argc, char* argv[]) {
    FILE *fp; 
    fp = fopen(argv[1],"r"); 
    yyin = fp;     
    yylex();
    return 0;
}