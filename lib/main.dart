import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final body = new Center(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Text(
              "Metric Unit",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MyWidget(),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lean Body Mass Calculator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lab 1 - Lean Body Mass Calculator',
          ),
        ),
        body: body,
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _radioValue = 0;
  final TextEditingController _weightcontroller = new TextEditingController();
  final TextEditingController _heightcontroller = new TextEditingController();
  double weight = 0.0;
  double height = 0.0;
  double boerResult = 0.0;
  double jamesResult = 0.0;
  double humeResult = 0.0;
  String boerFormula, jamesFormula, humeFormula;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              children: [
                Text(
                  "Gender: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("Male"),
                SizedBox(
                  width: 30.0,
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("Female"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _heightcontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Height (cm)',
                      filled: true,
                      fillColor: Color(0xFFDBEDFF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _weightcontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Weight (kg)',
                      filled: true,
                      fillColor: Color(0xFFDBEDFF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                RaisedButton(
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  onPressed: _calculate,
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //Spacer(),
                RaisedButton(
                  child: Text(
                    "Clear",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: _clear,
                  padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Result:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Formula',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Lean Body Mass',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        "Boer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text("$boerFormula"),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        "James",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text("$jamesFormula"),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        "Hume",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text("$humeFormula"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(
      () {
        _radioValue = value;
      },
    );
  }

  void _calculate() {
    setState(
      () {
        if (_weightcontroller.text.isEmpty &&
            _heightcontroller.text.isNotEmpty) {
          weight = 0;
        } else if (_heightcontroller.text.isEmpty &&
            _weightcontroller.text.isNotEmpty) {
          height = 0;
        } else {
          weight = double.parse(_weightcontroller.text);
          height = double.parse(_heightcontroller.text);
        }

        if (_radioValue == 0) {
          boerResult = (0.407 * weight) + (0.267 * height) - 19.2;
          boerFormula = format(boerResult);
          jamesResult = (1.1 * weight) - (128 * (pow((weight / height), 2)));
          jamesFormula = format(jamesResult);
          humeResult = (0.32810 * weight) + (0.33929 * height) - 29.5336;
          humeFormula = format(humeResult);
        } else if (_radioValue == 1) {
          boerResult = (0.252 * weight) + (0.473 * height) - 48.3;
          boerFormula = format(boerResult);
          jamesResult = (1.07 * weight) - (148 * (pow((weight / height), 2)));
          jamesFormula = format(jamesResult);
          humeResult = (0.29569 * weight) + (0.41813 * height) - 43.2933;
          humeFormula = format(humeResult);
        }
      },
    );
  }

  void _clear() {
    setState(
      () {
        _weightcontroller.clear();
        _heightcontroller.clear();
        boerFormula = "null";
        humeFormula = "null";
        jamesFormula = "null";
      },
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
