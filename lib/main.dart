import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethos App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/passwordReset': (context) => PasswordResetPage(),
        '/login' : (context) => LoggedInPage(),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Color(0xFFD1B3D1), // Light purple background
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "Welcome to Ethos!" with stars
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // First Row for "Welcome to" with left star
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[900],
                      ),
                    ),
                    SizedBox(width: 8), // Space between star and text
                    Icon(Icons.star, color: Colors.purple, size: 20), // Left star
                  ],
                ),
                
                SizedBox(height: 4), // Small space between the lines

                // Second Row for "Ethos!" with right star
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.purple, size: 20), // Right star
                    SizedBox(width: 8), // Space between text and star
                    Text(
                      '       Ethos!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[900],
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // "Please Log In" text
            Text(
              'Please Log In',
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple[900],
              ),
            ),
            SizedBox(height: 20),

            // Username Input Field
            SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            ),
           
            SizedBox(height: 15),

            // Password Input Field
            SizedBox(
              width: 300,
              child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            ),
            
            SizedBox(height: 10),

            // Forgot Password Link
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/passwordReset');
              },
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[900],
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            SizedBox(height: 20),
            
            //login
            SizedBox(
              width: 300,
              height: 50,

              child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[700], // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
            ),
            

            //finish
          ],
        ),
      ),
    );
  }
}

class PasswordResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Password Reset Page'),
      ),
    );
  }
}

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Logged In Page'),
      ),
    );
  }
}
