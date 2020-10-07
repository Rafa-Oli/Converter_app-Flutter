import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?key=c9ed277d';
void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.deepOrange, primaryColor: Colors.white),
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
  double dolar;
  double euro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra acima
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.deepOrangeAccent,
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
                style:
                    TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar Dados :(",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.deepOrange),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dólares",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            border: OutlineInputBorder(),
                            prefixText: "€\$"),
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
