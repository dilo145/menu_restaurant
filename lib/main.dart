import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<String> categories = [
    'Entrées',
    'Plats',
    'Desserts',
    'Boissons',
    'Accompagnements',
    'Menu enfants',
    'Vins',
    'Cocktails'
  ];
  final Map<String, List<Dish>> dishesByCategory = {
    'Entrées': [
      Dish(name: 'Salade', imageUrl: 'assets/images/salade.jpg', price: 5.0, description: 'Salade verte.'),
      Dish(name: 'Salade', imageUrl: 'assets/images/salade.jpg', price: 5.0, description: 'Salade verte.'),
      Dish(name: 'Salade', imageUrl: 'assets/images/salade.jpg', price: 5.0, description: 'Salade verte.'),
      Dish(name: 'Salade', imageUrl: 'assets/images/salade.jpg', price: 5.0, description: 'Salade verte.'),
      Dish(name: 'Salade', imageUrl: 'assets/images/salade.jpg', price: 5.0, description: 'Salade verte.'),
    ],
    'Plats': [
      Dish(name: 'Steak', imageUrl: 'assets/images/steak.jpg', price: 15.0, description: 'Steak grillé.'),
      Dish(name: 'Steak', imageUrl: 'assets/images/steak.jpg', price: 15.0, description: 'Steak grillé.'),
      Dish(name: 'Steak', imageUrl: 'assets/images/steak.jpg', price: 15.0, description: 'Steak grillé.'),
      Dish(name: 'Steak', imageUrl: 'assets/images/steak.jpg', price: 15.0, description: 'Steak grillé.'),
      Dish(name: 'Steak', imageUrl: 'assets/images/steak.jpg', price: 15.0, description: 'Steak grillé.'),
    ],
    'Desserts': [
      Dish(name: 'Tarte', imageUrl: 'assets/images/tarte.jpg', price: 7.0, description: 'Tarte aux pommes.'),
      Dish(name: 'Tarte', imageUrl: 'assets/images/tarte.jpg', price: 7.0, description: 'Tarte aux pommes.'),
      Dish(name: 'Tarte', imageUrl: 'assets/images/tarte.jpg', price: 7.0, description: 'Tarte aux pommes.'),
      Dish(name: 'Tarte', imageUrl: 'assets/images/tarte.jpg', price: 7.0, description: 'Tarte aux pommes.'),
      Dish(name: 'Tarte', imageUrl: 'assets/images/tarte.jpg', price: 7.0, description: 'Tarte aux pommes.'),
    ],
    'Boissons': [
    ],
    'Menu enfants': [
    ],
    'Accompagnements': [
    ],
    'Vins': [
    ],
    'Cocktails': [
    ],
  };

  late PageController _pageController;
  String selectedCategory = 'Entrées';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu du Restaurant')),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: selectedCategory == categories[index] ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedCategory = categories[index];
                });
              },
              itemCount: categories.length,
              itemBuilder: (context, categoryIndex) {
                return ListView.builder(
                  itemCount: dishesByCategory[categories[categoryIndex]]!.length,
                  itemBuilder: (context, index) {
                    return DishCard(
                        dish: dishesByCategory[categories[categoryIndex]]![index]
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Dish {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Dish({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(dish.imageUrl),
            SizedBox(height: 8),
            Text(dish.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${dish.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(dish.description),
          ],
        ),
      ),
    );
  }
}