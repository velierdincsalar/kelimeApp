import 'package:kelime/db/dbHelper.dart';
import 'package:kelime/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ProductAdd extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState()=> ProductAddState();
    
  }
  
class ProductAddState extends State
{
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
        title: Text("Kelime İşlemleri",style: TextStyle(color: Colors.black),),
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
          FlatButton
          (
            child: Text("Kelimeleri Kaydet"),
            
            onPressed: ()
            {
              save();
            },
          ),
            FlatButton
          (
            child: Text("Kelimeleri Sil"),
            onPressed: ()
            {
              sil();
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


   void save() async
    {
      int result ;
    String data = await getFileData("assets/user.txt");


     
  for (var line in data.split("|")) 
   {
     var icdata =line.split("*");
    result = await dbHelper.insert(Word(icdata[0],icdata[1],icdata[2]));
    }


   Navigator.pop(context,true);
        if(result!=0)
        {
           AlertDialog alertDialog=new AlertDialog
                        (
                          title:Text("Kaydedildi"),
                          content: Text("Hepsi Kaydedildi"),
                        );
                        showDialog
                        (
                          context: context,
                          builder: (_)=>alertDialog
                        );
        }
    }
Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}
}