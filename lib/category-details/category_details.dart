import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/add_to_cart_screen/add_to_cart_button.dart';
import 'package:frontend/add_to_cart_screen/cart_bloc/cart_bloc.dart';
import 'package:frontend/category-details/bloc/category_details_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailsPage extends StatefulWidget {
  final String id;
  final String category;
  const CategoryDetailsPage(
      {super.key, required this.id, required this.category});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryDetailsBloc()
            ..add(FetchCategoryDetailsEvent(
                category: widget.category, categoryId: widget.id)),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
            builder: (context, state) {
              if (state is CategoryDetailsLoadedState) {
                return Text(state.item['name'] ?? "Item details");
              }
              return Text("Item Detail");
            },
          ),
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              print('Category details API hit successful: ${state.message}');
            } else if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to add to cart: ${state.message}")),
              );
              print('Category details API hit failed: ${state.message}');
            }
          },
          child: BlocConsumer<CategoryDetailsBloc, CategoryDetailsState>(
            listener: (context, state) {
              if (state is CategoryDetailsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is CategoryDetailsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoryDetailsLoadedState) {
                final item = state.item;
                return FutureBuilder<String?>(
                  future: _getUUID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error loading user UUID"));
                    } else {
                      final uuid = snapshot.data ?? '';
                      print('Item: $item');
                      print('UUID: $uuid');
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      item["url"] ?? "",
                                      height: 380,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.broken_image, size: 150),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      item["name"] ?? "Unknown item",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 22),
                                    ),
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Price: ${item['price'] ?? "N/A"}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          AddToCartButton(uuid: uuid, item: item),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Description: ${item['description'] ?? "N/A"}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Buy Now",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              } else if (state is CategoryDetailsErrorState) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text("Unexpected state"));
            },
          ),
        ),
      ),
    );
  }

  Future<String?> _getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }
}
