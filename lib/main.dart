import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'openai_service.dart'; // Import the API service
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(); // Load .env variables
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
      initialRoute: '/home',
      routes: {
        '/': (context) => ResultsPage(response: "Welcome! Ask me something."),
        '/home' : (context) => UserHomePage(),
      },
      
    );
  }
}







class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final OpenAIService openAIService = OpenAIService(); // Instance of OpenAI API
  final TextEditingController _controller = TextEditingController();
  String _response = "Example Output"; // Default response placeholder

  // Function to send message and get AI response
  void _sendMessage() async {
    String question = _controller.text;
    if (question.isEmpty) return;

    setState(() {
      _response = "Thinking..."; // Show loading state
    });

    try {
      // Send the typed question to OpenAI
      String aiResponse = await openAIService.fetchResponse(question);
      setState(() {
        _response = aiResponse; // Update UI with OpenAI's response
      });
    } catch (e) {
      setState(() {
        _response = "Error: $e"; // Show error message
      });
    }

    _controller.clear(); // Clear text field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Chat")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Output Box - Displays AI Response
            SizedBox(
              width: 500,
              height: 500,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: SingleChildScrollView( // Allows scrolling for long responses
                  child: Text(
                    _response, // Display OpenAI Response here
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // User Input Field for Question
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Ask a question",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Send Button to trigger message
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}










class ResultsPage extends StatelessWidget{
  final String response; // AI-generated response

  ResultsPage({required this.response}); // Constructor to receive response




  @override
  Widget build(BuildContext context){
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
            // text: Argument For/Against/Neutral
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Argument For/Against/Neutral',
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
                

            SizedBox(height: 10),

            // Output Box - Displays AI Response
            SizedBox(
              width: 500,
              height: 400,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    response, // AI Response
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            
            //Home
            SizedBox(
              width: 100,
              height: 50,

              child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 8, 7, 8), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Rounded corners
          ),
        ),
        child: Text(
          'Home',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
            ),
            

            //finish
          ],
        ),
      )
    );
  }
}















class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final TextEditingController _questionController = TextEditingController();
  String? _selectedOption;
  final OpenAIService openAIService = OpenAIService(); // Create an instance


  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _setOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }


  // Function to send question & option to OpenAI and navigate to ResultsPage
  void _sendToAI() async {
    String question = _questionController.text;
    if (question.isEmpty || _selectedOption == null) {
      return; // Prevent sending empty input
    }

    String fullPrompt =
        "Give an argument $_selectedOption for this question: $question. Limit the response to 200 words or less.";

    try {
      String aiResponse = await openAIService.fetchResponse(fullPrompt);

      // Navigate to ResultsPage with AI response
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(response: aiResponse),
        ),
      );
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching response: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1B3D1), // Light purple background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ethos',
          style: TextStyle(
            color: Color(0xFF663366), 
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF663366), 
          ),
          onPressed: () {
            // Menu functionality would go here
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'How can I help you?',
              style: TextStyle(
                color: Color(0xFF663366), // Dark purple text
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Row with three buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOptionButton('For', _selectedOption == 'For'),
                _buildOptionButton('Neutral', _selectedOption == 'Neutral'),
                _buildOptionButton('Against', _selectedOption == 'Against'),
              ],
            ),
            const SizedBox(height: 40),
            // Text input field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 150,
              child: TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  hintText: 'Enter a question',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 20),

            // Send Button
            Center(
              child: ElevatedButton(
                onPressed: _sendToAI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text("Get Argument"),
              ),
            ),
            SizedBox(height: 10),

          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () => _setOption(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label),
    );
  }
}