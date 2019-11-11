
:- initialization main, halt().



main:-
    nl, writeln("BEM VINDO A TRAVESSIA!"),nl,
    writeln("Nesse jogo o barqueiro deve atravessar os 3 animais sem conflitos ;)"), nl,
    writeln("As regras sao simples:"),
    writeln("1° - Existe espaço para apenas 2 no barco, apenas um animal pode ser atravessado por vez"),
    writeln("2° - O barqueiro pode atravessar o rio sozinho (ele esta sempre no barco)"),
    writeln("3° - Raposa e galinha não podem ficar juntas e sozinhas porque a raposa irá atacar a galinha."),
    writeln("4° - O cachorro e a raposa não podem ficar juntos e sozinhos porque o cachorro irá atacar a raposa."),
    writeln("5° - As outras combinações de animais não apresentam o problema de um atacar o outro."),nl.

