import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/router/main.gr.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final AppRouter appRouter = AppRouter();
  runApp(
    BlocProvider(
      create: (context) =>  AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState> (
        builder: (context, state) => MyApp(appRouter: appRouter)
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter;
  const MyApp({Key? key, required AppRouter appRouter}) : _appRouter = appRouter, super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (context, router) => router!,
    );
  }
}
