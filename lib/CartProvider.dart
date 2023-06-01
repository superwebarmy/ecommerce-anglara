import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/ProductModel.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> cartList = [];

  CartProvider(){
    loadCart();
  }

  loadCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? stringList = sharedPreferences.getStringList('cartList');
    if(stringList != null){
      List<ProductModel> cartProductList = stringList.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();
      cartList = cartProductList;
    }

  }

  addCart(BuildContext context, ProductModel productModel) async {
    if(!cartList.contains(productModel)){
      cartList.add(productModel);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      List<String> stringList = cartList.map((e) => jsonEncode(e.toJson())).toList();
      sharedPreferences.setStringList('cartList', stringList);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ADDED TO THE CART', style: GoogleFonts.oswald(color: Colors.white)), backgroundColor: Colors.deepPurpleAccent));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PRODUCT ALREADY IN THE CART', style: GoogleFonts.oswald(color: Colors.white)), backgroundColor: Colors.deepPurpleAccent));
    }
  }

  removeCart(ProductModel productModel) async {
    cartList.remove(productModel);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> stringList = cartList.map((e) => jsonEncode(e.toJson())).toList();
    sharedPreferences.setStringList('cartList', stringList);
    notifyListeners();
  }
}