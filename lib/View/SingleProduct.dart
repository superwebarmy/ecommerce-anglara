import 'package:ecommerce/CartProvider.dart';
import 'package:ecommerce/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatefulWidget {
  final ProductModel productModel;
  const SingleProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.network(widget.productModel.image!, height: MediaQuery.of(context).size.height*0.4, width: double.maxFinite),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productModel.title!.toUpperCase(), style: GoogleFonts.oswald(color: Colors.black, fontSize: 20.0)),
                      const SizedBox(height: 10.0),
                      RatingBar.builder(
                        initialRating: widget.productModel.rating!.count!.toDouble(),
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      const SizedBox(height: 10.0),
                      Text('DESCRIPTION', style: GoogleFonts.oswald(color: Colors.black)),
                      const SizedBox(height: 10.0),
                      Text(widget.productModel.description!, style: GoogleFonts.raleway(color: Colors.grey), textAlign: TextAlign.justify),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('TOTAL PRICE', style: GoogleFonts.oswald(color: Colors.grey)),
                              Text('${widget.productModel.price!} DOLLARS', style: GoogleFonts.oswald(color: Colors.black))
                            ],
                          ),
                          Consumer<CartProvider>(
                            builder: (context, provider, tree){
                              return ElevatedButton(
                                onPressed: (){
                                  provider.addCart(context, widget.productModel);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black
                                ),
                                child: Text('ADD TO CART', style: GoogleFonts.oswald(color: Colors.white)),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
