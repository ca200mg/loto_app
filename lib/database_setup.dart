
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//データベースの存在確認
Future<void> checkIfDataExists() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'lotodata.db');
  bool fileExists = await databaseExists(path);

  if (fileExists) {
    Database database = await openDatabase(path);
    //データの存在確認
    List<Map<String, dynamic>> data = await database.query('your_table_name');
    if (data.isNotEmpty) {
      print('データが存在します。');
    } else {
      print('データはありません。');
    }
  } else {
    print('データベースファイルが見つかりません。');
  }
}

//データベースの作成
Future<void> makeDatabase() async {
  final database = await openDatabase('lotodata.db', version: 1,
        onCreate: (Database db, int version) async {
      // テーブルの作成
      await db.execute(
        'CREATE TABLE loto6(id INTEGER PRIMARY KEY, bonus TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE bingo(id INTEGER PRIMARY KEY, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT, main8 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE loto7(id INTEGER PRIMARY KEY, bonus1 TEXT, bonus2 TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE miniloto(id INTEGER PRIMARY KEY, bonus TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE n3(id INTEGER PRIMARY KEY, date TEXT, n3 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE n4(id INTEGER PRIMARY KEY, date TEXT, n4 TEXT, no INTEGER)');
      await db.execute(
        'CREATE TABLE qoo(id INTEGER PRIMARY KEY, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, no INTEGER)');
    });
}

//データのフェッチ
Future<void> fetchData(date) async {
    var loto6Data = [];
    var loto7Data = [];
    var bingoData = [];
    var minilotoData = [];
    var n3Data = [];
    var n4Data = [];
    var qooData = [];
    //1.http通信に必要なデータ
    //2.リクエストを送る
    final uri = Uri.https('appsicoded.com', 'get_loto_results', {
      'pw': 'doraemon810',
      'date': '$date',
    });
    final http.Response res = await http.get(uri, headers: {
      
    });
    if (res.statusCode == 200) {
      //3.戻り値をParseDataクラスの配列に変換
      //モデルクラスへの変換
      // JSON データをパースしてクラスに変換する
      final parsedData = ParsedData.fromJson(json.decode(res.body));
      // パースされたデータを使用する
      loto6Data = parsedData.loto6;
      loto7Data = parsedData.loto7;
      bingoData = parsedData.bingo5;
      minilotoData = parsedData.miniloto;
      n3Data = parsedData.n3;
      n4Data = parsedData.n4;
      qooData = parsedData.qoo;
      //for (var bingo in parsedData.bingo5) {
      //  debugPrint("Bingo5 - Date: ${bingo.date}, Main Numbers: ${bingo.main1}, ${bingo.main2}, ${bingo.main3}, ${bingo.main4}, ${bingo.main5}, ${bingo.main6}, ${bingo.main7}, ${bingo.main8}");
      //}
    } else {
      return ;
    }
}