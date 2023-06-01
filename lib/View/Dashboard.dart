import 'package:ecommerce/AuthProvider.dart';
import 'package:ecommerce/View/CartPage.dart';
import 'package:ecommerce/View/Home.dart';
import 'package:ecommerce/View/ProductPage.dart';
import 'package:ecommerce/View/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentIndex = 0;
  late List screenList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenList = [Home(globalKey: _key), const CartPage(), const ProfilePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: screenList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurpleAccent,
        selectedLabelStyle: GoogleFonts.oswald(),
        unselectedLabelStyle: GoogleFonts.oswald(),
        items: const [
          BottomNavigationBarItem(label: 'HOME', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'CART', icon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(label: 'PROFILE', icon: Icon(Icons.person))
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30.0),
                height: 200.0,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                ),
                child: Center(child: Image.asset('assets/images/user.png')),
              ),
              const SizedBox(height: 15.0),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductPage(category: 'electronics')));
                },
                leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
                title: Text('ELECTRONIC', style: GoogleFonts.oswald()),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductPage(category: 'jewelery')));
                },
                leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
                title: Text('JEWELERY', style: GoogleFonts.oswald()),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductPage(category: "men's clothing")));
                },
                leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
                title: Text('MEN CLOTHING', style: GoogleFonts.oswald()),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductPage(category: "women's clothing")));
                },
                leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
                title: Text('WOMEN CLOTHING', style: GoogleFonts.oswald()),
              ),
              Consumer<AuthProvider>(
                builder: (context, provider, tree){
                  return ListTile(
                    onTap: (){
                      provider.logout(context);
                    },
                    leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
                    title: Text('SIGN OUT', style: GoogleFonts.oswald()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
