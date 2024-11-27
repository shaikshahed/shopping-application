import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/newarrival_bloc/new_arrival_bloc.dart';
import 'package:frontend/screens/new_arrival_details_screen.dart';
import 'package:frontend/user_register_repo/register_repo.dart';

class NewArrivalGridPage extends StatelessWidget {
  const NewArrivalGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NewArrivalBloc(UserRepository())..add(FetchNewArrivalItems()),
        child: BlocBuilder<NewArrivalBloc, NewArrivalState>(
              builder: (context, state) {
                if(state is NewArrivalLoadingState){
                  return Center(child: CircularProgressIndicator());
                }else if(state is NewArrivalLoadedState){
                  final items = state.items;
                   return GridView.builder(
                    // padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      // mainAxisSpacing: 8.0,
                      childAspectRatio: 0.45
                      ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewArrivalDetailsScreen(itemId: item['_id']??"")));
                        },
                            child: Image.network(item['url']?? "",
                            height: 240,
                            width: double.infinity,
                            fit: BoxFit.cover,),
                          ),
                          Text(item['name'] ?? 'Unknown item', 
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price: ${item['price'] ?? "N/A"}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                            ],
                          )
                        ],
                      );
                    }, 
                    );
                } else if(state is NewArrivalErrorState){
                  return Center(child: Text(state.message),);
                }
                return Center(child: Text("No data found"),);
              }
            ),
      ),
    );
  }
}