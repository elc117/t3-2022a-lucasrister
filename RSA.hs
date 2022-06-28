--Identifica se um valor é primo gerando uma lista de valores em que o resto da divisão é igual a 0. Se esta lista conter apenas 1 e o proprio valor retorna o valor bool True

prime :: Integer -> Bool
prime n = if [i | i<-[1..n], n `mod` i == 0] == [1,n] then True else False

--Retorna uma lista com todos os valores que retornam resto zero para "a" e "b". O Ultimo elemento desta lista sera o maior divisor comum visto que a lista é gerada e destada em ordem crescente

mdc :: Integer -> Integer -> Integer
mdc a b = last [ x | x <- [1..a], mod a x == 0, mod b x == 0]

--Calcula o valor de n para o calculo da criptografica

nValue :: Integer -> Integer -> Integer
nValue p q = p * q

--Função responsavel por gerar a chave privada: e*d % ((p-1)*(q-1)) = 1

privateKey :: Integer -> Integer -> Integer 
privateKey p q = head [ x | x <- [1,2..(p*q)], (publicKey p q * x) `mod` ((p - 1) * (q - 1)) == 1]

--Função responsavel por gerar a chave publica: selecionar qualquer valor para "e" tal que mdc( e, ((p-1)*(q-1)) ) == 1 preferencialmente impar

publicKey  :: Integer -> Integer -> Integer
publicKey p q = head [x | x <- [2,3..((p - 1) * (q - 1))], mdc x ((p - 1) * (q - 1)) == 1, odd x] 

--Função de criptografia: c = m ^ e mod n

crypt :: Integer -> Integer -> Integer -> Integer
crypt m e n =  m ^ e `mod` n

--Função de descriptografia: m = c ^ d mod n

decrypt :: Integer -> Integer -> Integer -> Integer
decrypt  c d n =  c ^ d `mod` n