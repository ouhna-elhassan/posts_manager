import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'key.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<List<Post>> getpost(http.Client client,int page) async {
  final response = await client.get(
    Uri.parse('https://dummyapi.io/data/v1/post?page=$page&limit=20'),
    headers:<String, String>{
      'app-id':API_KEY,
    },
  );
  return compute(parsePosts,response.body);
}


List<Post> parsePosts(String responseBody){
  
  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}



Future<User> createUser() async {
  final response = await http.post(
    Uri.parse('https://dummyapi.io/data/v1/user/create'),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'app-id':'625c0856d26a27189d6ccd26',
    },
    body: jsonEncode(<String, String>{
      'title':'mr',
      'firstName':'ouhna',
      'lastName':'najjari',
      'email':'ali.elhassan@gmail.com',
      'picture':'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.t-t.ma%2Fproduits-et-services%2Fwp-content%2Fuploads%2F2022%2F02%2Fflutter-app-stage.png&imgrefurl=https%3A%2F%2Fwww.t-t.ma%2Fproduits-et-services%2Foffre-de-stage-en-developpement-mobile-a-safi%2F&tbnid=f92yD4R67ECk6M&vet=12ahUKEwji6IKfpZv3AhULuhQKHWssBosQMygfegUIARD8AQ..i&docid=nnJXC6tgs5rQgM&w=1200&h=700&q=dev%20mobile&ved=2ahUKEwji6IKfpZv3AhULuhQKHWssBosQMygfegUIARD8AQ',

    }),
  );

  if (response.statusCode == 200) {
   
    return User.fromJson(jsonDecode(response.body));
  } else {
    
    throw Exception('Failed to create album.');
  }
}


Future<List<Post>> searchList(http.Client client,int p,String tag) async {
  final response = await client.get(
    Uri.parse('https://dummyapi.io/data/v1/tag/$tag/post?page=$p&limit=10'),
    headers:<String, String>{
      'app-id':API_KEY,
    },
    );
  return compute(parseList,response.body);
  
}

List<Post> parseList(String responseBody){
  
  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}


Future<Post> deletePost(String id) async {
  final response= await http.delete(
    Uri.parse('https://dummyapi.io/data/v1/post/$id'),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'app-id':API_KEY
    }
  );

  if (response.statusCode == 200) { 
    Fluttertoast.showToast(msg:'post deleted');
    return Post.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg:'failed to delet post!');
    throw Exception('');
  }
}
