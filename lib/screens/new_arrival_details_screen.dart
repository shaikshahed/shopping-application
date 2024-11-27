import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/add_to_cart_screen/add_to_cart_button.dart';
import 'package:frontend/add_to_cart_screen/cart_bloc/cart_bloc.dart';
import 'package:frontend/new_arrival_details_bloc/new_arrival_detail_bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class NewArrivalDetailsScreen extends StatelessWidget {
  final String itemId;

  const NewArrivalDetailsScreen({
    Key? key,
    required this.itemId,
  }) : super(key: key);

  Future<String?> _getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => NewArrivalDetailBloc(UserRepository())..add(FetchNewArrivalDetailEvent(id: itemId))),
    BlocProvider(create: (context) => CartBloc()), // CartBloc is correctly provided here
  ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<NewArrivalDetailBloc, NewArrivalDetailState>(
            builder: (context, state) {
              if (state is NewArrivalDetailLoadedState) {
                return Text(state.item['name'] ?? 'Item Details');
              }
              return Text('Item Details');
            },
          ),
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
           if(state is CartLoaded){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              print('API hit successful: ${state.message}');
           }else if(state is CartError){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to add to cart: ${state.message}")),
              );
              print('API hit failed: ${state.message}');
           }
          },
          child: BlocConsumer<NewArrivalDetailBloc, NewArrivalDetailState>(
            listener: (context, state) {
              if (state is NewArrivalDetailErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is NewArrivalDetailLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NewArrivalDetailLoadedState) {
                final item = state.item;
                return FutureBuilder<String?>(
                  future: _getUUID(), // Fetch UUID from SharedPreferences
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error loading user UUID"));
                    } else {
                      final uuid = snapshot.data ?? '';
                      print('Item: $item');
                      print('UUID: $uuid');
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    item['url'] ?? "",
                                    height: 380,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    item['name'] ?? "Unknown item",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Price: ${item['price'] ?? "N/A"}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // Pass the item and uuid to AddToCartButton
                                        AddToCartButton(
                                          item: item,
                                          uuid: uuid,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Description: ${item['description'] ?? "N/A"}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                      height: 80), // To prevent content overlap
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // Bottom padding for the button
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Buy now action
                                },
                                child: Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              } else if (state is NewArrivalDetailErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Center(child: Text("No item details available."));
            },
          ),
        ),
      ),
    );
  }
}
