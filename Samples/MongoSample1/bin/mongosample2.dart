import 'package:mongo_dart/mongo_dart.dart';

main()
{
  Db db = new Db('mongodb://127.0.0.1/ted2');

  simpleUpdate()
  {
    DbCollection coll = db.collection('accounts');
    coll.remove();

    var account = {"user":"Kevin", "password": "feynman", "active": true, "loader": "demo"};

    coll.insert(account);

    String _User = "Kevin";

    coll.findOne({"user":_User}).then((v1)
//    coll.findOne({"user":"Kevin"}).then((v1)
    {
      print("Record c: $v1");
      v1["value"] = 31;
      coll.save(v1);
      return coll.findOne({"user":"Kevin"});
    }).then((v2){
      print("Record c after update: $v2");
      db.close();
    });
  };

  db.open().then((c)=>simpleUpdate());
}