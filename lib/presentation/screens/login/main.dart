import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/auth.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/model/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LoginBody();
    // return BlocProvider(
    //   create: (BuildContext context) => AuthBloc(),
    //   child: _LoginBody(),
    // );
  }
}

class _LoginBody extends StatelessWidget {
  String account = '';
  String password = '';
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  _LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    return Scaffold(
      body: Center(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 15, 17, 16),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Color.fromARGB(255, 128, 146, 163), blurRadius: 5)
              ]
            ),
            child: Column(
              children: <Widget>[
                const _title(),
                _socialBtn(
                  bgColor: const Color.fromARGB(255, 255, 255, 255),
                  callBack: () { print("Google Login"); },
                  text: "使用Google登入",
                  color: const Color.fromARGB(255, 0, 0, 0),
                  img: "http://pngimg.com/uploads/google/google_PNG19635.png"
                ),
                _socialBtn(
                  bgColor: const Color.fromARGB(255, 24, 119, 242),
                  callBack: () { print("Facebook Login"); },
                  text: "使用Facebook登入",
                  color: const Color.fromARGB(255, 255, 255, 255),
                  img: "https://pngimg.com/uploads/facebook_logos/facebook_logos_PNG19754.png"
                ),
                _hr(text: "或"),
                _label(text: "帳號"),
                TextField(
                  controller: accountController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 222, 222, 222),
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                    ),
                  ),
                  onChanged: (String val) {
                    account = val;
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                ),
                _label(text: "密碼"),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 222, 222, 222),
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                    ),
                  ),
                  onChanged: (String val) {
                    password = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async { 
                        var res = await _login(account, password);
                        if (res.code == 10000) {
                          authBloc.add(UpdateAccountEvent(account: res.account));
                          authBloc.add(UpdateTokenEvent(token: res.token));
                          authBloc.add(UpdateEmailEvent(email: res.email));
                          authBloc.add(UpdateRankEvent(rank: res.rank));
                          // ignore: use_build_context_synchronously
                          _toPath(context, "/home");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 222, 222, 222),
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      child: const Text(
                        "登入",
                        style: TextStyle(
                          color: Color.fromARGB(255, 20, 28, 36),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    )
                  ),
                ), 
              ],
          ),
        ),
      )),
      backgroundColor: const Color.fromARGB(255, 20, 28, 36), // #141c24
    );
  }
}

class _title extends StatelessWidget {
  const _title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "登入",
        style: TextStyle(
          color: Color.fromARGB(255, 222, 222, 222),
          fontWeight: FontWeight.bold,
          fontSize: 32.0,
        ),
      ),
    );
  }
}

class _socialBtn extends StatelessWidget {
  Color _bgColor;
  Color _color;
  VoidCallback _callBack;
  String _text;
  String _img;
  _socialBtn({Key? key, required Color bgColor,  required Color color, required VoidCallback callBack, required String text, required String img}) 
  : _bgColor = bgColor, _color = color, _callBack = callBack, _text = text, _img = img, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 00),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: _callBack,
          style: ElevatedButton.styleFrom(
            primary: _bgColor,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                _img,
                fit: BoxFit.cover,
                width: 30.0,
                height: 30.0,
              ),
              Text(
                _text, 
                style: TextStyle(
                  color: _color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}

class _hr extends StatelessWidget {
  String _text;
  _hr({Key? key, required String text}) : _text = text, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Row(
        children: const <Widget>[
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 128, 146, 163), //#8092a3
              thickness: 2.0,
              endIndent: 4.0,
            ),
          ),
          Text(
            "或",
            style: TextStyle(
              color: Color.fromARGB(255, 222, 222, 222),
              fontWeight: FontWeight.w600,
              fontSize: 18.0
            ),
          ),
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 128, 146, 163), //#8092a3
              thickness: 2.0,
              indent: 4.0,
            )
          ),
        ],
      ),
    );
  }
}

class _label extends StatelessWidget {
  String _text;
  _label({Key? key, required String text}) : _text = text, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
        child: Text(
          _text,
          style: const TextStyle(
            color: Color.fromARGB(255, 222, 222, 222),
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          ),
        ),
      );
  }
}

Future<LoginRes> _login(String account, String password) async {
  Map<String, String> body = {
    "account": account,
    "password": password,
  };
  var response = await Login(body);
  print("${response.code}, ${response.account}, ${response.email}");
  return response;
}

void _toPath(BuildContext context, String path) {
  AutoRouter.of(context).replaceNamed(path);
}
