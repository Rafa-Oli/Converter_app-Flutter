import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?key=c9ed277d';
void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(
      request); // resposta e solitação para o servidor, na qual n retorna o dados na hr
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra acima
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.indigo[900],
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: //não estiver conectando em nada
            case ConnectionState.waiting: // esta esperando dados
              return Center(
                  child: Text(
                "Carregando Dados...",
                style: TextStyle(color: Colors.indigo[900], fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar Dados :(",
                  style: TextStyle(color: Colors.indigo[900], fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                return Container(color: Colors.green);
              }
          }
        },
      ),
    );
  }
}
