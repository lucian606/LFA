INSERT NAME HERE

Fisierele de intrare sunt exemplu1.txt si exemplu2.txt

Pentru realizarea temei am folosit C++ si Flex.
Am folosit C++ deoarece imi trebuia structura de hash-map din STL, necesara
la retinerea variabilelor si valorilor corespondente.

Am folosit mai multe stari pe parcusul programului si am sa explic ce face
fiecare stare. La un moment dat erau multe stari asa ca am folosit niste
variabile ajutatoare care sa imi spuna din ce stare am plecat pentru a avea
o stare comuna dar sa faca lucruri diferite in functie de stare anterioara.

INITIAL: imi cauta declarari de varibile/automate/gramatici
VARIABLE: imi cauta numele variabilei
VARIABLE_VALUES: imi cauta valorile variabilei
TYPE: imi cauta tipul structurii (automat sau gramatica)
GRAMMAR_ELEMENTS: imi cauta elementele gramaticii (alfabet, terminali etc)
LETERS: imi cauta simbolurile (literele) din alfabetul gramaticii
PRINT_LETERS: imi afiseaza literele alfabetului gramaticii
AUTOMATA_ELEMENTS: imi cauta elementele automatului (alfabet, stari, tranzitii etc)
AUTOMATA_LETTERS: imi cauta simbolurile (literele) din alfabetul automatului
AUTOMATA_PRINT: imi afiseaza literele alfabetului automatului
STACK_ALPHABET: imi sare peste alabetu stivei
STATES: imi numara starile automatului
INITIAL_STATE: imi afiseaza starea initiala
FINAL_STATES: imi cauta starile finale si le afiseaza
TRANSITION: imi cauta inputul necesar tranzitiei
STACK: imi cauta stiva initial tranzitiei
NEW_STACK: imi cauta stiva dupa tranzitie
END_STATE: imi cauta stare dupa tranzitie

In map-ul cu variabile, cheia este numele variabilei si valoarea este sirul
cu simbolurile pe care le poate lua. Atunci cand gasesc o variabila retin
locul unde a fost declarata pentru a sti in ce map o bag.

Modul de functionare al programului:

Incep din starea INITIAL.
Daca am gasit o declaratie de varabila intru in starea VARIABLE. Retin numele
variabilei si dupa merg in starea VARIABLE_VALUES unde iau fiecare simbol si
il adaug in sirul cu valori, la final adaug variabila in map-ul cu variabile globale.
Daca am gasit un cuvant inseamna ca e o declaratie de automat/gramatica si e
numele acestuia. Retin numele si merg in starea TYPE sa aflu ce este.
Daca gasesc "Grammar" inseamna ca am o gramatica si incep sa ma uit dupa elementele
de gramatica, intrand in starea GRAMMAR_ELEMENTS.
Daca gasesc ";;" sterg variabilele locale si merg in INITIAL.
In starea grammar elements caut declaratii de variabile si daca am gasit procedez
la fel ca la variabile globale doar ca bag in map-ul cu cele locale.
Daca gasesc "alphabet" inseamna ca am gasit alfabetul gramaticii si intru in
starea LETTERS. In LETTERS retin ca nu am gasit primul simbol si intru in starea
PRINT_LETERS. In PRINT_LETERS caut simbolurile si le afisez.
Daca gasesc "PushDownAutomata" inseamna ca am automat cu stiva si incep sa ma uit
dupa elementele de automat, intrand in starea AUTOMATA_ELEMENTS.
Daca gasesc "alphabet", procedez ca la gramatica doar ca am starile AUTOMATA_LETTERS si
AUTOMATA_PRINT.
Daca gasesc "stack_alphabet", intru in starea STACK_ALPHABET si ignor tot pana la ;.
Daca gasesc "states", intru in starea STATES si incep sa caut starile si le numar.
Daca gasesc "initial_state", intru in INITIAL_STATE si afisez starea initiala.
Daca gasesc "final_states", intru in FINAL_STATES si procedez la fel ca la STATES,
doar ca afisez starile nu le numar.
Daca am gasit o stare de forma litera-numar inseamna ca am gasit definitia unei
stari de tranzitie si intru in TRANSITION.
In TRANSITION caut inputul pentru tranzitie si verific daca e variabila.
Daca e variabila folosesc un vector sa retin tranzitia pentru fiecare valoare
din variabila declarata. Daca nu e o variabila, adaug direct la stringul functiei
de tranzitie. Indiferent de ce este merg in starea STACK si adaug continutul stivei
initiale la tranzitie apoi merg in NEW_STACK sa retin continutul stivei dupa
tranzitie si in END_STATE caut starea in care merg si adaug la tranzitie
continutul stivei dupa tranzitie si starea in care merg.
Daca gasesc ";;" sterg variabilele loca, afisez starile finale (daca nu le-am gasit)
si afisez functia de tranzitie, dupa care curat stringurile respective.
