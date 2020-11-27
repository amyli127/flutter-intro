import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI/UX Studio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'UI/UX Studio'),
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
    String _joke = "";
    String _imgUrl = "";


  String jokeAPICall = "https://sv443.net/jokeapi/v2/joke/Any";
  String imgAPICall = "https://dog.ceo/api/breeds/image/random";

    void _generateJoke() async {
        final res = await http.get(jokeAPICall);
        var response = convert.jsonDecode(res.body);
        setState(() {
            _joke = (response["type"] == "twopart") ? (response["setup"] + '\n' + response["delivery"]) : response["joke"];
        });
    }

    void _generateImg() async {
        final res = await http.get(imgAPICall);
        var response = convert.jsonDecode(res.body);
        setState(() {
            _imgUrl = response["message"];
        });
    }

    void _generateAll() {
        _generateJoke();
        _generateImg();
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_joke',
            ),
            Image(
              image: NetworkImage(_imgUrl),  
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateAll,
        tooltip: 'Generate',
        child: Icon(Icons.autorenew),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
