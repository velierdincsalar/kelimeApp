import 'dart:io';

import 'package:app_review/app_review.dart';
import 'package:kelime/db/dbHelper.dart';
import 'package:kelime/models/word.dart';
import 'package:kelime/screens/page_view_page.dart';
import 'package:kelime/screens/productList.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

 
    return MaterialApp(
      title: 'İngilizce Cepte',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(
      seconds: 1,
      navigateAfterSeconds: MyHomePage(title: 'İngilizce Cepte'),
    
     // backgroundGradient: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      imageBackground:AssetImage('assets/giris.png'),
   
      
     // onClick: ()=>print("Flutter Egypt"),
      //loaderColor: Colors.red,
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 


String output = "";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     appBar: AppBar
      (
        title: Text(widget.title,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
       // centerTitle: true,
      actions: [                IconButton(
                        icon: Icon(Icons.share,color:Colors.black),
                        onPressed: () {
                            final RenderBox box = context.findRenderObject();

                        Share.share('İngilizce Cepte - https://play.google.com/store/apps/details?id=com.rob.ingilizcecepte',
                           subject:'Türkçe-İngilizce Benzer Kelimeler Sözlüğü',
                            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite,color:Colors.black),
                        onPressed: () {
                             AppReview.requestReview.then((onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                        },
                      ),
      
                      /*
                       IconButton(
                        icon: Icon(Icons.shopping_cart,color:Colors.black),
                        onPressed: () => null,
                      ),
                      */
                    ],
      ),
      body: ProductList(),
 
    );
  }

}
