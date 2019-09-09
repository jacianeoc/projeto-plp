#include <iostream>

using namespace std;

int galinha = 1;
int raposa = 2;
int cachorro = 3;

int ultimaJogada;

/*True = Margem 1 and False = Margem 2*/ 
bool barqueiro = true;

int margem1[3] = {galinha,raposa,cachorro};
int margem2[3] = {};

bool maisDeUmAnimalNaMargem(int margem[]){
    if (margem[0] == 0 and margem[2] == 0){
        return false;
    }
    else if (margem[1] == 0 and margem[2] == 0){
        return false;
    }
    else if (margem[0] == 0 and margem[1] == 0){
        return false;
    }
    return true;
}

int calculaMargem(int margem[]){
    int soma = 0;
    for (int i = 0; i < 3; i++){
        soma += margem[i];
    }
    return soma;
}

bool verificaMargem(int margem[], int animal){
    for (int i = 0; i < 3; i++){
        if (margem[i] == animal){
            return true;
        }
    }
    return false;
}

void travessia(int margem1[], int margem2[], int animal){
    if(barqueiro == true and animal != 0){
        if (verificaMargem(margem1, animal)){
        margem1[animal-1] = 0;
        margem2[animal-1] = animal;
        barqueiro = false;
        }
        else{
            cout << "Animal selecionado nao se encontra nessa margem";
        }
    }
    
    else if (barqueiro == false and animal != 0){
        if(verificaMargem(margem2, animal)){
            margem2[animal-1] = 0;
            margem1[animal-1] = animal;
            barqueiro = true;
        }
        else{
            cout << "Animal selecionado nao se encontra nessa margem";
        }
    }
    
    /* Barqueiro atravessa só */
    else if (animal == 0 and barqueiro == true){
        barqueiro = false;
    }
    else if (animal == 0 and barqueiro == false){
        barqueiro = true;
    }
}

void situacaoJogador(int margem1[], int margem2[]){
    if (calculaMargem(margem1) % 2 != 0 and maisDeUmAnimalNaMargem(margem1)){
        cout << "PERDEU!" << endl;
    }
    else if (calculaMargem(margem2) % 2 != 0 and maisDeUmAnimalNaMargem(margem2)){
        cout << "PERDEU!" << endl;
    }
    else if (calculaMargem(margem2) == 6){
        cout << "GANHOU! PARABENS!" << endl;
    }
}

void desfazerJogada(){
    //TODO
}

void vizualizaMargens(int margem1[], int margem2[]){
    //TODO
}

void solucao(){
    //TODO
}

int main(){
    /* TESTES */
    
    //travessia(margem1,margem2, galinha);
    travessia(margem1,margem2,raposa);
    travessia(margem1,margem2,0);
    travessia(margem1,margem2,cachorro);
    cout << calculaMargem(margem2) << endl;
    situacaoJogador(margem1,margem2);
}