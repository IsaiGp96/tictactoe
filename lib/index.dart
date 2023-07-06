import 'package:flutter/material.dart';
import 'package:flutter_tictactoe/botonera.dart';
import 'config/config.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  EstadosCelda estadoInicial = EstadosCelda.cross;
  final Botonera botonera = const Botonera();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Botonera"),
        actions: [
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
                            estados = List.filled(9, EstadosCelda.empty);
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
            const Botonera(),
          ],
        ),
      ),
    );
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
}
