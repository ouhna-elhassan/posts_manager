import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/apilayer.dart';
import 'tabs/search.dart';
import 'api/models.dart';
import 'tabs/home_page.dart';
import 'tabs/add_post.dart';

//main function
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  int curr=0;
  
  @override
  Widget build(BuildContext context) {

    //les trois vues de l'app 
    final _tabs=<Widget>[
      home_posts(),
      searshLP(),
      new_post(),
      
    ];
    
    return MaterialApp(
      title: 'Dummy API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        appBar:AppBar(
          automaticallyImplyLeading:false,
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
              ),
            ),
          title: const Text('Dummy API: \nPosts manager ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          toolbarHeight:100,
          actions:const [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://blog.logrocket.com/wp-content/uploads/2022/02/Complete-guide-Flutter-architecture-nocdn.png'),
            )
           
          ],
          backgroundColor: Colors.white,
        
        ),
        body:_tabs[curr],    
        bottomNavigationBar: BottomNavigationBar(
          items: const [
             BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
             BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: 'Search'),
             BottomNavigationBarItem(icon: Icon(Icons.add_comment_outlined),label: 'Add post'),
          ],
          currentIndex: curr,
          type:BottomNavigationBarType.fixed,
          onTap: (int index){
            
            setState(() {
              
              curr=index;
            });
          },
        
        ),
      )
      );
  }

}

//analyse de la réponse de la requete get  
FutureBuilder<List<Post>> home_posts() {
  return FutureBuilder(
        future: getpost(http.Client(),0),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Center(
              child:Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return HomePage(posts: snapshot.data!);
          } else {
            return const Center(
              
              child: CircularProgressIndicator(),
            );
          }
        }
        );
      }