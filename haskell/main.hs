--definição das constantes
galinha :: Int
galinha = 1
raposa :: Int
raposa = 2
cachorro ::Int
cachorro = 3
barqueiro :: Int
barqueiro = 4
--Cada margem é uma quadrupla (galinha,raposa,cachorro,barqueiro)
data Margem = Quadruple Int Int Int Int deriving(show, eq)

situacaoDoJogador :: Margem -> Margem -> Bool
situacaoDoJogador m1 m2 =
	| m1==(Quadruple 0 raposa cachorro 0) || m2 == (Quadruple 0 raposa cachorro 0) = False --perdeu
	| m1==(Quadruple galinha raposa 0 0) || m2 == (Quadruple galinha raposa 0 0) = False --perdeu
	| otherwise = True --Ainda jogando 

ganhou :: Margem->Bool
ganhou  (Quadruple galinha,raposa,cachorro) = True
ganhou _ = False

fazerJogada :: Margem -> Margem ->Int-> (Margem,Margem)
fazerJogada (Quadruple a b c 4) (Quadruple e f g 0) opcao
	| opcao == 1 = ((Quadruple 0 b c 0 ), (Quadruple 1 f g 4))
	| opcao == 2 = ((Quadruple a 0 c 0 ), (Quadruple e 2 g 4))
	| opcao == 3 = ((Quadruple a b 0 0 ), (Quadruple e f 3 4))
	| opcao == 4 = ((Quadruple a b c 0 ), (Quadruple e f g 4))
	| otherwise = ((Quadruple a b c 4), (Quadruple e f g 0))
fazerJogada (Quadruple a b c 0) (Quadruple e f g 4) opcao
	| opcao == 1 = ((Quadruple 1 b c 4 ), (Quadruple 0 f g 0))
	| opcao == 2 = ((Quadruple a 2 c 4 ), (Quadruple e 0 g 0))
	| opcao == 3 = ((Quadruple a b 3 4 ), (Quadruple e f 0 0))
	| opcao == 4 = ((Quadruple a b c 4 ), (Quadruple e f g 0))
	| otherwise = ((Quadruple a b c 0), (Quadruple e f g 4))

visualizaMargens::Margem -> IO()
visualizaMargens m1 = do
	putStrLn ""
	putStrLn "                                   Ｔｒａｖｅｓｓｉａ" 
	if m1 == (Quadruple 1 _ _ _) then putStrLn " 1- Galinha   -->        🐥░                       ░       "
	else putStrLn " 1- Galinha   -->        ░                       ░🐥       "
	if m1 == (Quadruple _ 2 _ _) then putStrLn " 2- Raposa    -->       🦊 ░                       ░       "
	else putStrLn " 2- Raposa    -->       ░                       ░🦊       "
	if m1 == (Quadruple _ _ 3 _) then putStrLn " 3- Cachorro  -->       🐶 ░                       ░       " 
	else putStrLn " 3- Cachorro  -->        ░                       ░🐶       "
	if m1 == (Quadruple _ _ _ 4) then putStrLn " 4- Barqueiro -->          ░⛵                   ░       "
	else putStrLn " 4- Barqueiro -->        ░                     ⛵░       " 
	
desfazerJogada :: (Margem,Margem) -> (Margem,Margem) -> Char -> (Margem,Margem)
desfazerJogada a b opcao =
	|opcao=='s' = a
	|opcao=='n' = b
	|otherwise = b
	
mostrarSolucao :: Char -> IO()
mostrarSolucao 's' = do
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
	opcao <- getChar
	mostrarSolucao opcao
iniciar _ _ _ True =  putStrLn "                             Ｇａｎｈｏｕ！ Ｐａｒａｂｅｎｓ ！        "
iniciar m1 m2 situacao ganhou = do
	visualizaMargens m1
	putStrLn ""
	putStrLn "Digite o Numero para Mover: "
	opcao <-readLn::IO Int

	let r = fazerJogada m1 m2 opcao
	visualizaMargens (fst r)
	if (m1==(fst r) and m2==(snd r)) then 
		putStrLn ""
		putStrLn "Animal selecionado nao se encontra nessa margem"
		iniciar (fst r) (snd r) (situacaoDoJogador (fst r) (snd r)) (ganhou (snd r))
	else putStrLn "" 
		putStrLn "Desfazer Jogada? [s/n] "
		opcao <- getChar
		let d = desfazerJogada (m1,m2) r opcao
		iniciar (fst d) (snd d) (situacaoDoJogador (fst d) (snd d)) (ganhou (snd r))
		
	-- Essa chamada recursiva aqui em baixo acho que não precisava, 
	-- mas deixei comentada por garantia. Colei ela no primeiro if
      --iniciar (fst r) (snd r) (situacaoDoJogador (fst r) (snd r)) (ganhou (snd r))

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
	
	iniciar (Quadruple 1 2 3 4) (Quadruple 0 0 0 0) (situacaoDoJogador (Quadruple 1 2 3 4)) (Quadruple 0 0 0 0)) (ganhou (Quadruple 0 0 0 0))

