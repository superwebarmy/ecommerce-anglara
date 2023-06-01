import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../AuthProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: 'EMAIL',
              hintStyle: GoogleFonts.oswald(),
              filled: true,
              fillColor: Colors.grey[200],
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
        ),
        const SizedBox(height: 15.0),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'PASSWORD',
              hintStyle: GoogleFonts.oswald(),
              filled: true,
              fillColor: Colors.grey[200],
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
        ),
        const SizedBox(height: 15.0),
        Consumer<AuthProvider>(
          builder: (context, provider, tree){
            return SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black
                ),
                onPressed: (){
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                    provider.login(context, emailController.text, passwordController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FIELDS CANNOT BE EMPTY', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
                  }
                },
                child: provider.isLoadingLogin ? const Center(child: CircularProgressIndicator(color: Colors.white)) : Text('LOGIN', style: GoogleFonts.oswald(color: Colors.white)),
              ),
            );
          },
        )
      ],
    );
  }
}
