import 'dart:convert';

import 'package:clima/components/Label.dart';
import 'package:clima/models/Clima.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Clima e Tempo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Clima _clima;
  bool _isNotNull = false;

  @override
  initState() {
    super.initState();
    
    _clima = Clima();

    getClima();
  }

  getClima() async {
    String url = "https://api.hgbrasil.com/weather?key=465739c4&city_name=Contagem,MG";

    Response response = await get(url);
    Map clima = json.decode(response.body);

    if (!clima["error"]) {
      this._clima.temperatura = clima["results"]["temp"];
      this._clima.cidade = clima["results"]["city"];
      this._clima.descricao = clima["results"]["description"];
      this._clima.umidade = clima["results"]["humidity"];
      this._clima.nascerSol = clima["results"]["sunrise"];
      this._clima.porSol = clima["results"]["sunset"];

      _isNotNull = true;
    } else {
      String url = "https://api.hgbrasil.com/weather?woeid=455821";

      Response response = await get(url);
      clima = json.decode(response.body);

      this._clima.temperatura = clima["results"]["temp"];
      this._clima.cidade = clima["results"]["city"];
      this._clima.descricao = clima["results"]["description"];
      this._clima.umidade = clima["results"]["humidity"];
      this._clima.nascerSol = clima["results"]["sunrise"];
      this._clima.porSol = clima["results"]["sunset"];

      _isNotNull = true;
    }

    setState(() {
      _clima;
      _isNotNull;
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: "Search",
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Image(image: AssetImage("lib/assets/images/img_clima.png")),
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: _isNotNull ? 2 : 3,
            child: _isNotNull ? 
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Label.large(_clima.temperatura.toString() + "°"),
                color: Colors.blue,
              )
            :
              Container (
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Label.medium("Buscando por dados..."),
                color: Colors.blue,
              )
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: _isNotNull ? 
                    <TextSpan> [
                      Label.smallTextSpan(_clima.cidade + ". "),
                      Label.smallTextSpan(_clima.descricao + "\n"),
                      Label.smallTextSpan("Umidade: " + _clima.umidade.toString() + " kg/m³"),
                      Label.smallTextSpan("Nascer do sol: " + _clima.nascerSol),
                      Label.smallTextSpan("Por do sol: " + _clima.porSol),                                   
                    ]
                  :
                    null
                ),
              ),
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
