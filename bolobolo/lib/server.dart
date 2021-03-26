import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  //TODO Log into database
  final db = await Db.create(
      'mongodb+srv://andri:firnandius@cluster0.tg3tn.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('hargajual');

  //TODO Create Server
  const port = 8081;
  final serv = Sevr();

  serv.get('/', [
    (ServRequest req, ServResponse res) async {
      final hargajual = await coll.find().toList();
      return res.status(200).json({'hargajual': hargajual});
    }
  ]);

  serv.post('/', [
    (ServRequest req, ServResponse res) async {
      await coll.save(req.body);
      return res.json(await coll.findOne(where.eq('name', req.body['name'])));
    }
  ]);

  serv.delete('/id', [
    (ServRequest req, ServResponse res) async {
      await coll
          .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
      return res.status(200);
    }
  ]);

  // TODO Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}
