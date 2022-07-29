import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/test/bloc.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget  {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => TestBloc(),),
      ],
      
      child: const MyHomeBody(),
    );
  }
}

class MyHomeBody extends MyHomePage {
  const MyHomeBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final testBloc = BlocProvider.of<TestBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.pets,
              color: Colors.white,
            ),
            onPressed: () => print('按下狗掌'),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => print('按下搜尋'),
          )
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultTabController(
            length: 2,
            child: TabBar(
              tabs: [
                Tab(
                  text: '我是分頁一',
                ),
                Tab(
                  text: '他是分頁一',
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello Flutter!',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Hello Flutter!',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 226, 209, 55),
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  transform: Matrix4.rotationZ(0.5),
                  height: 150,
                  child: const Text('我是Container，我有背景顏色',
                      style:
                          TextStyle(color: Color.fromARGB(255, 230, 55, 142)))),
              Center(
                child: BlocBuilder<TestBloc, TestState>(builder: (context, state) {
                  return Text("目前數值${state.count}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("帳號：${state.account == '' ? '空的' : state.account}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("信箱：${state.email == '' ? '空的' : state.email}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("Token：${state.token == '' ? '空的' : state.token}");
                }),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Text("等級：${state.rank}");
                }),
              ),
              TextButton(
                onPressed: () {
                  testBloc.add(AddEvent());
                },
                child: const Text("加加")
              ),
              TextButton(
                onPressed: () {
                  testBloc.add(MinusEvent());
                },
                child: const Text("減減")
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).replaceNamed('/test');
          // Navigator.pushNamed(context, '/test');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '聊天室'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '個人資料'),
        ],
        fixedColor: Colors.amber, //選擇頁顏色
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Home'),
              onTap: () {
                _toPath(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Test'),
              onTap: () {
                _toPath(context, '/test');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                authBloc.add(LogoutEvent());
                _toPath(context, '/');
              },
            ),
          ],
        )
      ),
    );
  }
}

void _toPath(BuildContext context, String path) {
  AutoRouter.of(context).replaceNamed(path);
}
