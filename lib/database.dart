import 'package:loto_app/models/api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchDataAndInsertToDatabase(date) async {
    
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
      
      // for (var bingo in parsedData.bingo5) {
      //  print("Bingo5 - Date: ${bingo.date}, Main Numbers: ${bingo.main1}, ${bingo.main2}, ${bingo.main3}, ${bingo.main4}, ${bingo.main5}, ${bingo.main6}, ${bingo.main7}, ${bingo.main8}");
      // }
    } else {
      print('APIエラー');
      return ;
    }
    // 2. SQLiteデータベースへの接続
    final database = await openDatabase('lotodata.db', version: 1,
        onCreate: (Database db, int version) async {
      // テーブルの作成
      await db.execute(
        'CREATE TABLE IF NOT EXISTS loto6(no INTEGER PRIMARY KEY, bonus TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS bingo(no INTEGER PRIMARY KEY, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT, main8 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS loto7(no INTEGER PRIMARY KEY, bonus1 TEXT, bonus2 TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS miniloto(no INTEGER PRIMARY KEY, bonus TEXT, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n3(no INTEGER PRIMARY KEY, date TEXT, n3 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n4(no INTEGER PRIMARY KEY, date TEXT, n4 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS qoo(no INTEGER PRIMARY KEY, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT)');
    });
    // 3. データの挿入
    for (final data in loto6Data) {
      await database.insert('loto6', data.toMap());
    }
    for (final data in bingoData) {
      await database.insert('bingo', data.toMap());
    }
    for (final data in loto7Data) {
      await database.insert('loto7', data.toMap());
    }
    for (final data in minilotoData) {
      await database.insert('miniloto', data.toMap());
    }
    for (final data in n3Data) {
      await database.insert('n3', data.toMap());
    }
    for (final data in n4Data) {
      await database.insert('n4', data.toMap());
    }
    for (final data in qooData) {
      await database.insert('qoo', data.toMap());
    }
    //　確認
    // final results = await database.query('loto6');
    // if (results.isNotEmpty) {
    //   for (final row in results) {
    //     print(row); // データベースから取得した行をコンソールに表示
    //   }
    // } else {
    //   print('データベースにはまだデータがありません。');
    // }
}

// Future<void> checkDatabaseContent() async {
//   final results = await database.query('loto6');
//   if (results.isNotEmpty) {
//     for (final row in results) {
//       print(row); // データベースから取得した行をコンソールに表示
//     }
//   } else {
//     print('データベースにはまだデータがありません。');
//   }
// }