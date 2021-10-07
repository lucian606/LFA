334CC IOAN MIRCEA-PETRU

In realizarea temei am folosit C++ si Flex, am folosit C++ deoarece am avut
nevoie de templateurile din STL pentru map si vector. In map retin variabilele
locale functiei, unde cheia este un string(tipul variabilei) si valoarea este
un vector de stringuri cu numele variabilelor de acel tip din functia respectiva).


Am folosit urmatoarele stari:

INITIAL: caut tipul functiei si ignor variabilele globale, daca gasesc tipul
         intru in FUNCTION_NAME
FUNCTION_NAME: iau numele functiei si dupa intru in ARGS
ARGS: iau argumentele functiei, ignorand spatiile in plus si punand spatiu dupa
      virgule, dupa intru in TYPES
TYPES: caut tipul de date al variabilelor si retin ce tip e si dupa merg in
       VARIABLES, de asemenea retin numarul de acolade deschise si cand inchid
       una scad numarul si daca am ajuns la 0 acolade inseamna ca s-a terminat
       functia functie si afisez variabilele acesteia si sterg variabilele salvate
VARIABLES: caut numele variabilei si ma opresc la primul spatiu sau la egal,
           dupa in functie de ce tip e variabila o bag in map si ma duc in VALUES
VALUES: caut valoarea variabilei si daca gasesc '{' intru in ARRAY, cand am gasit
        , inseamna ca am terminat cu variabila si incep sa caut alta in VARIABLES
ARRAY: numar acoladele deschise si cand dau de '}' scad numarul, cand am ajuns la
       0, inseamna ca am terminat declaratia de vector deci incep sa caut alte
       variabile in VARIABLES

Tema poate primi fisierul ca argument sau cu redirectare "<";
