import 'package:flutter/material.dart';


class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final TextEditingController _questionController = TextEditingController();
  String? _selectedOption;

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
