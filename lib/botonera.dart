import 'package:flutter/material.dart';

import 'config/config.dart';
import 'widgets/celda.dart';

class Botonera extends StatefulWidget {
  const Botonera({super.key});

  @override
  State<Botonera> createState() => BotoneraState();

  void reiniciarJuego() {}
}

class BotoneraState extends State<Botonera> {
  double ancho = 0;
  double dimension = 0;
  EstadosCelda estadoInicial = EstadosCelda.cross;

  void onPress(int index) {
    debugPrint("Clicked: $index");
    if (estados[index] == EstadosCelda.empty) {
      setState(() {
        estados[index] = estadoInicial;
      });
      estadoInicial = estadoInicial == EstadosCelda.cross
          ? EstadosCelda.circle
          : EstadosCelda.cross;

      //Verificar si alguien gano
      EstadosCelda ganador = buscarGanador();

      if (ganador == EstadosCelda.empty) {
        debugPrint("Nadie gano");
      } else if (buscarGanador() == EstadosCelda.empty) {
        debugPrint("¡Es un empate!");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("¡Juego empatado!"),
                content: const Text("¡Que venga la revancha!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      reiniciarJuego();
                    },
                    child: const Text("Reiniciar"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Salir"))
                ],
              );
            });
      } else {
        debugPrint("Gano el $ganador");

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Felicidades"),
                content: Text("Gano el $ganador"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      reiniciarJuego();
                    },
                    child: const Text("Reiniciar"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Salir"))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size.width; //Ancho de la pantalla
    ancho = dimension / 3;

    return Builder(builder: (context) {
      return SizedBox(
        width: dimension,
        height: dimension,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[0],
                  callback: () => onPress(0),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[1],
                  callback: () => onPress(1),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[2],
                  callback: () => onPress(2),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[3],
                  callback: () => onPress(3),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[4],
                  callback: () => onPress(4),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[5],
                  callback: () => onPress(5),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[6],
                  callback: () => onPress(6),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[7],
                  callback: () => onPress(7),
                ),
                Celda(
                  ancho: ancho,
                  alto: ancho,
                  estado: estados[8],
                  callback: () => onPress(8),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  EstadosCelda buscarGanador() {
    for (int i = 0; i < estados.length; i += 3) {
      sonIguales(i, i + 1, i + 2);
    }

    for (int i = 0; i < 3; i++) {
      sonIguales(i, i + 3, i + 6);
    }

    sonIguales(0, 4, 8);
    sonIguales(2, 4, 6);
    if (resultado[EstadosCelda.circle] == true) {
      return EstadosCelda.circle;
    }

    if (resultado[EstadosCelda.cross] == true) {
      return EstadosCelda.cross;
    }

    return EstadosCelda.empty;
  }

  void reiniciarJuego() {
    // Restablecer el estado del juego
    setState(() {
      estados = List.filled(9, EstadosCelda.empty);
      estadoInicial = EstadosCelda.cross;
      resultado = {
        EstadosCelda.circle: false,
        EstadosCelda.cross: false,
      };
    });
  }

  void sonIguales(int a, int b, int c) {
    if (estados[a] != EstadosCelda.empty) {
      if (estados[a] == estados[b] && estados[b] == estados[c]) {
        resultado[estados[a]] = true;
      }
    }
  }
}
