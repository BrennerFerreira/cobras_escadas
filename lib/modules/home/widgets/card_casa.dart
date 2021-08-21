import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/cobras_escadas/cobras_escadas.dart';
import '../../../entities/casa/casa.dart';

class CardDeCasa extends StatelessWidget {
  final Casa casa;
  const CardDeCasa({Key? key, required this.casa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? indiceDeCobra;
    int? indiceDeEscada;
    if (casa.haCabecaDeCobra || casa.haCaudaDeCobra) {
      indiceDeCobra = context.read<CobrasEscadas>().cobras.indexWhere(
                (cobra) =>
                    cobra.cabeca == int.tryParse(casa.numeroDaCasa) ||
                    cobra.cauda == int.tryParse(casa.numeroDaCasa),
              ) +
          1;
    }

    if (casa.haTopoDeEscada || casa.haBaseDeEscada) {
      indiceDeEscada = context.read<CobrasEscadas>().escadas.indexWhere(
                (escada) =>
                    escada.topo == int.tryParse(casa.numeroDaCasa) ||
                    escada.base == int.tryParse(casa.numeroDaCasa),
              ) +
          1;
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.25,
          ),
          color: casa.corDaCasa.withOpacity(0.4),
        ),
        child: Stack(
          children: [
            if (casa.numeroDaCasa == "1")
              Center(
                child: Icon(
                  Icons.arrow_right_alt,
                  color: Colors.black.withOpacity(0.5),
                  size: 30,
                ),
              ),
            if (casa.numeroDaCasa == "100")
              Center(
                child: Icon(
                  Icons.home,
                  color: Colors.black.withOpacity(0.5),
                  size: 30,
                ),
              ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        casa.numeroDaCasa,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      if (casa.haTopoDeEscada)
                        Text(
                          "TE$indiceDeEscada",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (casa.haBaseDeEscada)
                        Text(
                          "BE$indiceDeEscada",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (casa.haCabecaDeCobra)
                        Text(
                          "CC$indiceDeCobra",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (casa.haCaudaDeCobra)
                        Text(
                          "RC$indiceDeCobra",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: casa.jogador1EstaNaCasa ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.black,
                  ),
                ),
                AnimatedOpacity(
                  opacity: casa.jogador2EstaNaCasa ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
