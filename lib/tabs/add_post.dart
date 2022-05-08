import 'package:flutter/material.dart';
import '../api/models.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


class new_post extends StatefulWidget {
  new_post({Key? key}) : super(key: key);

  @override
  State<new_post> createState() => _new_postState();
}

class _new_postState extends State<new_post> {

  List<dynamic> tags=[];
  TextEditingController input3 =TextEditingController();
  TextEditingController input2 =TextEditingController();
  TextEditingController input1 =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          const SizedBox(height: 30,),
          const Center(
            child: Text('Add new post,',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          ),
          const SizedBox(height: 40,),
          Center(
            child: Container(
            width: 300,
            child: TextFormField(
              controller: input1,
              decoration:const InputDecoration(
                icon: Icon(Icons.text_fields),
                hintText: 'discrib your post',
                labelText: 'Text'
              ),
            ),
            
          ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: Container(
            width: 300,
            child: TextFormField(
              controller: input2,
              decoration:const InputDecoration(
                icon: Icon(Icons.image_outlined),
                hintText: 'link/url of image',
                labelText: 'Image'
              ),
            )
          ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  child: TextFormField(
                    controller: input3,
                    decoration:const InputDecoration(
                    icon: Icon(Icons.tag),
                    hintText: 'add tags ',
                    labelText: 'Tags',
                    
                  ),
                  )
                ),const SizedBox(width: 5,),
               
                IconButton(
                  onPressed: (){addtag(input3.text.toString());},
                  icon:const Icon(Icons.done_outline_sharp,color: Colors.blue,)
                  )
              ],
            ),
          ),
          const SizedBox(height: 60,),
          Center(
            child: Container(
            width: 300,
            height: 50,
            color: Colors.indigoAccent,
            child: TextButton(
                    onPressed: (){
                      createPost(input1.text.toString(), input2.text.toString(), tags);
                      },
                    child: const Text('Add',style:TextStyle(color:Colors.white))),
          ),
          ),
         
        ],
      );
  }

  void addtag(String tag){
  setState(() {
    tags.add(tag);
    Fluttertoast.showToast(msg:'tag added');
  });
  
}

Future<Post> createPost(String txt,String image,List<dynamic> tags) async {
  final response = await http.post(

    Uri.parse('https://dummyapi.io/data/v1/post/create'),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'app-id':'625c0856d26a27189d6ccd26',
    },
    body: jsonEncode(<String, dynamic>{
      'text':txt,
      'image':image,
      'likes':0,
      'tags':tags,
      'owner':'60d0fe4f5311236168a109ca'
    }),
  );
  if (response.statusCode == 200) {
    setState(() {
      tags=[];
    });
    Fluttertoast.showToast(msg:'post added');
    return Post.fromJson(jsonDecode(response.body));
  } else {
    
    throw Exception('Failed to create album.');
  }
}

}