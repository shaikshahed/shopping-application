
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/add_to_cart_screen/cart_bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  final String uuid; // Pass UUID to get cart items for the specific user
  const CartScreen({super.key, required this.uuid,});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cart"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartBloc()..add(GetCartItemsEvent()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetCartLoaded) {
              // Assuming state.cartItems contains the list of cart items
              return ListView.builder(
                itemCount: state.cartItems['items'].length,
                itemBuilder: (context, index) {
                  print("itemsss:${state.cartItems}");
                  final item = state.cartItems['items'][index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: 160,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 150,
                                    width: 130,
                                    child: Image.network(
                                      item['url'], // Use item data
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 230,
                                        child: Text(
                                          item['name'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Price: ${item['price']}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Quantity controls (if needed)
                                          Row(
                                            children: [
                                              IconButton(onPressed: (){

                                             }, icon: Icon(Icons.remove,size: 18,)),
                                              SizedBox(width: 10),
                                              Text(
                                                "$quantity", // Placeholder for quantity
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 10),
                                             IconButton(onPressed: (){

                                             }, icon: Icon(Icons.add,size: 18,))
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Dispatch event to remove item from cart
                                                 BlocProvider.of<CartBloc>(context).add(
                                                    RemoveFromCartEvent(
                                                      userId: "",
                                                      itemId: item['_id'],
                                                    ),
                                                 );
                                                
                                                 print("itemid:${item['_id']}");
                                                },
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Total Price: ${item['price'] * quantity}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
              
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text("No items in the cart."));
            }
          },
        ),
      ),
    );
  }
}
