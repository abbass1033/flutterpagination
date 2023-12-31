import 'dart:convert';

import 'package:http/http.dart' as http;
class PostRepo{
  fetchPost(int page)async{
    final url = Uri.parse("https://techcrunch.com/wp-json/wp/v2/posts?%22%22context=embed&per_page=20&page=1");

    var response = await http.get(url);
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      return json;
    }
  }
}