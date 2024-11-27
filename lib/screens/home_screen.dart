import 'package:flutter/material.dart';
import 'package:frontend/Brand_Screen/brand_screen.dart';
import 'package:frontend/add_to_cart_screen/cart_screen.dart';
import 'package:frontend/screens/exmple.dart';
import 'package:frontend/screens/new_arrival_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.menu, size: 30),
        title: Text(
          "ShopEase",
          style: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.favorite_outline, size: 30),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shaik Shahed",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Welcome to ShopEase",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
                prefixIcon: Icon(Icons.search, size: 26),
                contentPadding: EdgeInsets.all(14),
                hintText: "Search...",
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose Brand",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 50, // Set the height of the ListView
              child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                   final logos = [
                    "assets/Adidas-logo.png",
                    "assets/Nike-logo.png",
                    "assets/Puma-logo.png",
                    "assets/Fila-logo.png",
                    "assets/USPolo-logo.png",
                    "assets/Wrogn-logo.png",
                  ];
                  final brandNames = [
                    "Adidas",
                    "Nike",
                    "Puma",
                    "Fila",
                    "USPolo",''
                    "Wrogn",
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BrandScreen(brandName: brandNames[index].toLowerCase(),)));
                    },
                    child: Container(
                      // width: 140,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            logos[index],
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            brandNames[index],
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            overflow: TextOverflow
                                .ellipsis, // In case the name is too long
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Arrival",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     "View All",
                //     style: TextStyle(color: Colors.grey),
                //   ),
                // ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Expanded(child: NewArrivalGridPage()),
          ],
        ),
      ),
    );
  }
}
