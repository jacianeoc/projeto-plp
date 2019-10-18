--Cada margem é uma quadrupla (galinha,raposa,cachorro,barqueiro)
data Margem = Quadruple Int Int Int Int deriving(Show,Eq)

situacaoDoJogador :: Margem -> Margem -> Bool
situacaoDoJogador m1 m2 
	|m1 == (Quadruple 0 2 3 0) || m2 == (Quadruple 0 2 3 0) = False --perdeu
	|m1 == (Quadruple 1 2 0 0) || m2 == (Quadruple 1 2 0 0) = False --perdeu
	|otherwise = True

fazerJogada :: Margem -> Margem ->Int-> (Margem,Margem)
fazerJogada (Quadruple a b c 4) (Quadruple e f g 0) opcao
	|opcao == 1 && first(Quadruple a b c 4) == 1 = ((Quadruple 0 b c 0 ), (Quadruple 1 f g 4))
	|opcao == 2 && second(Quadruple a b c 4) == 2 = ((Quadruple a 0 c 0 ), (Quadruple e 2 g 4))
	|opcao == 3 && third(Quadruple a b c 4) == 3 = ((Quadruple a b 0 0 ), (Quadruple e f 3 4))
	|opcao == 4 = ((Quadruple a b c 0 ), (Quadruple e f g 4))
	|otherwise = ((Quadruple a b c 4), (Quadruple e f g 0))
fazerJogada (Quadruple a b c 0) (Quadruple e f g 4) opcao
	|opcao == 1 && first(Quadruple e f g 4) == 1= ((Quadruple 1 b c 4 ), (Quadruple 0 f g 0))
	|opcao == 2 && second(Quadruple e f g 4) == 2 = ((Quadruple a 2 c 4 ), (Quadruple e 0 g 0))
	|opcao == 3 && third(Quadruple e f g 4) == 3 = ((Quadruple a b 3 4 ), (Quadruple e f 0 0))
	|opcao == 4 = ((Quadruple a b c 4 ), (Quadruple e f g 0))
	|otherwise = ((Quadruple a b c 0), (Quadruple e f g 4))

first :: Margem -> Int
first (Quadruple a b c d) = a

second :: Margem -> Int
second (Quadruple a b c d) = b

third :: Margem -> Int
third (Quadruple a b c d) = c

fourth :: Margem -> Int
fourth (Quadruple a b c d) = d

--Imprime as duas margens baseado na margem1
visualizaMargens::Margem -> IO()
visualizaMargens m1 = do
	putStrLn ""
	putStrLn "                                   Ｔｒａｖｅｓｓｉａ" 
	if (first m1) == 1 then putStrLn " 1- Galinha   -->       🐥░                       ░       "
	else putStrLn " 1- Galinha   -->         ░                       ░🐥       "
	if (second m1) == 2 then putStrLn " 2- Raposa   -->       🐺 ░                       ░       "
	else putStrLn " 2- Raposa    -->         ░                       ░🐺       "
	if (third m1) == 3 then putStrLn " 3- Cachorro   -->     🐶 ░                       ░       " 
	else putStrLn " 3- Cachorro  -->         ░                       ░🐶       "
	if (fourth m1) == 4 then putStrLn " 4- Barqueiro   -->       ░⛵                     ░       "
	else putStrLn " 4- Barqueiro -->         ░                     ⛵░       " 
	
desfazerJogada :: (Margem,Margem) -> (Margem,Margem) -> String -> (Margem,Margem)
desfazerJogada a b op 
	|op == "s" = a
	|otherwise = b
	
mostrarSolucao :: String -> IO()
mostrarSolucao "s" = do
	putStrLn "                             S O L U Ç Ã O "
	putStrLn ""
	putStrLn "Passo 1- Atravessar a raposa para a outra margem (margem2)"
	putStrLn "Passo 2- Fazer o barqueiro voltar para a margem de partida (margem1)"
	putStrLn "Passo 3- Levar o cachoro para a margem2"
	putStrLn "Passo 4- Trazer a raposa para a margem1, já que a raposa não pode ficar \n com cachorro sem a presença do barqueiro"
	putStrLn "Passo 5- Levar a galinha para a margem2, para não ficar junto com a raposa"
	putStrLn "Passo 6- O barqueiro volta para a margem1"
	putStrLn "Passo 7- O barqueiro leva a raposa, fim !!!!!"

mostrarSolucao _ = putStrLn ""

--Função principal (funciona como while)
iniciar :: Margem -> Margem -> Bool-> Bool -> IO()
iniciar _ _ False _ = do
	putStrLn "                                      Ｐｅｒｄｅｕ ！        "
	putStrLn ""
	putStrLn "Mostrar solução? [s/n]"
	opcao <- getLine
	mostrarSolucao opcao
iniciar _ _ _ True =  do putStrLn "                             Ｇａｎｈｏｕ！ Ｐａｒａｂｅｎｓ ！        "
iniciar m1 m2 situacao ganhou = do
	visualizaMargens m1
	putStrLn ""
	putStrLn "Digite o Numero para Mover: "
	opcao <-readLn::IO Int

	let r = fazerJogada m1 m2 opcao
	visualizaMargens (fst r)
	if (m1==(fst r) && m2==(snd r)) then do
		putStrLn ""
		putStrLn "Animal selecionado nao se encontra nessa margem"
		iniciar (fst r) (snd r) (situacaoDoJogador (fst r) (snd r)) False
	else do putStrLn "" 
		putStrLn "Desfazer Jogada? [s/n] "
		opcao <- getLine
		let d = desfazerJogada (m1,m2) r opcao
		let m = snd d
		if m == (Quadruple 1 2 3 4) then 
			iniciar (fst d) (snd d) (situacaoDoJogador (fst d) (snd d)) True
			
		else 
			iniciar (fst d) (snd d) (situacaoDoJogador (fst d) (snd d)) False
main = do
	putStrLn "BEM VINDO A TRAVESSIA!"
	putStrLn ""
	putStrLn "Nesse jogo o barqueiro deve atravessar os 3 animais sem conflitos ;)"
	putStrLn ""
	putStrLn "As regras sao simples:"
	putStrLn "1° - Existe espaço para apenas 2 no barco, apenas um animal pode ser atravessado por vez"
	putStrLn "2° - O barqueiro pode atravessar o rio sozinho (ele esta sempre no barco)"
	putStrLn "3° - Raposa e galinha não podem ficar juntas e sozinhas porque a raposa irá atacar a galinha."
	putStrLn "4° - O cachorro e a raposa não podem ficar juntos e sozinhos porque o cachorro irá atacar a raposa."
	putStrLn "5° - As outras combinações de animais não apresentam o problema de um atacar o outro."
	putStrLn ""
	
	iniciar (Quadruple 1 2 3 4) (Quadruple 0 0 0 0) (situacaoDoJogador (Quadruple 1 2 3 4) (Quadruple 0 0 0 0)) (False) --Bool identifica se o jogador ganhou ou nao)
