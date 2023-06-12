import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  ScrollController controller = ScrollController();

  List products = [];
  int skip = 0;
  int limit = 20;
  bool isLoadMore = false;

  fetchProduct()async{
    var response = await http.get(Uri.parse("https://dummyjson.com/products?limit=$limit&skip=$skip"));

    if(response.statusCode == 200){
      var json = jsonDecode(response.body)['products'] as List;

      setState(() {
        products.addAll(json);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProduct();
    controller.addListener(() async {
      if(controller.position.pixels == controller.position.maxScrollExtent){
      setState(() {
        isLoadMore = true;
      });

      skip = skip + limit;
     await  fetchProduct();

      setState(() {
        isLoadMore = false;
      });

      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        controller: controller,
          itemCount: isLoadMore ? products.length + 1 : products.length,
          itemBuilder: (context , index){

          if(index >= products.length){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            return Card(
              child: ListTile(

                leading: CircleAvatar(backgroundImage: NetworkImage(products[index]["thumbnail"]),),
                title: Text(products[index]["title"]),
                subtitle: Text(products[index]["description"]),
              ),
            );
          }



      }),
    );
  }
}
