import 'package:flutter_application/model/auth.dart';
import 'package:flutter_application/infrastructure/http.dart';

// ignore: non_constant_identifier_names
Future<LoginRes> Login(Map<String, String> loginBody) async {
  LoginRes response;
  var httpsUri = Uri(scheme: 'https', host: 'stockapi.zbdigital.net', path: '/api/v1/auth/login');
  var res = await Http("POST", httpsUri, loginBody);

  if (res.statusCode == 200) {
    response = LoginRes.fromJson(res.body);
  } else if (res.statusCode == 0) {
    response = LoginRes( code: 0, message: res.body, token: "", email: "", account: "", rank: 0, );
  } else  {
    response = LoginRes( code: res.statusCode, message: "api error", token: "", email: "", account: "", rank: 0, );
  }

  return response;
}