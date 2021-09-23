import 'package:flutter/material.dart';
import 'package:app_flutter/unit.dart';

const _padding = EdgeInsets.all(16.0);

class ConverterRoute extends StatefulWidget {
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    required this.color,
    required this.units,
    Key? key,
  }) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<ConverterRoute> {
  Unit? _startValue;
  Unit? _finishValue;
  double? _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem>? _unitMenuItems;
  bool _showValidationError = false;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Text(
          unit.name,
          softWrap: true,
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  void _setDefaults() {
    setState(() {
      _startValue = widget.units[0];
      _finishValue = widget.units[1];
    });
  }

  ///Rewrite with extension
  String _format(double data) {
    var output = data.toStringAsPrecision(7);
    if (output.contains('.') && output.endsWith('0')) {
      var i = output.length - 1;
      while (output[i] == '0') {
        i -= 1;
      }
      output = output.substring(0, i + 1);
    }
    if (output.endsWith('.')) {
      return output.substring(0, output.length - 1);
    }
    return output;
  }

  void _updateConversion() {
    setState(() {
      _convertedValue = _format(
          _inputValue! * (_finishValue!.conversion / _startValue!.conversion));
    });
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input.isEmpty) {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  Unit? _getUnit(String? unitName) {
    // return widget.units.firstWhereOrNull((Unit unit) {
    //     return unit.name == unitName;
    //   },
    // );
    List<Unit> elements = [];
    for (var element in widget.units) {
      if (element.name == unitName) {
        elements.add(element);
      }
    }
    if (elements.isNotEmpty) {
      return elements.first;
    } else {
      return null;
    }
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _startValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _finishValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Widget _createDropdown(
      String? currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline4,
              errorText: _showValidationError ? 'Invalid number entered' : null,
              labelText: 'Input',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_startValue!.name, _updateFromConversion),
        ],
      ),
    );

    const arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.headline4,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.headline4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_finishValue!.name, _updateToConversion),
        ],
      ),
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        input,
        arrows,
        output,
      ],
    );

    return SingleChildScrollView(
        child: Padding(
      padding: _padding,
      child: converter,
    ));
  }
}
