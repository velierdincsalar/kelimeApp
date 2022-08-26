import 'dart:math';

import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:kelime/db/dbHelper.dart';
import 'package:kelime/models/word.dart';
import 'package:kelime/screens/indicator.dart';



class PageViewPage extends StatefulWidget  {
  PageViewPage({ this.catex ,this.appAds});
  final String catex;
  final Ads appAds;
State<StatefulWidget> createState() =>ProductListState(catez: catex,appAds2: appAds);

}
class ProductListState  extends State
{
ProductListState({ this.catez,this.appAds2 });
  final String catez;
   final Ads appAds2;
  PageController pageController ;

      final kategori = ['A', 'B', 'C', 'D', 
        'E', 'F', 'G', 'H',
        'I', 'J', 'K', 'L', 'M', 'N',
        'O', 'P', 'R', 'S', 'T', 'U', 'V',
        'W', 'X', 'Y', 'Z'];
        
   List colors = [Colors.black, Colors.green,Colors.blue,Colors.brown,Colors.lime,Colors.orange, Colors.yellow, Colors.deepPurple, Colors.pink, Colors.red];
    Random random = new Random();

DbHelper dbHelper = new DbHelper();
  List<Word> words ;
  int count =0;

  @override
  Widget build(BuildContext context) 
  {
     
    if(words==null)
    {
       words = new List<Word>();
       getData(catez);
    }
          ScrollController _scrollController = new ScrollController(
   initialScrollOffset: 0.0,
   keepScrollOffset: false,
 );
   var art=0.0;
    void _pageChanged(int index) {
      art=art+35.0;
    
    
   _scrollController.jumpTo(art);
  
  }
   pageController= PageController(
    initialPage: count,
    keepPage: true,
  );
      var ss=5;
    return Scaffold(
     
       appBar: AppBar
      (
        title: Text(this.catez+" Kelimeleri",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),body: PageView.builder(
   itemCount: count,
     controller: pageController,
      onPageChanged: _pageChanged,
  itemBuilder: (context,position) 
  {
    if(position>ss)
    {
       if(count>ss)
       {
         ss=ss+10;
       }
    }
    if(position==ss)
    {
       appAds2.showVideoAd(state: this);
    }
   var renk= random.nextInt(10);
      return Container(
         alignment: AlignmentDirectional.center,
         color: colors[renk],
     child:Column(
       children: <Widget>[
          Text(
          count.toString()+" Kelime'nin "+(position+1).toString()+"'incisi",
            style: TextStyle(fontSize: 20.0, color: Colors.white,),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
         Text(
           this.words[position].eng,
            style: TextStyle(fontSize:57.0, color: Colors.white,),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height:50.0,
          ),
          Text(
              this.words[position].tr,
            style: TextStyle(fontSize: 57.0, color: Colors.white),
             textAlign: TextAlign.center,
          ),
             Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
                child:SafeArea(right: true,
            child:Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child:  SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
           child:   Indicator(
        
          controller: pageController,
          itemCount: count,
        ),)
           ))
            ),
          )
       ],
     ),
    );
  },
  
),
    );
  }



void getData(String cate)
{
      var db = dbHelper.initializeDb();
      db.then
      (
          (result)
          { 
            var productsFuture = dbHelper.cateWords(cate);
            productsFuture.then
            (
              (data)
              {
                List<Word> productsData = new List<Word>();
                count = data.length;

                for(int i=0 ;i< count;i++)
                {
                  productsData.add(Word.fromObject(data[i]));
                }
                setState(() {
                 words= productsData;
                 count= count; 
                });

              }
            );
          }
      );
}

 
}
