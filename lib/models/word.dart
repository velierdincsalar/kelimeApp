class Word
{
  int _id;
  String _eng;
  String _tr;
  String _cate;

  Word (this._eng,this._tr,this._cate);
  Word.withId(this._id,this._eng,this._tr,this._cate);
  
  int get id => _id;
  String get eng => _eng;
  String get tr => _tr;
  String get cate => _cate;

  set eng(String value)
  {
    if(value.length>1)
    {
      _eng=value;
    }
  }

  set tr(String value)
  {
    if(value.length>1)
    {
      _tr=value;
    }
  }

  set cate(String value)
  {
    if(value.length>1)
    {
      _cate=value;
    }
  }

  Map <String,dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["eng"]=_eng;
    map["tr"]=_tr;
     map["cate"]=_cate;

     if(_id != null)
     {
       map["id"]=_id;
     }
    return map;
  }

  Word.fromObject(dynamic o)
  {
    this._id= o["Id"];
     this._eng= o["Eng"];
      this._tr= o["Tr"];
       this._cate= o["Cate"];
  }
}


