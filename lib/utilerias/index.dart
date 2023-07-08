import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/config.dart';
import 'botonera.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  EstadosCelda estadoInicial = EstadosCelda.cross;
  int contadorCruz = 0;
  int contadorCirculo = 0;

  void incrementarContador(EstadosCelda ganador) {
    setState(() {
      if (ganador == EstadosCelda.cross) {
        contadorCruz++;
      } else if (ganador == EstadosCelda.circle) {
        contadorCirculo++;
      }
    });
  }

  void reiniciarJuego() {
    // Restablecer el estado del juego
    estados = List.filled(9, EstadosCelda.empty);
    estadoInicial = EstadosCelda.cross;
    resultado = {
      EstadosCelda.circle: false,
      EstadosCelda.cross: false,
    };

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juego del Gato"),
        actions: [
          Text("Cruz: $contadorCruz"),
          Text("Círculo: $contadorCirculo"),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Reiniciar") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Reiniciar"),
                      content: const Text("¿Deseas reiniciar el juego?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            reiniciarJuego();
                          },
                          child: const Text("Sí"),
                        ),
                        TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              } else if (value == "Salir") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Salir"),
                      content: const Text("¿Deseas salir del juego?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Sí"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: "Reiniciar",
                  child: Text("Reiniciar"),
                ),
                const PopupMenuItem<String>(
                  value: "Salir",
                  child: Text("Salir"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset('imagenes/board.png'),
            Botonera(
              onGanador: incrementarContador,
            ),
          ],
        ),
      ),
    );
  }
}
