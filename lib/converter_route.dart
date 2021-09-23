import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:app_flutter/unit.dart';

class ConverterRoute extends StatefulWidget {
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    required this.color,
    required this.units,
  });

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<ConverterRoute> {
  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units
    final unitWidgets = widget.units.map((Unit unit) {
      return Container(
        color: widget.color,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}
