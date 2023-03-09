import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_bloc.dart';
import 'homepage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}
