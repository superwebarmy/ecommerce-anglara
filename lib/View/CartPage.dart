import 'package:ecommerce/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(child: Text('MY CART', style: GoogleFonts.oswald(color: Colors.black, fontSize: 20.0))),
            const SizedBox(height: 30.0),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, provider, tree){
                  return ListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, int index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(provider.cartList[index].image!, height: 120.0, width: 120.0),
                            const SizedBox(width: 15.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.cartList[index].title!.toUpperCase(), style: GoogleFonts.oswald(color: Colors.grey)),
                                  Text('${provider.cartList[index].price} DOLLARS', style: GoogleFonts.oswald()),
                                  const SizedBox(height: 15.0),
                                  InkWell(
                                    onTap: (){
                                      provider.removeCart(provider.cartList[index]);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      child: Icon(Icons.delete, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
