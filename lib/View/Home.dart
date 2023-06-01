import 'dart:convert';
import 'package:ecommerce/Model/SliderModel.dart';
import 'package:ecommerce/View/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const Home({Key? key, required this.globalKey}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Future<List<SliderModel>> getSlider() async {
    var request = await http.get(Uri.parse('https://picsum.photos/v2/list'));
    if(request.statusCode == 200){
      var decodedResponse = jsonDecode(request.body) as List<dynamic>;
      List<SliderModel> sliderList = [];
      for (var element in decodedResponse) {
        sliderList.add(SliderModel.fromJson(element));
      }
      return sliderList;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getCategories() async {
    var request = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if(request.statusCode == 200){
      var decodedResponse = jsonDecode(request.body);
      return decodedResponse;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    widget.globalKey.currentState!.openDrawer();
                  },
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: const Center(child: Icon(Icons.apps, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            TextField(
              decoration: InputDecoration(
                  hintText: 'SEARCH',
                  hintStyle: GoogleFonts.oswald(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: const Icon(Icons.search, color: Colors.black)
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: FutureBuilder<List<SliderModel>>(
                future: getSlider(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index){
                        return  Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          height: 200.0,
                          width: 250.0,
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data![index].downloadUrl!),
                                fit: BoxFit.cover
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10.0))
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Text('PRODUCT', style: GoogleFonts.bebasNeue(fontSize: 25.0)),
                const SizedBox(width: 5.0),
                Text('COLLECTION', style: GoogleFonts.bebasNeue(fontSize: 25.0, color: Colors.deepPurpleAccent))
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: getCategories(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15.0, crossAxisSpacing: 15.0),
                      itemBuilder: (context, int index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(category: snapshot.data![index])));
                          },
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(child: Text(snapshot.data![index].toUpperCase(), style: GoogleFonts.oswald(color: Colors.white))),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}