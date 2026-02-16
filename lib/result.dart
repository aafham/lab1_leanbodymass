import 'package:flutter/material.dart';

class ResultTable extends StatelessWidget {
  const ResultTable({
    super.key,
    required this.boerFormula,
    required this.jamesFormula,
    required this.humeFormula,
  });

  final String boerFormula;
  final String jamesFormula;
  final String humeFormula;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      columns: const <DataColumn>[
        DataColumn(label: Text('Formula')),
        DataColumn(label: Text('Lean Body Mass')),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Boer')),
            DataCell(Text(boerFormula)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('James')),
            DataCell(Text(jamesFormula)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Hume')),
            DataCell(Text(humeFormula)),
          ],
        ),
      ],
    );
  }
}
