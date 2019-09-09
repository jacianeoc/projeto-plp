#include <iostream>
#include <vector>

using namespace std;

/** OPCAO DE DESFAZER JOGADA NAO IMPLEMETADA - USAR IDEA DE MANTER COPY DOS ARRAYS(SE QUISER) **/


/* Animais da ao serem atravessados pelo rio */
int galinha = 1;
int raposa = 2;
int cachorro = 3;

/* Opcao selecionada*/
int opcao;

/* Copias para refazer jogada */
int margem1copy[3] = {};
int margem2copy[3] = {};

/*True = Margem 1 and False = Margem 2*/ 
bool barqueiro = true;

/* Margens do Rio */
int margem1[3] = {galinha,raposa,cachorro};
int margem2[3] = {};

/* Boolean para verificar se existe mais de um animal na margem */
bool maisDeUmAnimalNaMargem(int m[]){
    if (m[0] == 0 and m[2] == 0){
        return false;
    }
    else if (m[1] == 0 and m[2] == 0){
        return false;
    }
    else if (m[0] == 0 and m[1] == 0){
        return false;
    }
    return true;
}

/* Calcula a soma dos animais da margem escolhida */
int calculaMargem(int m[]){
    int soma = 0;
    for (int i = 0; i < 3; i++){
        soma += m[i];
    }
    return soma;
}

/* Verifica se certo animal existe em determinada margem */
bool verificaMargem(int m[], int animal){
    for (int i = 0; i < 3; i++){
        if (m[i] == animal){
            return true;
        }
    }
    return false;
}

/* Metodo que realiza a travessia do animal no rio ou a travessia apenas do barqueiro */
void travessia(int m1[], int m2[], int animal){
    if(barqueiro == true and animal != 0){
        if (verificaMargem(m1, animal)){
        m1[animal-1] = 0;
        m2[animal-1] = animal;
        barqueiro = false;
        }
        else{
            cout << " " << endl;
            cout << "Animal selecionado nao se encontra nessa margem" << endl;
        }
    }
    
    else if (barqueiro == false and animal != 0){
        if(verificaMargem(m2, animal)){
            m2[animal-1] = 0;
            m1[animal-1] = animal;
            barqueiro = true;
        }
        else{
            cout << " " << endl;
            cout << "Animal selecionado nao se encontra nessa margem" << endl;
        }
    }
    
    // Barqueiro atravessa só
    else if (animal == 0 and barqueiro == true){
        barqueiro = false;
    }
    else if (animal == 0 and barqueiro == false){
        barqueiro = true;
    }
}

/* Confirma se o jogador perdeu ou ganhou o jogo */
bool situacaoJogador(int m1[], int m2[]){
    if (calculaMargem(m1)%2!= 0 and maisDeUmAnimalNaMargem(m1) and barqueiro == false){
        cout << " " << endl;
        cout << "                                      Ｐｅｒｄｅｕ ！        " << endl;
        return false;
    }
    if (calculaMargem(m2)%2!=0 and maisDeUmAnimalNaMargem(m2) and barqueiro == true){
        cout << " " << endl;
        cout << "                                      Ｐｅｒｄｅｕ ！        " << endl;
        return false;
    }
    if (calculaMargem(m2) == 6){
        cout << " " << endl;
        cout << "                             Ｇａｎｈｏｕ！ Ｐａｒａｂｅｎｓ ！        " << endl;
        return false;
    }
    return true;
}

/* A cada jogada fazer um copy */
void copyJogada(int m1[], int m2[], int m1copy[], int m2copy[]){
    for (int i = 0; i < 3; i++){
        m1copy[i] = m1[i];
        m2copy[i] = m2[i];
    }
}

/* Desfazer jogada a partir do copy */
void desfazerJogada(int m1[], int m2[], int m1copy[], int m2copy[], bool barco){
    for (int i = 0; i < 3; i++){
        m1[i] = m1copy[i];
        m2[i] = m2copy[i]; 
    }

    if (barco == false){
        barqueiro = true;
    }
    else if (barco == true){
        barqueiro = false;
    }
}

/* Representacao visual das margens do rio em cada situacao */
void vizualizaMargens(){
    cout << "" << endl;
    cout <<  "                                   Ｔｒａｖｅｓｓｉａ"  << endl;
    cout << "" << endl;
    
    if (barqueiro == true){
        cout << " 0- Barqueiro -->		        ░🛶	 	        ░       " << endl;
    }
    else{
        cout << " 0- Barqueiro -->		        ░ 	 	     🛶 ░       " << endl;
    }

    // Verifica lado galinha
    if (verificaMargem(margem1,galinha)){
        cout << " 1- Galinha   -->		     🐥 ░                       ░       " << endl;
    }
    else{
        cout << " 1- Galinha   -->		        ░                       ░🐥       " << endl;
    }

    //Verifica lado Raposa
    if (verificaMargem(margem1,raposa)){
        cout << " 2- Raposa    -->		     🦊 ░                       ░       " << endl;
    }
    else{
        cout << " 2- Raposa    -->		        ░                       ░🦊       " << endl;
    }

    // Verifica lado Cachorro
    if (verificaMargem(margem1,cachorro)){
        cout << " 3- Cachorro  -->		     🐶 ░                       ░       " << endl;
    }
    else{
        cout << " 3- Cachorro  -->		        ░                       ░🐶       " << endl;
    }
}

/* Metodo para que o jogo mostre a solucao */
void solucao(){
    //TODO
}

/* Main onde será feito o menu interativo */
int main(){

    //Regras e Inicializacao
    cout << "BEM VINDO A TRAVESSIA!" << endl;
    cout << "" << endl;
    cout << "Nesse jogo o barqueiro deve atravessar os 3 animais sem conflitos ;)" << endl;
    
    cout << "" << endl;
    
    cout << "As regras sao simples:" << endl;
    cout << "1° - Existe espaço para apenas 2 no barco, apenas um animal pode ser atravessado por vez" << endl;
    cout << "2° - O barqueiro pode atravessar o rio sozinho (ele esta sempre no barco)" << endl;
    cout << "4° - Raposa e galinha não podem ficar juntas e sozinhas porque a raposa irá atacar a galinha." << endl;
    cout << "5° - O cachorro e a raposa não podem ficar juntos e sozinhos porque o cachorro irá atacar a raposa." << endl;
    cout << "6° - As outras combinações de animais não apresentam o problema de um atacar o outro." << endl;
    cout << "" << endl;
    vizualizaMargens();

   while(situacaoJogador(margem1,margem2)){

    cout << "";
    cout << "Digite o Numero para Mover: " << endl;
    cin >> opcao;
    travessia(margem1,margem2, opcao);
    vizualizaMargens();

   }

}
