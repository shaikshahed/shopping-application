import 'package:flutter/material.dart';
import 'package:frontend/category_screen/category_grid_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Color> color = [
    Colors.cyan,
    Colors.pink.shade300,
    Colors.green,
    Colors.amber,
    Colors.purple.shade400,
    Colors.red,
    Colors.lime
  ];

  List<Map<String, String>> categoryData = [
    {
      "discount": "50% OFF",
      "title": "Men's Collection",
      "subtitle": "Exclusive For",
      "description": "Party wear",
      "image": "assets/men-style.png"
    },
    {
      "discount": "75% OFF",
      "title": "Women's Collection",
      "subtitle": "Special For",
      "description": "Wedding wear",
      "image": "assets/womens-wear.png"
    },
    {
      "discount": "60% OFF",
      "title": "Kid's Collection",
      "subtitle": "Great For",
      "description": "Playtime",
      "image": "assets/kids-wear.png"
    },
    {
      "discount": "25% OFF",
      "title": "Men's Watches",
      "subtitle": "Exclusive For",
      "description": "Luxury wear",
      "image": "assets/mens-watch.jpg"
    },
    {
      'discount': '30% OFF',
      'title': "Women\'s Watches",
      'subtitle': 'Elegant and stylish',
      'description': 'Timeless accessories',
      'image': 'assets/womens-watch.png'
    },
    {
      'discount': '35% OFF',
      'title': "Men\'s Footwear",
      'subtitle': 'Comfortable & trendy',
      'description': 'Everyday footwear',
      'image': 'assets/mens-shoe.png'
    },
    {
      'discount': '40% OFF',
      'title': "Women\'s Footwear",
      'subtitle': 'Stylish and comfy',
      'description': 'Perfect for occasion',
      'image': 'assets/womens-shoe.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Designs & categories")),
      ),
      body: ListView.builder(
          itemCount: categoryData.length,
          itemBuilder: (context, index) {
            bool isEven = index % 2 == 0;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  String selectedCategory;
                  switch (index) {
                    case 0:
                      selectedCategory = 'mens-dresses';
                      break;
                    case 1:
                      selectedCategory = 'womens-dresses';
                      break;
                    case 2:
                      selectedCategory = 'child-dresses';
                      break;
                    case 3:
                      selectedCategory = 'mens-watches';
                      break;
                    case 4:
                      selectedCategory = 'womens-watches';
                      break;
                    case 5:
                      selectedCategory = 'mens-shoes';
                      break;
                    case 6:
                      selectedCategory = 'womens-shoes';
                      break;
                    default:
                      selectedCategory = 'mens-dresses';
                  }
                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryGridScreen(category: selectedCategory),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: color[index],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: isEven
                          ? _buildTextFirst(index)
                          : _buildImageFirst(index)),
                ),
              ),
            );
          }),
    );
  }

  List<Widget> _buildTextFirst(int index) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 36.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryData[index]['discount']!,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              categoryData[index]['title']!,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              categoryData[index]['subtitle']!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              categoryData[index]['description']!,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: _buildImage(index),
      )
    ];
  }

  List<Widget> _buildImageFirst(int index) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildImage(index),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryData[index]['discount']!,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              categoryData[index]['title']!,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              categoryData[index]['subtitle']!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              categoryData[index]['description']!,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
    ];
  }

  Widget _buildImage(int index) {
    return categoryData[index].containsKey('image')
        ? Image.asset(
            categoryData[index]['image']!,
            height: 150,
            width: 140,
            fit: BoxFit.cover,
          )
        : const SizedBox(
            height: 140,
            width: 120,
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          );
  }
}
