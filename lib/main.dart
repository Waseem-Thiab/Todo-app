import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Tasks.dart';
import 'package:todo_app/cubits/task_cubit.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        title: 'Todo-List App',
         theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 7,
            ),
            
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
            bodyLarge: TextStyle(
                  
                  color: kColorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold
                ),
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kColorScheme.onSecondaryContainer,
                ),
              ),
        ),
        home: const Tasks(),
      ),
    );
  }
}
