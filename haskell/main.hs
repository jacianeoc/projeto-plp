--definição das constantes
barqueiro :: Int
	barqueiro = 0
galinha :: Int
	galinha = 1
raposa :: Int
	raposa = 2
cachorro ::Int
	cachorro = 3

situacaoDoJogador :: [Int]->[Int]->Bool
situacaoDoJogador margem1 margem2
	| margem1==[0,raposa,cachorro] || margem2==[0,raposa,cachorro] = False -- perdeu
	| margem1==[galinha,raposa,0] || margem2==[galinha,raposa,0] = False --perdeu
	|otherwise = True --Ainda jogando 

ganhou :: [Int]->Bool
ganhou margem2 
	|margem2 == [1,2,3] = True
	|otherwise = False

-- Essa implementção aí não tá ideal pra função de iniciar, mas é um começo
iniciar ([Int]->[Int]=>Bool)->([Int]=>Bool)->IO()
iniciar situacao ganhou = 
		if situacao == True && ganhou == False then =
		else if situacao == False && ganhou == False then = putStrLn "Perdeu!"
		else = putStrLn "Perdeu!"

main = do
	iniciar (situacaoDoJogador [1,2,3] [0,0,0]) (ganhou [0,0,0])
