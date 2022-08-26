
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kelime/db/dbHelper.dart';
import 'package:kelime/models/word.dart';
import 'package:kelime/screens/kelimeAra.dart';
import 'package:kelime/screens/page_view_page.dart';
import 'package:kelime/screens/productAdd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:ads/ads.dart';
class ProductList extends StatefulWidget
{
  State<StatefulWidget> createState() =>ProductListState();
    
}
  
class ProductListState  extends State
{

 Ads appAds;


  final String appId = Platform.isAndroid
      ? 'ca-app-pub-1337937147584405~6844811427'
      : 'ca-app-pub-1337937147584405~9730683422';

  final String bannerUnitId = Platform.isAndroid
      ? 'ca-app-pub-1337937147584405/9772041874'
      : 'ca-app-pub-1337937147584405/3165275076';

  final String screenUnitId = Platform.isAndroid
      ? 'ca-app-pub-1337937147584405/9772041874'
      : 'ca-app-pub-1337937147584405/3380897490';

  final String videoUnitId = Platform.isAndroid
      ? 'ca-app-pub-1337937147584405/5688137262'
      : 'ca-app-pub-1337937147584405/3380897490';

  @override
  void initState() {
    super.initState();

    /// Assign a listener.
    var eventListener = (MobileAdEvent event) {
      if (event == MobileAdEvent.opened) {
        print("The opened ad is clicked on.");
      }
    };

     appAds = Ads(
      appId,
      bannerUnitId: bannerUnitId,
      screenUnitId: screenUnitId,
    
      childDirected: false,
     
      testing: false,
      listener: eventListener,
    );

     appAds.setVideoAd(
      adUnitId: videoUnitId,
    
      childDirected: true,
     
      listener: (RewardedVideoAdEvent event,
          {String rewardType, int rewardAmount}) {
        print("The ad was sent a reward amount.");
      
      },
    );

   appAds.showBannerAd(state: this, anchorOffset: null, size:AdSize.smartBanner);
  }

  @override
  void dispose() {
    appAds.dispose();
    super.dispose();
  }


  DbHelper dbHelper = new DbHelper();
  List<Word> words ;
      final kategori = ['A', 'B', 'C', 'D', 
        'E', 'F', 'G', 'H',
        'I', 'J', 'K', 'L', 
        'M', 'N', 'O', 'P', 
        'R', 'S', 'T', 'U', 
        'V','W', 'X', 'Y', 'Z'];
        
  int count =0;
  @override
  Widget build(BuildContext context)
  {
   
      words = new List<Word>();
      getDatax();
    
     return Scaffold
    (
       body: wordListCates(),
  
       floatingActionButton:Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: FloatingActionButton
        (
          
          onPressed: ()
          {
            kelimeAra();
          },
          tooltip: "Kelime Ara",
          backgroundColor: Colors.black,
          child: Icon((Icons.search)),
        )
        ) ,
        /*
        floatingActionButton:FloatingActionButton
        (
          onPressed: ()
          {
            goToProductAdd();
          },
          tooltip: "add new product",
          child: Icon((Icons.add)),
        ) ,
        */
      
    );
  }
    wordListCates()
{
  return  GridView.builder
  (
    itemCount:25 ,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context,int index)
    {
      return 
      InkWell(
         onTap: ()
       {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>PageViewPage(catex:kategori[index],appAds: appAds,),
        ));
    
              // Navigator.pushNamed(context, ProductDetail(),  arguments: ProductDetail(cate:this.name));
        // Navigator.of(context).pushNamed(Constants.ROUTE_PRODUCT_DETAIL);
       
       },
       child:
      Container
            (
              alignment: Alignment.center,
               color: Colors.cyan[100*((index+1) %8)],
            //  color: Colors.teal[100*((index+1) %8)],
              child: Text(kategori[index],textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey,fontSize: 70.5),),
            )
      );
      
     
    }
  );
}

  ListView productListItems() 
         {
           return ListView.builder
           (
             itemCount: count,
             itemBuilder: (BuildContext context,int position)
             {
               return 
                Card(
                 
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.black,
      elevation: 10,
     
        
  
          child: ListTile(
            
            leading: CircleAvatar
                   (
                     backgroundColor: Colors.white,
                     child: Text(this.words[position].cate,
                       style: TextStyle(color: Colors.black,fontSize: 25.0,),
                        textAlign: TextAlign.center),
                   ),
                   
            title: Padding(padding: EdgeInsets.only(bottom: 15.0), child: Text(this.words[position].eng+ " => " + this.words[position].tr,style: TextStyle(color: Colors.white,fontSize: 23.0), ),
            
            
            ),
           
          ),
      
      
     
   
  );

             },
           );
         }

  void goToProductAdd() async
  {
    await Navigator.push
    (
    context, 
     MaterialPageRoute
     (
       builder:
       (context)=>ProductAdd()
      )
    );
  
  }

void kelimeAra() async
{
await Navigator.push
    (
    context, 
     MaterialPageRoute
     (
       builder:
       (context)=>KelimeAra(appAds: appAds)
      )
    );
}

void getDatax()
{
      var db = dbHelper.initializeDb();
      db.then
      (
          (result)
          { 
            var productsFuture = dbHelper.getProducts();
            productsFuture.then
            (
              (data)
              {
                if(data.length==0)
                {
                    save();
                }

             
              }
            );
          }
      );
}
void save() async
    {
      int result ;
    String data = await getFileData("assets/user.txt");


     
  for (var line in data.split("|")) 
   {
     var icdata =line.split("*");
    result = await dbHelper.insert(Word(icdata[0],icdata[1],icdata[2]));
    }


    }
Future<String> getFileData(String path) async
 {
  return await rootBundle.loadString(path);
}
}
