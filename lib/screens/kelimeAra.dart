import 'package:ads/ads.dart';
import 'package:kelime/db/dbHelper.dart';
import 'package:kelime/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelime/screens/arananKelime.dart';
import 'package:kelime/screens/page_view_page.dart';
import 'package:path_provider/path_provider.dart';

class KelimeAra extends StatefulWidget
{
   KelimeAra({ this.appAds });
  final Ads appAds;
  @override
  State<StatefulWidget> createState()=> ProductAddState(appAds2:appAds );
    
  }
  
class ProductAddState extends State
{
   ProductAddState({ this.appAds2 });
  final Ads appAds2;
   DbHelper dbHelper = new DbHelper();

  TextEditingController txtName= new TextEditingController();
  TextEditingController txtDescription= new TextEditingController();
  TextEditingController txtPrice= new TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Kelime Arama",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        centerTitle: true,
  
        
      ),
      body: 
      Padding
      (
        padding: EdgeInsets.only(top:30.0,left:20.0,right: 20.0),
        child:    Column
      (
        children: <Widget>
        [
        Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                    textInputAction: TextInputAction.search,
                    controller: txtName,
                  onFieldSubmitted: (value){
         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ArananKelime(catex: txtName.text,appAds3:appAds2),
            )
        );
        },
                    /*onChanged: (v)
                    {
                             Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>ArananKelime(catex: v),
        ));
                    },*/
                    
                    decoration: InputDecoration(
                      labelText: 'Kelime',
                    )
                    ),
              ),
      
      FlatButton
          (
            color: Colors.amberAccent,
            child: Text("Kelime Ara"),
            onPressed: ()
            {
             Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ArananKelime(catex: txtName.text,appAds3:appAds2),
            )
        );
             
            },
          )
    
        ],
      ),
      )
      
   
    );
  }

 
  void sil() async
    {
       Navigator.pop(context,true);
       var  result=await dbHelper.delete();
       
        if(result!=0)
        {
           AlertDialog alertDialog=new AlertDialog
                        (
                          title:Text("Silindi"),
                          content: Text("Hepsi Silindi"),
                        );
                        showDialog
                        (
                          context: context,
                          builder: (_)=>alertDialog
                        );
        }
    }




}