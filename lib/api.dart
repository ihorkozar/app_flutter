import 'dart:convert';
import 'dart:io';

const apiCategory = {
  'name': 'Currency',
  'route': 'currency',
};

class Api {
  final _client = HttpClient();
  final _url = 'flutter.udacity.com';

  Future<List?> getUnits(String? category) async {
    final uri = Uri.https(
      _url,
      '/$category',
    );
    final jsonResponse = await _getJsonResponse(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      print('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }

  Future<double?> convert(
    String? category,
    String amount,
    String? from,
    String? to,
  ) async {
    final uri = Uri.https(
        _url, '/$category/convert', {'amount': amount, 'from': from, 'to': to});
    final jsonResponse = await _getJsonResponse(uri);
    if (jsonResponse == null || jsonResponse['status'] == null) {
      print('Error retrieving conversion.');
      return null;
    } else if (jsonResponse['status'] == 'error') {
      print(jsonResponse['message']);
      return null;
    }
    return jsonResponse['conversion'].toDouble();
  }

  Future<Map<String, dynamic>?> _getJsonResponse(Uri uri) async {
    try {
      final request = await _client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }
      final responseBody = await response.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
