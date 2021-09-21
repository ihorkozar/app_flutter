import 'package:app_flutter/converter_route.dart';
import 'package:app_flutter/unit.dart';
import 'package:flutter/material.dart';

const _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  /// Creates a [Category].
  const Category({Key? key,
    required this.name,
    required this.color,
    required this.iconLocation,
    required this.units})
      : super(key: key);

  ///Navigate to Converter
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              title: Text(
                name,
                style: Theme.of(context).textTheme.headline2,
              ),
              centerTitle: true,
              backgroundColor: color,
            ),
            body: ConverterRoute(
              color: color,
              units: units,
            ),
          );
        },
    ));
  }

  /// Custom widget that shows [Category] information.
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color[50],
          splashColor: color[100],
          onTap: () {
            _navigateToConverter(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
