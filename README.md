# Algoritmo RSA em Haskell

O algoritmo RSA (Rivest-Shamir-Adleman - criadores deste modelo) é um dos primeiros algoritmos de criptografia assimétrica muito utilizado para a transferência de informações de forma segura em canais de comunicação público.
Este algoritmo é composto por duas chaves sendo uma delas pública e a outra privada. Geradas a partir de dois números primos.
Ler mais em: https://pt.wikipedia.org/wiki/RSA_(sistema_criptogr%C3%A1fico)

O principal objetivo deste trabalho é implementar de forma simples o algoritmo RSA em Haskell para que desta forma seja possível comparar esta implementação com uma implementação anterior desenvolvida em Linguagem C de modo a evidenciar as diferenças entre os paradigmas de programação.

Como requisitos para a implementação deste algoritmo foi preciso desenvolver um função para identificar o MDC (máximo divisor comum) entre dois numeros

Haskell: 
```
  mdc :: Integer -> Integer -> Integer
  mdc a b = last [ x | x <- [1..a], mod a x == 0, mod b x == 0]
```
  
  Linguage C:
  
```
int MDC(int a, int b){
  int i, mdc;
  for(i=1; i <=a && i<=b;i++){
    mdc = i;
  }
  return mdc;
}

```

Uma função para calcular a chave publica:


Haskell: 
```
  publicKey  :: Integer -> Integer -> Integer
  publicKey p q = head [x | x <- [2,3..((p - 1) * (q - 1))], mdc x ((p - 1) * (q - 1)) == 1, odd x] 
```

Linguage C:
  
```
int phi = (p-1)*(q-1);
int e =0;
for(e=5; e <=100 ;e++){
  if(MDC(phi, e) == 1)
    break;
}

```

Uma função para calcular a chave privada:


Haskell: 
```
  privateKey :: Integer -> Integer -> Integer 
  privateKey p q = head [ x | x <- [1,2..(p*q)], (publicKey p q * x) `mod` ((p - 1) * (q - 1)) == 1]
```

Linguage C:
  
```
int d =0;
for(d=e+1; d <=100 ;d++){
  if((d*e) % phi == 1)
    break;
}

```

E as respectivas funções de cifra e descriptografia.

c = m ^ e mod n

decrypt = c ^ d mod n

Para a execução deste algoritmo o usuário precisa informar 2 números primos. Em caso de dúvida a função prime identifica se o número é primo ou não. 

```
prime :: Integer -> Bool
prime n = if [i | i<-[1..n], n `mod` i == 0] == [1,n] then True else False

```

Para cifrar uma mensagem o usuário precisa gerar o número “n” composto pelo produto dos número primos “p” e “q”  informados pelo usuário utilizando a função nValue.

```
nValue :: Integer -> Integer -> Integer
nValue p q = p * q

```

Em seguida o usuário precisa gerar a chave publica utilizando a função publicKey informando os números “p” e “q”


```
publicKey  :: Integer -> Integer -> Integer
publicKey p q = head [x | x <- [2,3..((p - 1) * (q - 1))], mdc x ((p - 1) * (q - 1)) == 1, odd x] 
```

E a chave privada com a função privateKey também informando os números “p” e “q”.

```
privateKey :: Integer -> Integer -> Integer 
privateKey p q = head [ x | x <- [1,2..(p*q)], (publicKey p q * x) `mod` ((p - 1) * (q - 1)) == 1]
```
Uma vez tendo o valor de “n” a chave publica e a chave privada. O usuário pode criptografar uma “mensagem” no formato de número. Utilizando a função crypter passando como parâmetro a mensagem a chave publica e o valor de n.

```
crypt :: Integer -> Integer -> Integer -> Integer
crypt m e n =  m ^ e `mod` n
```

Para de criptografar a mensagem o usuário utilizara a função decrypt passando como parâmetro a mensagem cifrada a chave privada e o valor de n.

```
decrypt :: Integer -> Integer -> Integer -> Integer
decrypt  c d n =  c ^ d `mod` n
```
EXEMPLO

![RSA](https://user-images.githubusercontent.com/48519383/176285379-a87cef1e-274f-454f-8348-4373da90f640.PNG)

Informando os valores 7 e 17 foi obtido um valor de n igual a 119.
Para a chave publica foi obtido o valor 5 e para a chave privada foi obtido o valor 77.
Ao criptografar, utilizando a chave privada 77, a mensagem representada pelo número 9 foi obtido o valor 25.
E utilizando a chave publica 5 é possível de criptografar a mensagem para o valor 9 novamente.

