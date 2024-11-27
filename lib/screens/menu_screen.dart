import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/add_to_cart_screen/cart_screen.dart';
import 'package:frontend/logout_bloc/logout_bloc.dart';
import 'package:frontend/screens/logout_page.dart';
import 'package:frontend/screens/terms_and_conditions_screen.dart';
import 'package:frontend/screens/wishlist_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String? _imagePath;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    // print(_loadUserId());
  }


  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _loadUserId()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id');
    });
    print("idd:$_userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _imagePath != null
                        ? FileImage(File(_imagePath!))
                        : null,
                    child: _imagePath == null ? Icon(Icons.camera_alt) : null,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "shaik shahed",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "1234567890",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems(context).length,
                itemBuilder: (context, index) {
                  final item = menuItems(context)[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.grey[700]),
                      title: Text(
                        item['title'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                      onTap: item['onTap'] as VoidCallback?,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List of menu items with icon, title, and respective actions
   List<Map<String, dynamic>> menuItems(BuildContext context){
    return [
    {
      'title': 'Privacy Policy',
      'icon': Icons.privacy_tip,
      'onTap': () {
        // Navigate to Privacy Policy page
      },
    },
    {
      'title': 'Edit Profile',
      'icon': Icons.edit,
      'onTap': () {
        // Navigate to Edit Profile page or function
      },
    },
   {
        'title': 'My Cart Items',
        'icon': Icons.shopping_cart_outlined,
        'onTap': () {
          if (_userId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen(uuid: _userId!)),
            );
          } else {
            print("error");
          }
        },
      },
    {
      'title': 'My Orders',
      'icon': Icons.shopping_bag,
      'onTap': () {
        // Navigate to My Orders page
      },
    },
    {
      'title': 'Wishlist',
      'icon': Icons.favorite,
      'onTap': () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WishlistScreen()));
      },
    },
    {
      'title': 'Terms and Conditions',
      'icon': Icons.description,
      'onTap': () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionsScreen()));
      },
    },
    {
      'title': 'Log Out',
      'icon': Icons.logout,
      'onTap': () {
        showDialog(context: context, 
        builder: (context) => BlocProvider(
                  create: (context) => LogoutBloc(),
                  child: LogoutConfirmationDialog(),
                ),);
      },
    },
  ];
  }
}
