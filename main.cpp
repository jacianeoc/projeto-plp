
#include <iostream>
#include <vector>

using namespace std;

/** OPCAO DE DESFAZER JOGADA NAO IMPLEMETADA - USAR IDEA DE MANTER COPY DOS ARRAYS(SE QUISER) **/


/* Animais da ao serem atravessados pelo rio */
int const galinha = 1;
int const raposa = 2;
int const cachorro = 3;

/* Opcao selecionada*/
int opcao;

/* Copias para refazer jogada */
int margem1copy[3] = {galinha,raposa,cachorro};
int margem2copy[3] = {};


/* Copias temporarias da jogada */
int temp1margem[3] = {};
int temp2margem[3] = {};

/*True = Margem 1 and False = Margem 2*/ 
bool barqueiro = true;

/* Vê se o jogador perdeu ou não(para perguntar se ele quer ver a solução)*/
bool ganhou = false;

/* True = o while do main funciona; False= não funciona*/
bool jogando = true;

/* Margens do Rio */
int margem1[3] = {galinha,raposa,cachorro};
int margem2[3] = {};

/* Boolean para verificar se existe mais de um animal na margem */
bool maisDeUmAnimalNaMargem(int m[]){
    int animais = 0;
    for(int i = 0; i < 3; i++){
		if(m[i]>0){
			animais++;
		}
	}
	if(animais<=1){
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
    if(m[animal-1]!=0){
		return true;
	}else{
		return false;
	}
}
/* colocando temporariamente o que teve na jogada em arrays terceiros */
void tempMargem(int margem1[], int margem2[], int temp1margem[], int temp2margem[]){

    for (int i = 0; i < 3; i++){
        temp1margem[i] = margem1[i];
        temp2margem[i] = margem2[i];
    }

}

/* A cada jogada fazer um copy atraves dos array temporarios*/
void copyJogada(int temp1margem[], int temp2margem[], int margem1copy[], int margem2copy[]){

    for (int i = 0; i < 3; i++){
        margem1copy[i] = temp1margem[i];
        margem2copy[i] = temp2margem[i];
    }

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
        ganhou = true;
        return false;
    }
    return true;
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


/* Desfazer jogada a partir do copy */
void desfazerJogada(int margem1[], int margem2[], int margem1copy[], int margem2copy[]){

    for (int i = 0; i < 3; i++){
        margem1[i] = margem1copy[i];
        margem2[i] = margem2copy[i];
    }

    travessia(margem1, margem2, 0);
    vizualizaMargens();
}

void solucao() {

    margem1[0] = galinha;
    margem1[1] = raposa;
    margem1[2] = cachorro;

    margem2[3] = {};

    if (barqueiro == false){
        barqueiro = true;
    }
    string passos[] = {"Passo 1- Atravessar a raposa para a outra margem (margem2)",
                       "Passo 2- Fazer o barqueiro voltar para a margem de partida (margem1)",
                       "Passo 3- Levar o cachoro para a margem2",
                       "Passo 4- Trazer a raposa para a margem1, já que a raposa não pode ficar \n com cachorro sem a presença do barqueiro",
                       "Passo 5- Levar a galinha para a margem2, para não ficar junto com a raposa",
                       "Passo 6- O barqueiro volta para a margem1",
                       "Passo 7- O barqueiro leva a raposa, fim !!!!!"};
    int opcaoSolucao[7] = {2,0,3,2,1,0,2};
    for (int i = 0; i < 7; ++i) {
        travessia(margem1, margem2, opcaoSolucao[i]);
        vizualizaMargens();
        cout << "" << endl;
        cout << "***************************" << endl;
        cout << passos[i] << endl;
        cout << "***************************" << endl;

    }
}
/*metodo responsavel por imprimir a solução somente se o jogador perder */


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
	

   while(jogando){

    cout << "";
    cout << "Digite o Numero para Mover: " << endl;
    cin >> opcao;
    travessia(margem1,margem2, opcao);
    vizualizaMargens();
    tempMargem(margem1, margem2, temp1margem, temp2margem);

    char op;
    cout << "" << endl;
    cout << "Desfazer jogada? [s/n]" << endl;
    cin >> op;
    if (op == 's') {
        desfazerJogada(margem1, margem2, margem1copy, margem2copy);
    }
    if(situacaoJogador(margem1, margem2) == false){
	char op2;
	if(!ganhou){
		cout << "" << endl;
		cout << "Você perdeu o jogo, deseja que o computador faça a solução? [s/n]" << endl;
		cin >> op2;
		if (op2 == 's') {
			solucao();
		}
	}
        cout << "" << endl;
        cout << "Jogar novamente? [s/n]" << endl;
        cin >> op2;
       if(op2 == 's'){
            jogando = true;
            ganhou = false;
            barqueiro = true;
            margem1[0] = galinha;
            margem1[1] = raposa;
            margem1[2] = cachorro;
            temp1margem[0] = galinha;
            temp1margem[1] = raposa;
            temp1margem[2] = cachorro;
            temp2margem[0] = 0;
            temp2margem[1] = 0;
            temp2margem[2] = 0;

            copyJogada(temp1margem, temp2margem, margem1copy, margem2copy);
            vizualizaMargens();
	    }else{ 
	        jogando = false;
	    }
   }

    copyJogada(temp1margem, temp2margem, margem1copy, margem2copy);
   }
}
