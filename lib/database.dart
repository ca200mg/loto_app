import 'package:intl/intl.dart';
import 'package:loto_app/models/api.dart';
import 'package:loto_app/models/lotos.dart';
import 'package:path/path.dart';
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
        'CREATE TABLE IF NOT EXISTS n3(no INTEGER PRIMARY KEY, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n4(no INTEGER PRIMARY KEY, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER, main4 INTEGER)');
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

// データを空の状態で新しいリストに挿入するためのメソッド
Map<String, dynamic> adjustData(Map<String, dynamic> originalData) {
  // データのコピーを作成
  Map<String, dynamic> adjustedData = Map.from(originalData);

  // noとdate以外の要素を空に設定
  adjustedData.forEach((key, value) {
    if (key != 'no' && key != 'date') {
      adjustedData[key] = ''; // 空の文字列、もしくはnullに設定する
    }
  });

  return adjustedData;
}

Future<void> loto6calculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  // 次の月曜日または木曜日を取得する関数
  DateTime getNextMondayOrThursday(DateTime date) {
    while (date.weekday != DateTime.monday && date.weekday != DateTime.thursday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextMondayOrThursday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextMondayOrThursday(after1.add(const Duration(days: 1)));
    }
  }
  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<Loto6> loto6Addss = [
      Loto6(
        no: no1,
        date: formatDate(after1),
        main1: '',
        main2: '',
        main3: '',
        main4: '',
        main5: '',
        main6: '',
        bonus: '',
      ),
  ];

  // Insert the calculated values into the 'loto6' table
  for (final loto6 in loto6Addss) {
  await database.insert('loto6', loto6.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> loto7calculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  //次の金曜日を取得する関数
  DateTime getNextFriday(DateTime date) {
  while (date.weekday != DateTime.friday) {
    date = date.add(const Duration(days: 1));
  }
  return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextFriday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextFriday(after1.add(const Duration(days: 1)));
    }
  }

  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<Loto7> loto7Addss = [
      Loto7(
        no: no1,
        date: formatDate(after1),
        main1: '',
        main2: '',
        main3: '',
        main4: '',
        main5: '',
        main6: '',
        main7: '',
        bonus1: '',
        bonus2: '',
      ),
  ];

  // Insert the calculated values into the 'loto6' table
  for (final loto7 in loto7Addss) {
  await database.insert('loto7', loto7.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> minilotoCalculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  //次の火曜日を取得する関数
  DateTime getNextTuesday(DateTime date) {
  while (date.weekday != DateTime.tuesday) {
    date = date.add(const Duration(days: 1));
  }
  return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextTuesday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextTuesday(after1.add(const Duration(days: 1)));
    }
  }

  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<Miniloto> minilotoAddss = [
      Miniloto(
        no: no1,
        date: formatDate(after1),
        main1: '',
        main2: '',
        main3: '',
        main4: '',
        main5: '',
        bonus: '',
      ),
  ];

  // Insert the calculated values into the 'loto6' table
  for (final miniloto in minilotoAddss) {
  await database.insert('miniloto', miniloto.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> n4CalculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  // 次の月曜日または木曜日を取得する関数
  DateTime getNextMondayOrThursday(DateTime date) {
    while (date.weekday != DateTime.monday 
            && date.weekday != DateTime.tuesday
            && date.weekday != DateTime.wednesday
            && date.weekday != DateTime.thursday
            && date.weekday != DateTime.friday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextMondayOrThursday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextMondayOrThursday(after1.add(const Duration(days: 1)));
    }
  }
  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<N4> n4Addss = [
      N4(
        no: no1,
        date: formatDate(after1),
        main1: 10,
        main2: 10,
        main3: 10,
        main4: 10,
      ),
  ];

  // Insert the calculated values into the 'n4' table
  for (final n4 in n4Addss) {
  await database.insert('n4', n4.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> n3CalculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  // 次の月曜日または木曜日を取得する関数
  DateTime getNextMondayOrThursday(DateTime date) {
    while (date.weekday != DateTime.monday 
            && date.weekday != DateTime.tuesday
            && date.weekday != DateTime.wednesday
            && date.weekday != DateTime.thursday
            && date.weekday != DateTime.friday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextMondayOrThursday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextMondayOrThursday(after1.add(const Duration(days: 1)));
    }
  }
  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<N3> n3Addss = [
      N3(
        no: no1,
        date: formatDate(after1),
        main1: 10,
        main2: 10,
        main3: 10,
      ),
  ];

  // Insert the calculated values into the 'n3' table
  for (final n3 in n3Addss) {
  await database.insert('n3', n3.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> qooCalculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  // 次の月曜日または木曜日を取得する関数
  DateTime getNextMondayOrThursday(DateTime date) {
    while (date.weekday != DateTime.monday 
            && date.weekday != DateTime.tuesday
            && date.weekday != DateTime.wednesday
            && date.weekday != DateTime.thursday
            && date.weekday != DateTime.friday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextMondayOrThursday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextMondayOrThursday(after1.add(const Duration(days: 1)));
    }
  }
  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<Qoo> qooAddss = [
      Qoo(
        no: no1,
        date: formatDate(after1),
        main1: '',
        main2: '',
        main3: '',
        main4: '',
      ),
  ];

  // Insert the calculated values into the 'n3' table
  for (final qoo in qooAddss) {
  await database.insert('qoo', qoo.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<void> bingoCalculateAfterDatesAndInsertData(String tableName, Database database) async {
  DateTime latestDate;
  DateTime after1;
  int latestNo;
  int no1;

  // 飛ばす日付の条件（12-31から01-03）
  bool shouldSkipDate(DateTime date) {
    return date.month == 12 && date.day >= 31 || date.month == 1 && date.day <= 3;
  }

  //次の火曜日を取得する関数
  DateTime getNextWednesday(DateTime date) {
  while (date.weekday != DateTime.wednesday) {
    date = date.add(const Duration(days: 1));
  }
  return date;
  }

  // 1. 最新の日付を取得
  final latestDateResult = await database.rawQuery('SELECT MAX(date) AS latestDate FROM $tableName');
  final latestDateStr = latestDateResult[0]['latestDate'] as String;
  latestDate = DateTime.parse(latestDateStr);

  // 2. after1の計算
  after1 = getNextWednesday(latestDate.add(const Duration(days: 1)));
  if (shouldSkipDate(after1)) {
    while(shouldSkipDate(after1)){
    after1 = getNextWednesday(after1.add(const Duration(days: 1)));
    }
  }

  // 最新のnoを取得
  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNoInt = latestNoResult[0]['latestNo'] as int;
  latestNo = latestNoInt;
  // no1の計算
  no1 = latestNo + 1;

  // Format DateTime objects to strings
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  print(latestNo);
  print('no1: $no1');


  print('Latest Date: $latestDate');
  print('After1: ${formatDate(after1)}');

  // データを作成し、テーブルへ挿入
  List<Bingo> bingoAddss = [
      Bingo(
        no: no1,
        date: formatDate(after1),
        main1: '',
        main2: '',
        main3: '',
        main4: '',
        main5: '',
        main6: '',
        main7: '',
        main8: '',
      ),
  ];

  // Insert the calculated values into the 'loto6' table
  for (final bingo in bingoAddss) {
  await database.insert('bingo', bingo.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore,);
  }
}

Future<int> checkNo(String tableName, Database databaseA, Database database) async {
  final currentNoResult = await databaseA.rawQuery('SELECT MAX(no) AS currentNo FROM $tableName');
  final currentNo = currentNoResult[0]['currentNo'];

  final latestNoResult = await database.rawQuery('SELECT MAX(no) AS latestNo FROM $tableName');
  final latestNo = latestNoResult[0]['latestNo'];

  // 取得した値が null でないかつ整数に変換可能か確認
  if (currentNo != null && latestNo != null) {
    final cNo = int.tryParse(currentNo.toString());
    final lNo = int.tryParse(latestNo.toString());

    // どちらも整数に変換可能なら比較
    if (cNo != null && lNo != null) {
    
      int value = lNo-cNo;
      switch(value){
        case 0:
          return 3;
        case 1:
          return 2;
        case 2:
          return 1;
        case 3:
          return 0;
        default:
          return 0;
      }
    }
  }

  // どちらかが整数に変換できなかった場合は false を返す
  return 0;
}

Future<void> fetchDataAndInsertToDatabaseC(date) async {
    
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
    final database = await openDatabase('lotodata_c.db', version: 1,
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
        'CREATE TABLE IF NOT EXISTS n3(no INTEGER PRIMARY KEY, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n4(no INTEGER PRIMARY KEY, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER, main4 INTEGER)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS qoo(no INTEGER PRIMARY KEY, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT)');
    });
    final databaseA = await openDatabase('lotodata.db');
    // 3. データの挿入
    for (final data in loto6Data) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('loto6', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('loto6', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await loto6calculateAfterDatesAndInsertData('loto6', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await loto6calculateAfterDatesAndInsertData('loto6', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await loto6calculateAfterDatesAndInsertData('loto6', database);}
        break;
      default:
        
        break;

    }
    
    for (final data in bingoData) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('bingo', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('bingo', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await bingoCalculateAfterDatesAndInsertData('bingo', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await bingoCalculateAfterDatesAndInsertData('bingo', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await bingoCalculateAfterDatesAndInsertData('bingo', database);}
        break;
      default:
        
        break;

    }

    for (final data in loto7Data) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('loto7', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('Loto7', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await loto7calculateAfterDatesAndInsertData('loto7', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await loto7calculateAfterDatesAndInsertData('loto7', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await loto7calculateAfterDatesAndInsertData('loto7', database);}
        break;
      default:
        
        break;

    }

    for (final data in minilotoData) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('miniloto', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('miniloto', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await minilotoCalculateAfterDatesAndInsertData('miniloto', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await minilotoCalculateAfterDatesAndInsertData('miniloto', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await minilotoCalculateAfterDatesAndInsertData('miniloto', database);}
        break;
      default:
        
        break;

    }
    for (final data in n3Data) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('n3', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('n3', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await n3CalculateAfterDatesAndInsertData('n3', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await n3CalculateAfterDatesAndInsertData('n3', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await n3CalculateAfterDatesAndInsertData('n3', database);}
        break;
      default:
        
        break;

    }

    for (final data in n4Data) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('n4', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('n4', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await n4CalculateAfterDatesAndInsertData('n4', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await n4CalculateAfterDatesAndInsertData('n4', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await n4CalculateAfterDatesAndInsertData('n4', database);}
        break;
      default:
        
        break;

    }
    for (final data in qooData) {
      var adjustedData = adjustData(data.toMap());
      await database.insert('qoo', adjustedData, conflictAlgorithm: ConflictAlgorithm.ignore,);
    }
    switch (await checkNo('qoo', databaseA, database)){
      case 0:
        
        break;
      case 1:
        for(int i=0; i<1; i++){await qooCalculateAfterDatesAndInsertData('qoo', database);}
        break;
      case 2:
        for(int i=0; i<2; i++){await qooCalculateAfterDatesAndInsertData('qoo', database);}
        break;
      case 3:
        for(int i=0; i<3; i++){await qooCalculateAfterDatesAndInsertData('qoo', database);}
        break;
      default:
        
        break;

    }

}

Future<void> setUserDatabase() async{
  print('setUserDatabase!');
  final database = await openDatabase('user_database.db', version: 1,
        onCreate: (Database db, int version) async {
      // テーブルの作成
      await db.execute(
        'CREATE TABLE IF NOT EXISTS loto6(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS bingo(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT, main8 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS loto7(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT, main6 TEXT, main7 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS miniloto(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT, main5 TEXT)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n3(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER, type INTEGER)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS n4(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 INTEGER, main2 INTEGER, main3 INTEGER, main4 INTEGER, type INTEGER)');
      await db.execute(
        'CREATE TABLE IF NOT EXISTS qoo(id INTEGER PRIMARY KEY, no INTEGER, date TEXT, main1 TEXT, main2 TEXT, main3 TEXT, main4 TEXT)');
    });
}

Future<void> deleteRecordById(int id, String tableName, String dbName) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), dbName);

  // データベースを開く
  Database database = await openDatabase(path);

  // 指定されたテーブルから指定された id のレコードを削除
  await database.delete(tableName, where: 'id = ?', whereArgs: [id]);

  // データベースを閉じる
  await database.close();
}