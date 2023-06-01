import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
              hintText: 'FULL NAME',
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
        TextFormField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'CONFIRM PASSWORD',
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
                  if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                    if(passwordController.text != confirmPasswordController.text){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PASSWORD NOT MATCHING', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
                    } else {
                      provider.register(context, emailController.text, passwordController.text);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FIELDS CANNOT BE EMPTY', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
                  }
                },
                child: provider.isLoadingRegister ? const Center(child: CircularProgressIndicator(color: Colors.white)) : Text('LOGIN', style: GoogleFonts.oswald(color: Colors.white)),
              ),
            );
          },
        )
      ],
    );
  }
}
