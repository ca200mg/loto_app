class Bingo {
  String date;
  String main1;
  String main2;
  String main3;
  String main4;
  String main5;
  String main6;
  String main7;
  String main8;
  int no;

  Bingo({
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.main5,
    required this.main6,
    required this.main7,
    required this.main8,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'main1': main1.toString(),
      'main2': main2.toString(),
      'main3': main3.toString(),
      'main4': main4.toString(),
      'main5': main5.toString(),
      'main6': main6.toString(),
      'main7': main7.toString(),
      'main8': main8.toString(),
      'no': no,
    };
  }

  factory Bingo.fromJson(Map<String, dynamic> json) {
    return Bingo(
      date: json['date'] as String,
      main1: json['main1'].toString(),
      main2: json['main2'].toString(),
      main3: json['main3'].toString(),
      main4: json['main4'].toString(),
      main5: json['main5'].toString(),
      main6: json['main6'].toString(),
      main7: json['main7'].toString(),
      main8: json['main8'].toString(),
      no: json['no'] as int,
    );
  }
}

class Loto6 {
  String bonus;
  String date;
  String main1;
  String main2;
  String main3;
  String main4;
  String main5;
  String main6;
  int no;

  Loto6({
    required this.bonus,
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.main5,
    required this.main6,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'bonus': bonus,
      'date': date,
      'main1': main1.toString(),
      'main2': main2.toString(),
      'main3': main3.toString(),
      'main4': main4.toString(),
      'main5': main5.toString(),
      'main6': main6.toString(),
      'no': no,
    };
  }

  factory Loto6.fromJson(Map<String, dynamic> json) {
    return Loto6(
      bonus: json['bonus'].toString(),
      date: json['date'] as String,
      main1: json['main1'].toString(),
      main2: json['main2'].toString(),
      main3: json['main3'].toString(),
      main4: json['main4'].toString(),
      main5: json['main5'].toString(),
      main6: json['main6'].toString(),
      no: json['no'] as int,
    );
  }
}

class Loto7 {
  String bonus1;
  String bonus2;
  String date;
  String main1;
  String main2;
  String main3;
  String main4;
  String main5;
  String main6;
  String main7;
  int no;

  Loto7({
    required this.bonus1,
    required this.bonus2,
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.main5,
    required this.main6,
    required this.main7,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'bonus1': bonus1.toString(),
      'bonus2': bonus2.toString(),
      'date': date,
      'main1': main1.toString(),
      'main2': main2.toString(),
      'main3': main3.toString(),
      'main4': main4.toString(),
      'main5': main5.toString(),
      'main6': main6.toString(),
      'main7': main7.toString(),
      'no': no,
    };
  }

  factory Loto7.fromJson(Map<String, dynamic> json) {
    return Loto7(
      bonus1: json['bonus1'].toString(),
      bonus2: json['bonus2'].toString(),
      date: json['date'] as String,
      main1: json['main1'].toString(),
      main2: json['main2'].toString(),
      main3: json['main3'].toString(),
      main4: json['main4'].toString(),
      main5: json['main5'].toString(),
      main6: json['main6'].toString(),
      main7: json['main7'].toString(),
      no: json['no'] as int,
    );
  }
}

class Miniloto {
  String bonus;
  String date;
  String main1;
  String main2;
  String main3;
  String main4;
  String main5;
  int no;

  Miniloto({
    required this.bonus,
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.main5,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'bonus': bonus.toString(),
      'date': date,
      'main1': main1.toString(),
      'main2': main2.toString(),
      'main3': main3.toString(),
      'main4': main4.toString(),
      'main5': main5.toString(),
      'no': no,
    };
  }

  factory Miniloto.fromJson(Map<String, dynamic> json) {
    return Miniloto(
      bonus: json['bonus'].toString(),
      date: json['date'] as String,
      main1: json['main1'].toString(),
      main2: json['main2'].toString(),
      main3: json['main3'].toString(),
      main4: json['main4'].toString(),
      main5: json['main5'].toString(),
      no: json['no'] as int,
    );
  }
}

class N3 {
  String date;
  int main1;
  int main2;
  int main3;
  int no;

  N3({
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'no': no,
    };
  }

  factory N3.fromJson(Map<String, dynamic> json) {
    return N3(
      date: json['date'] as String,
      main1: json['main1'] as int,
      main2: json['main2'] as int,
      main3: json['main3'] as int,
      no: json['no'] as int,
    );
  }
}

class N4 {
  String date;
  int main1;
  int main2;
  int main3;
  int main4;
  int no;

  N4({
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'no': no,
    };
  }

  factory N4.fromJson(Map<String, dynamic> json) {
    return N4(
      date: json['date'] as String,
      main1: json['main1'] as int,
      main2: json['main2'] as int,
      main3: json['main3'] as int,
      main4: json['main4'] as int,
      no: json['no'] as int,
    );
  }
}

class Qoo {
  String date;
  String main1;
  String main2;
  String main3;
  String main4;
  int no;

  Qoo({
    required this.date,
    required this.main1,
    required this.main2,
    required this.main3,
    required this.main4,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'main1': main1.toString(),
      'main2': main2.toString(),
      'main3': main3.toString(),
      'main4': main4.toString(),
      'no': no,
    };
  }

  factory Qoo.fromJson(Map<String, dynamic> json) {
    return Qoo(
      date: json['date'] as String,
      main1: json['main1'].toString(),
      main2: json['main2'].toString(),
      main3: json['main3'].toString(),
      main4: json['main4'].toString(),
      no: json['no'] as int,
    );
  }
}
