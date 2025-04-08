import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'about_ivana.dart';
import 'about_jeremy.dart';
import 'about_grant.dart';
import 'login_page.dart';
import 'user_home.dart';
import 'ai_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'results_page.dart';
import 'chat_screen.dart';


main() async {
  //await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethos App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',  
      routes: {           // Add routes
        '/': (context) => const LoginPage(),
        '/about': (context) => const AboutIvanaPage(),
        '/about2': (context) => const AboutJeremyPage(),
        '/about3': (context) => const AboutGrantPage(),
        '/userhome': (context) => const UserHomePage(),
        //'/chat': (context) =>  ChatScreen(), // Add chat screen route
        '/results': (context) => const ResultsPage(response: "Welcome! Ask me something."), // Add results page route
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            
          ],
        ),
      ), 
    );
  }
}
