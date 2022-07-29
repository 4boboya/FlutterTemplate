import 'dart:convert' as convert;
import 'package:flutter_application/infrastructure/http.dart';

Future<Map<String, List<dynamic>>> GetBrokerList(Map<String, dynamic> query) async {
  var response = <String, List<dynamic>>{};
  var httpsUri = Uri(
      scheme: 'https',
      host: 'stockapi.zbdigital.net',
      path: '/api/v1/stock/brokers',
      queryParameters: query
  );
  var res = await Http("GET", httpsUri);

  if (res.statusCode == 200) {
    response = Map.from(convert.jsonDecode(res.body));
  } else  {
    response = {};
  }

  return response;
}