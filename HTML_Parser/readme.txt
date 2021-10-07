Iliescu Lucian-Marius 334CC

Am folosit 5 stari: INITIAL TAG ATRIBUTE VALUE PRINT:

In starea INITIAL caut '<' pentru a deschide un tag.
Cand am gasit intru in starea TAG.

In starea TAG primul cuvant gasit este numele tagului.
Afisez tagul si intru in starea ATRIBUTE.

In starea ATRIBUTE primul cuvant care poate avea si
simboluri in nume este atributul. Daca e primul atribut
afises ::. Dupa afisare intru in starea VALUE.

Daca in starea ATRIBUTE gasesc > inseamna ca am
terminat tagul respectiv.

In starea VALUE caut ". Cand am gasit " inseamna ca am
gasit valoarea atributului si intru in starea PRINT.

In starea PRINT afisez ce se afla intre "" si revin
la starea ATRIBUTE, atunci cand gasesc ".

Checker

Pentru simplitate in verificarea corectitudinii am facut un
script in python care verifica outputul testelor cu outputul
asteptat. Pentru rulare se foloseste : python3 checker.py

Exemple:

Am luat doua exemple de pe GeeksForGeeks si unul dintr-un curs de web developement.