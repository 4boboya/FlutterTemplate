
import 'dart:convert';

class LoginRes {
  LoginRes({
    required this.code,
    required this.message,
    required this.token,
    required this.email,
    required this.account,
    required this.rank,
  });

  int code;
  String message;
  String token;
  String email;
  String account;
  int rank;

  factory LoginRes.fromJson(String str) => LoginRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRes.fromMap(Map<String, dynamic> json) => LoginRes(
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
    token: json["token"] ?? "",
    email: json["email"] ?? "",
    account: json["account"] ?? "",
    rank: json["rank"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "token": token,
    "email": email,
    "account": account,
    "rank": rank,
  };
}

class User {
  User({
    required this.token,
    required this.email,
    required this.account,
    required this.rank,
  });

  String token;
  String email;
  String account;
  int rank;
}