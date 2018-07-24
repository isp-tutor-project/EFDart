import 'package:mongo_dart/mongo_dart.dart';

main()
{
  Db db = new Db('mongodb://127.0.0.1/TED');

  simpleUpdate()
  {
    DbCollection coll = db.collection('type1_groups');

    coll.findOne(where.eq("_id","ydrg")).then(printResult, onError:onQueryError);
  };

  db.open().then((c)=>simpleUpdate());
}

printResult(result)
{
  try
  {
    print("record: $result");
  }
  catch(err)
  {
    print('Error caught: $err');
  }
}

onQueryError(err)
{
  print("error: " + err);
}


