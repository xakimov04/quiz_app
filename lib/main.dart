import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/note_provider.dart';
import 'package:quiz_app/providers/todo_provider.dart';
import 'package:quiz_app/views/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoState()),
        ChangeNotifierProvider(create: (_) => NoteState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo and Note App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          hintColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:const  HomeScreen(),
      ),
    );
  }
}


