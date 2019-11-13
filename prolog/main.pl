:- initialization main.

visualizaMargens(Margem1):-
    nl, write( "                                            Ｔｒａｖｅｓｓｉａ"), nl,
    imprimeBarco(Margem1,ImprimeB),imprimeGalinha(Margem1,ImprimeG),imprimeRaposa(Margem1,ImprimeR),imprimeCachorro(Margem1,ImprimeC),
    writeln(ImprimeG), writeln(ImprimeR), writeln(ImprimeC), writeln(ImprimeB).

imprimeGalinha(Margem1,ImprimeG):-
    Margem1 \= (0,B,C,D), 
    ImprimeG = ' 1- Galinha   -->		     🐥 ░                       ░      ';
    ImprimeG = ' 1- Galinha   -->		        ░                       ░🐥        '.

imprimeRaposa(Margem1,ImprimeR):-
    Margem1 \= (A,0,C,D), 
    ImprimeR = ' 2- Raposa   -->		     🦊 ░                       ░       ';
    ImprimeR = ' 2- Raposa   -->		        ░                       ░ 🦊        '.

imprimeCachorro(Margem1,ImprimeC):-
    Margem1 \= (A,B,0,D), 
    ImprimeC = ' 3- Cachorro   -->		     🐶 ░                       ░       ';
    ImprimeC = ' 3- Cachorro   -->		        ░                       ░ 🐶        '.

imprimeBarco(Margem1,ImprimeB):-
    Margem1 \= (A,B,C,0), 
    ImprimeB = ' 4- Barco   -->		                ░⛵                     ░      ';
    ImprimeB = ' 4- Barco   -->		                ░                    ⛵ ░        '.


desfazerJogada(Margem1,Margem2, JogadaMargem1, JogadaMargem2, Margem1Final,Margem2Final):-
     writeln('Desfazer Jogada? [s/n] '),
     read(Op),
     Op == 's',
     Margem1Final = Margem1,
     Margem2Final = Margem2,
     iniciar(Margem1Final,Margem2Final);
     Margem1Final = JogadaMargem1,
     Margem2Final = JogadaMargem2,
     iniciar(Margem1Final,Margem2Final).



%barqueiro na margem 1
fazerJogada(1,(1,B,C,4), (0,F,G,0),(0,B,C,0),(1,F,G,4)).
fazerJogada(2,(A,2,C,4), (E,0,G,0),(A,0,C,0),(E,2,G,4)).
fazerJogada(3,(A,B,3,4), (E,F,0,0),(A,B,0,0),(E,F,3,4)).
fazerJogada(4,(A,B,C,4), (E,F,G,0),(A,B,C,0),(E,F,G,4)).

%barqueiro na margem 2
fazerJogada(1,(0,B,C,0), (1,F,G,4),(1,B,C,4),(0,F,G,0)).
fazerJogada(2,(A,0,C,0), (E,2,G,4),(A,2,C,4),(E,0,G,0)).
fazerJogada(3,(A,B,0,0), (E,F,3,4),(A,B,3,4),(E,F,0,0)).
fazerJogada(4,(A,B,C,0), (E,F,G,4),(A,B,C,4),(E,F,G,0)).


fazerJogada(_,Margem1,Margem2,_,_):-
    writeln('Animal selecionado nao se encontra nessa margem'),
    iniciar(Margem1,Margem2).

%barqueiro na margem1 -- animal nao esta na margem
fazerJogada(1,(0,B,C,4),Margem2,_,_):-
    writeln('Animal selecionado nao se encontra nessa margem'),
    iniciar((0,B,C,4),Margem2).

fazerJogada(2,(A,0,C,4),Margem2,_,_):-
    writeln('Animal selecionado nao se encontra nessa margem'),
    iniciar((A,0,C,4),Margem2).

fazerJogada(3,(A,B,0,4),Margem2,_,_):-
    writeln('Animal selecionado nao se encontra nessa margem'),
    iniciar((A,B,0,4),Margem2).

%barqueiro na margem2 -- animal nao esta na margem
%fazerJogada... (acho q deu pra sacar como q faz o resto)

gameOver:- writeln('                                      Ｐｅｒｄｅｕ ！        '),
           nl,
           writeln('Mostrar solução? [s/n]'),
           read(Op),
           solucao(Op).

iniciar((0,0,0,0), (1,2,3,4)):- writeln('                                       Ｇａｎｈｏｕ！ Ｐａｒａｂｅｎｓ ！        '), halt().

iniciar((1,2,0,0), (0,0,3,4)):- gameOver.
iniciar((0,2,3,0), (1,0,0,4)):- gameOver.
iniciar((0,0,3,4), (1,2,0,0)):- gameOver.
iniciar((1,0,0,4), (0,2,3,0)):- gameOver.

solucao(Op):- 
               Op == 's',
               writeln('                             S O L U Ç Ã O '),
               nl,
               writeln('Passo 1- Atravessar a raposa para a outra margem (margem2)'),
               writeln('Passo 2- Fazer o barqueiro voltar para a margem de partida (margem1)'),
               writeln('Passo 3- Levar o cachoro para a margem2'),
               writeln('Passo 4- Trazer a raposa para a margem1, já que a raposa não pode ficar \n com cachorro sem a presença do barqueiro'),
               writeln('Passo 5- Levar a galinha para a margem2, para não ficar junto com a raposa'),
               writeln('Passo 6- O barqueiro volta para a margem1'),
               writeln('Passo 7- O barqueiro leva a raposa, fim !!!!!'),halt();
               halt().

iniciar(Margem1, Margem2):-
                        visualizaMargens(Margem1),
                        writeln('Digite o Numero para Mover: '),
                        read(Animal),
                        fazerJogada(Animal, Margem1, Margem2, JogadaMargem1, JogadaMargem2),
                        visualizaMargens(JogadaMargem1),
                        desfazerJogada(Margem1, Margem2, JogadaMargem1, JogadaMargem2,Margem1Final,Margem2Final),
                        NewMargem1 = Margem1Final,
                        NewMargem2 = Margem2Final,
                        iniciar(NewMargem1,NewMargem2).


main:-
    nl, writeln('BEM VINDO A TRAVESSIA!'),nl,
    writeln('Nesse jogo o barqueiro deve atravessar os 3 animais sem conflitos ;)'), nl,
    writeln('As regras sao simples:'),
    writeln('1° - Existe espaço para apenas 2 no barco, apenas um animal pode ser atravessado por vez'),
    writeln('2° - O barqueiro pode atravessar o rio sozinho (ele esta sempre no barco)'),
    writeln('3° - Raposa e galinha não podem ficar juntas e sozinhas porque a raposa irá atacar a galinha.'),
    writeln('4° - O cachorro e a raposa não podem ficar juntos e sozinhos porque o cachorro irá atacar a raposa.'),
    writeln('5° - As outras combinações de animais não apresentam o problema de um atacar o outro.'),nl,
    iniciar((1,2,3,4),(0,0,0,0)).
