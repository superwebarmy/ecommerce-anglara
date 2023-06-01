import 'dart:convert';
import 'package:ecommerce/Model/ProductModel.dart';
import 'package:ecommerce/CartProvider.dart';
import 'package:ecommerce/View/SingleProduct.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget {
  final String category;
  const ProductPage({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  Future<List<ProductModel>?> getProducts() async {
    List<ProductModel> productList = [];
    var request = await http.get(Uri.parse('https://fakestoreapi.com/products/category/${widget.category}'));
    if(request.statusCode == 200){
      var decodedResponse = jsonDecode(request.body) as List<dynamic>;
      for (var element in decodedResponse) {
        productList.add(ProductModel.fromJson(element));
      }
      return productList;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 20.0, mainAxisExtent: 300.0),
                itemBuilder: (context, int index){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleProduct(productModel: snapshot.data![index])));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 180.0,
                          width: 180.0,
                          child: Image.network(snapshot.data![index].image!),
                        ),
                        const SizedBox(height: 10.0),
                        Text('BLUE BAG', style: GoogleFonts.oswald(color: Colors.grey)),
                        Text('${snapshot.data![index].price} DOLLARS', style: GoogleFonts.oswald()),
                        Consumer<CartProvider>(
                          builder: (context, provider, tree){
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent
                              ),
                              onPressed: (){
                                provider.addCart(context, snapshot.data![index]);
                              },
                              child: Text('ADD TO CART', style: GoogleFonts.oswald(color: Colors.white)),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
          },
        ),
      ),
    );
  }
}
