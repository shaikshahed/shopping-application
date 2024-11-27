import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Brand_Screen/bloc/brand_bloc.dart';
import 'package:frontend/brand_details_screen/brand_details_screen.dart';

class BrandScreen extends StatefulWidget {
  final String brandName;
  const BrandScreen({super.key, required this.brandName});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BrandBloc()..add(FetchBrandItemsEvent(brandName: widget.brandName)),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is BrandLoadedState) {
                return Text(
                  widget.brandName.toUpperCase(),
                );
              }
              return Text("Brand Item Details");
            },
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state) {
            if (state is BrandLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BrandLoadedState) {
              final clothingItems = state.clothingItems;
              final footwearItems = state.footwearItems;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Clothing',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                      ),
                      itemCount: clothingItems.length,
                      itemBuilder: (context, index) {
                        final item = clothingItems[index];
                        return _buildItemCard(item);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Footwear',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.56,
                      ),
                      itemCount: footwearItems.length,
                      itemBuilder: (context, index) {
                        final item = footwearItems[index];
                        return _buildItemCard(item);
                      },
                    ),
                  ],
                ),
              );
            } else if (state is BrandErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Failed to load data"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildItemCard(item) {
    print("hiiiii: ${item["url"]}");
    print("iddd: ${item["id"]}");
    print("brandName:${widget.brandName}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BrandDetailsScreen(
                        
                          id: item["_id"], brandName: widget.brandName)));
            },
            child: Container(
              height: 240,
              width: double.infinity,
              child: Image.network(
                item['url'] ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            item["name"] ?? "Unknown item",
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price: ${item["price"] ?? "N/A"}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.favorite_outline),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
