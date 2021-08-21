import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/casa/casa.dart';
import '../../entities/cobras_escadas/cobras_escadas.dart';
import 'widgets/card_casa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void listenerAlertaDeCobra() {
    if (context.read<CobrasEscadas>().mostrarAlertaDeCobra) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final ultimoJogador = context.read<CobrasEscadas>().ultimoJogador == 1
              ? context.read<CobrasEscadas>().jogador1
              : context.read<CobrasEscadas>().jogador2;
          return AlertDialog(
            title: Text("Que pena!"),
            content: Text(
              "Você caiu numa casa que tem uma cabeça de cobra! "
              "Retorne até a cauda dela na casa ${ultimoJogador.posicao}!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<CobrasEscadas>().mostrarAlertaDeCobra = false;
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void listenerAlertaDeEscada() {
    if (context.read<CobrasEscadas>().mostrarAlertaDeEscada) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final ultimoJogador = context.read<CobrasEscadas>().jogadorAtual == 1
              ? context.read<CobrasEscadas>().jogador2
              : context.read<CobrasEscadas>().jogador1;
          return AlertDialog(
            title: Text("Uhul!"),
            content: Text(
              "Você caiu numa casa que tem a base de uma escada! "
              "Você vai subir até o topo dela na casa ${ultimoJogador.posicao}!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<CobrasEscadas>().mostrarAlertaDeEscada = false;
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    context.read<CobrasEscadas>()
      ..addListener(listenerAlertaDeCobra)
      ..addListener(listenerAlertaDeEscada);
    super.initState();
  }

  final lista = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    final larguraDaTela = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => Text(
                  provider.jogoFinalizado
                      ? "O jogo acabou!"
                      : "Vez do jogador ${provider.jogadorAtual}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => Text(
                  provider.mensagemDados,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: larguraDaTela * 0.025,
                ),
                height: larguraDaTela * 0.95,
                width: larguraDaTela * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.up,
                  children: lista.map(
                    (numeroDaLinha) {
                      return Expanded(
                        child: Row(
                          children: numeroDaLinha % 2 == 0
                              ? mapListToTile(numeroDaLinha, lista)
                              : mapListToTile(
                                  numeroDaLinha, lista.reversed.toList()),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: Consumer<CobrasEscadas>(
                  builder: (context, provider, _) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadowColor: Colors.blue.withOpacity(0.5),
                      elevation: 5,
                    ),
                    onPressed: provider.jogadaEmAndamento
                        ? null
                        : () {
                            if (provider.jogoFinalizado) {
                              provider.reiniciar();
                            } else {
                              provider.botaoJogarPressionado();
                            }
                          },
                    child:
                        Text(provider.jogoFinalizado ? "Reiniciar" : "Jogar"),
                  ),
                ),
              ),
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => Text(
                  provider.jogoFinalizado ? '' : provider.mensagem,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Legenda:",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "BE: base de escada",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "TE: topo de escada",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "RC: cauda de cobra",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "CC: cabeça de cobra",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        color: Colors.black,
                      ),
                      Text(
                        " : posição do jogador 1",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      Text(
                        " : posição do jogador 2",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Consumer<CobrasEscadas>> mapListToTile(
    int numeroDaLinha,
    List<int> lista,
  ) {
    return lista.map(
      (numeroDaColuna) {
        return Consumer<CobrasEscadas>(
          builder: (context, provider, _) {
            final numeroDaCasa = (10 * numeroDaLinha) + numeroDaColuna + 1;
            return CardDeCasa(
              casa: Casa(
                numeroDaCasa: "$numeroDaCasa",
                haTopoDeEscada: provider.escadas
                    .any((escada) => escada.topo == numeroDaCasa),
                haBaseDeEscada: provider.escadas
                    .any((escada) => escada.base == numeroDaCasa),
                haCabecaDeCobra: provider.cobras
                    .any((cobra) => cobra.cabeca == numeroDaCasa),
                haCaudaDeCobra:
                    provider.cobras.any((cobra) => cobra.cauda == numeroDaCasa),
                jogador1EstaNaCasa: provider.jogador1.posicao == numeroDaCasa,
                jogador2EstaNaCasa: provider.jogador2.posicao == numeroDaCasa,
                corDaCasa: provider.cores[numeroDaCasa - 1],
              ),
            );
          },
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    context.read<CobrasEscadas>()
      ..removeListener(listenerAlertaDeCobra)
      ..removeListener(listenerAlertaDeEscada);
    super.dispose();
  }
}
