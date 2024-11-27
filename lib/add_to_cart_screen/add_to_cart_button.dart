import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/add_to_cart_screen/cart_bloc/cart_bloc.dart';
import 'package:frontend/add_to_cart_screen/cart_screen.dart';

class AddToCartButton extends StatefulWidget {
  final String uuid;
  final Map<String, dynamic> item;

  const AddToCartButton({super.key, required this.uuid, required this.item});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isItemAdded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if(state is CartLoaded){
            setState(() {
              isItemAdded = true;
            });
          }else if(state is CartError){
            setState(() {
              isItemAdded = false;
            });
          }
        },
        child: ElevatedButton(
          onPressed: () {
            if(isItemAdded){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen(uuid: widget.uuid,)),
            );
            }else{
               context.read<CartBloc>().add(AddToCartEvent(
              userId: widget.uuid,
              item: widget.item,
            ));
            }
            // Dispatch the AddToCartEvent when the button is pressed
          
            print("userrrrridddd:${widget.uuid}");
            print("itemmmmm:${widget.item}");
            
          },
          child: Text(
            isItemAdded ? "Go to Cart":
            "Add to cart",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
