import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 120.0,
                width: 120.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/user.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Text(FirebaseAuth.instance.currentUser!.email!.toUpperCase(), style: GoogleFonts.oswald())
          ],
        ),
      ),
    );
  }
}
