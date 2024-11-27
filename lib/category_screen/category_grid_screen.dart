import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/category-details/category_details.dart';
import 'package:frontend/category_screen/bloc/category_bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';

class CategoryGridScreen extends StatefulWidget {
  final String category;
  const CategoryGridScreen({super.key, required this.category});

  @override
  State<CategoryGridScreen> createState() => _CategoryGridScreenState();
}

class _CategoryGridScreenState extends State<CategoryGridScreen> {
  getCategoryTitle(String category) {
    switch (category) {
      case "mens-dresses":
        return "Mens Collection";
      case "womens-dresses":
        return "Womens Collection";
      case "mens-watches":
        return "Mens Watches";
      case "womens-watches":
        return "Womens Watches";
      case "child-dresses":
        return "Kids Collection";
      case "mens-shoes":
        return "Men's Footwear";
      case "womens-shoes":
        return "Womens Footwear";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(getCategoryTitle(widget.category))),
      ),
      body: BlocProvider(
        create: (context) =>
            CategoryBloc()..add(FetchCategoryEvent(category: widget.category)),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryLoadedState) {
              final items = state.categoryData;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 4,
                      // mainAxisSpacing: 8,
                      childAspectRatio: 0.62),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryDetailsPage(
                                          id: item['_id'],
                                          category: widget.category,
                                          )));
                                          print("id:${item['_id']}");
                                          print("category:${widget.category}");
                            },
                            child: Container(
                                height: 240,
                                width: double.infinity,
                                child: Image.network(
                                  item['url'] ?? "",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Text(
                            item["name"] ?? "Unknown item",
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price: ${item["price"] ?? "N/A"}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.favorite_outline,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else if (state is CategoryErrorState) {
              return Text(state.message);
            }
            return Center(
              child: Text("No data found"),
            );
          },
        ),
      ),
    );
  }
}
