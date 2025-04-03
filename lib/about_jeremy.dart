import 'package:flutter/material.dart';

class AboutJeremyPage extends StatefulWidget {
  const AboutJeremyPage({super.key});

  @override
  State<AboutJeremyPage> createState() => _AboutJeremyPageState();
}

class _AboutJeremyPageState extends State<AboutJeremyPage> {
  final PageController _pageController = PageController();
  int _currentPage = 1;  

  void _nextPage() {
    Navigator.pushReplacementNamed(context, '/about3');  // Go to Grant's page
  }

  void _previousPage() {
    Navigator.pushReplacementNamed(context, '/about');  // Go back to Ivana's page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Meet Our Creators!',
          style: TextStyle(
            fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousPage,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: _nextPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                CreatorPage(
                  name: "Jeremy Baron",
                  description: "Jeremy is a sophmore at Southern Methodist University studying Computer Science. He is interested in cybersecurity and enjoys keeping applications secure.",
                  imageUrl: "assets/images/jeremypfp.jpg", 
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatorPage extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const CreatorPage({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(height: 24),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}