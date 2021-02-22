import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:morale_adjustment_flutter_app/smiley_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Morale Adjustment'),
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
  double _rating = 5.0;
  String _currentAnimation = "5+";
  SmileyController _smileyController = SmileyController();

  void _onChanged(double value) {
    if (_rating == value) {
      return;
    }
    setState(() {
      var direction = _rating < value ? "+" : "-";
      _rating = value;
      _currentAnimation = "${value.round()}$direction";
    });
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
            Container(
              height: 300.0,
              width: 300.0,
              child: FlareActor(
                "assets/happiness_emoji.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                controller: _smileyController,
                animation: _currentAnimation,
              ),
            ),
            Slider(
                value: _rating,
                max: 5,
                min: 1,
                divisions: 4,
                onChanged: _onChanged),
            Text(
              '$_rating',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
