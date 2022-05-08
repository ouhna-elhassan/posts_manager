import 'package:flutter/material.dart';
import '../api/apilayer.dart';
import 'package:http/http.dart' as http;
import '../api/models.dart';
import 'result_search.dart';

class searshLP extends StatefulWidget {
  searshLP({Key? key}) : super(key: key);

  @override
  State<searshLP> createState() => _searshLPState();
}

class _searshLPState extends State<searshLP> {

  final input4 = TextEditingController();
  int s=0;
 
  String tag='';

  @override
  Widget build(BuildContext context) {
   
    return ListView(
      
      scrollDirection: Axis.vertical,
      
      children: [
      
      const SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height:15),
          Center(
            child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:const Offset(0, 3),
                        ),
                      ],
            ),
            child:TextFormField(
              controller: input4,
              
              decoration:const InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'search by tag',
                
              ),
            ),
          ),
          ),
          const SizedBox(width: 5,),
          Center(
            child: Container(
            width: 70,
            height: 50,
            color: Colors.indigoAccent,
            child: TextButton(
                    onPressed: (){               
                        setState(() {
                          s=(s+1)%2;                       
                        });
                      
                      },                
                    child: const Text('Search',style:TextStyle(color:Colors.white))),
          ),
          ),
        ],
      ),
      const SizedBox(height: 15,),
      Container(
        height: 435,
        child:s==0? const Center(child: Text(
        'Add tag to search',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey
        ),
      ),
      ):FutureBuilder<List<Post>>(
       
                        future: searchList(http.Client(),0,input4.text.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child:Text('${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            
                            return HomePage(posts: snapshot.data!,tag: input4.text.toString());
                          } else {
                            
                            return const Center(
                              
                              child: CircularProgressIndicator(),
                            );
                         }
                        
                        }
                        )
      
      )
    ],);
  }
  
}