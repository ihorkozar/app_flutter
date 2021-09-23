import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen #1"),
      ),
      backgroundColor: Colors.amber,
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Screen #2'),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Screen2()),
            );
            print(result);
          },
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen #2"),
      ),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  bool? result = await _showMyDialog(context);
                  if (result == true) Navigator.of(context).pop("42");
                },
                child: const Text("Return 42")),
            ElevatedButton(
                onPressed: () async {
                  bool? result = await _showMyDialog(context);
                  if (result == true) Navigator.of(context).pop("AbErVaLlG");
                },
                child: const Text("Return AbErVaLlG")),
          ],
        ),
      ),
    );
  }
}

Future<bool?> _showMyDialog(BuildContext context) async => showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is alert dialog.'),
                Text('Would you like go to screen #1 ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        ));
