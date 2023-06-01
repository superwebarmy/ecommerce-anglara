import 'package:ecommerce/View/LoginPage.dart';
import 'package:ecommerce/View/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  
  late TabController tabController;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                labelStyle: GoogleFonts.oswald(),
                unselectedLabelStyle: GoogleFonts.oswald(),
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'LOGIN',
                  ),
                  Tab(
                    text: 'REGISTER',
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    LoginPage(),
                    RegisterPage()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
