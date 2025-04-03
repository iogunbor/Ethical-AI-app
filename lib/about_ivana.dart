import 'package:flutter/material.dart';

class AboutIvanaPage extends StatefulWidget {
  const AboutIvanaPage({super.key});

  @override
  State<AboutIvanaPage> createState() => _AboutIvanaPageState();
}

class _AboutIvanaPageState extends State<AboutIvanaPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (_currentPage == 0) {
        Navigator.pushReplacementNamed(context, '/about2');
      } else if (_currentPage == 1) {
        Navigator.pushReplacementNamed(context, '/about3');
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (_currentPage == 2) {
        Navigator.pushReplacementNamed(context, '/about2');
      } else if (_currentPage == 1) {
        Navigator.pushReplacementNamed(context, '/about');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Meet Our Creators!',
          style: TextStyle(
            fontWeight: FontWeight.bold
            ),
          ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_currentPage > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _previousPage,
            ),
          if (_currentPage < 2)
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
                  name: "Ivana Ogunbor",
                  description: "Ivana is a senior computer science student at Southern Methodist University. She is from Houston Texas. Ivana has experience in backend development and web development. In her free time she enjoys traveling and weightlifting.",
                  imageUrl: "assets/images/ivanapfp.jpg", 
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