import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  double weight = 0.0;
  double height = 0.0;
  double boerResult = 0.0;
  double jamesResult = 0.0;
  double humeResult = 0.0;
  String boerFormula;
  String jamesFormula;
  String humeFormula;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Result:",
          ),
          Container(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Formula',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Lean Body Mass',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text("Boer"),
                    ),
                    DataCell(
                      Text("$boerFormula"),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text("James"),
                    ),
                    DataCell(
                      Text("$jamesFormula"),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text("Hume"),
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
}
