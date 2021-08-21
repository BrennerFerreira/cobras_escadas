# Cobras e Escadas

Jogo desenvolvido como parte do teste técnico da vaga de Desenvolvedor Mobile
Flutter da Escribo Inovação.

## Como rodar

Para rodar o jogo, basta seguir as seguintes instruções:

- Faça um clone deste repositório.
- Rode o comando `flutter packages get` na pasta onde o jogo foi clonado.
- Tenha um dispositivo físico ou um emulador preparado.
- Rode o comando `flutter run lib/main.dart`.

## Sobre o jogo

- Existem dois jogadores e ambos começam fora do tabuleiro.
- O jogador 1 começa e alterna sua vez com o jogador 2.
- Um jogador deve jogar dois dados e somar sua posição atual ao valor da
soma dos dados sempre em ordem crescente, do 1 até o 100.
- Caso o valor de ambos os dados seja igual, o jogador atual ganha uma nova
jogada.
- Caso um jogador pare em uma casa que é a base de uma escada, ele
obrigatoriamente deve subir até a casa em que está o topo da escada.
- Caso um jogador pare em uma casa em que está localizada a cabeça de
uma cobra, ele vai obrigatoriamente deve descer até o casa onde está a
ponta da cauda da cobra.
- Um jogador deve cair exatamente na última casa (100) para vencer o jogo.
O primeiro jogador a fazer isso, vence. Mas se o somatório dos dados com a
casa atual for maior que 100, o jogador deve se movimentar para trás até a
contagem terminar, como se ele tivesse batido em uma parede e retornasse.
- Se um jogador tirar dados iguais e chegar exatamente na casa 100 sem
movimentos restantes, então o jogador vence o jogo e não precisa jogar
novamente.

## Sobre o desenvolvimento

O único pacote externo utilizado foi o [https://pub.dev/packages/provider](Provider)
para facilitar a gerência da aplicação.

O único `provider` que temos é a classe CobrasEscadas que gerencia todos os
eventos do jogo.

## Desafios

O maior desafio encontrado foi conseguir desenvolver o jogo inteiro em cerca de
36 horas, prazo estipulado para a entrega do resultado. Por conta deste prazo,
foi definido o principal foco de desenvolver um MVP do jogo, deixando de lado
alguns pontos que podem ser melhorados no futuro, como:

- Desenhos das cobras e escadas para melhorar a experiência do usuário.
- Testes automatizados das classes.

Estes pontos podem ser melhorados com o desenvolvimento contínuo do programa.
