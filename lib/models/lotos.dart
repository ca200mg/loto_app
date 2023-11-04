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
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'main5': main5,
      'main6': main6,
      'main7': main7,
      'main8': main8,
      'no': no,
    };
  }

  factory Bingo.fromJson(Map<String, dynamic> json) {
    return Bingo(
      date: json['date'],
      main1: json['main1'],
      main2: json['main2'],
      main3: json['main3'],
      main4: json['main4'],
      main5: json['main5'],
      main6: json['main6'],
      main7: json['main7'],
      main8: json['main8'],
      no: json['no'],
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
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'main5': main5,
      'main6': main6,
      'no': no,
    };
  }

  factory Loto6.fromJson(Map<String, dynamic> json) {
    return Loto6(
      bonus: json['bonus'],
      date: json['date'],
      main1: json['main1'],
      main2: json['main2'],
      main3: json['main3'],
      main4: json['main4'],
      main5: json['main5'],
      main6: json['main6'],
      no: json['no'],
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
      'bonus1': bonus1,
      'bonus2': bonus2,
      'date': date,
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'main5': main5,
      'main6': main6,
      'main7': main7,
      'no': no,
    };
  }

  factory Loto7.fromJson(Map<String, dynamic> json) {
    return Loto7(
      bonus1: json['bonus1'],
      bonus2: json['bonus2'],
      date: json['date'],
      main1: json['main1'],
      main2: json['main2'],
      main3: json['main3'],
      main4: json['main4'],
      main5: json['main5'],
      main6: json['main6'],
      main7: json['main7'],
      no: json['no'],
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
      'bonus': bonus,
      'date': date,
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'main5': main5,
      'no': no,
    };
  }

  factory Miniloto.fromJson(Map<String, dynamic> json) {
    return Miniloto(
      bonus: json['bonus'],
      date: json['date'],
      main1: json['main1'],
      main2: json['main2'],
      main3: json['main3'],
      main4: json['main4'],
      main5: json['main5'],
      no: json['no'],
    );
  }
}

class N3 {
  String date;
  String n3;
  int no;

  N3({
    required this.date,
    required this.n3,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'n3': n3,
      'no': no,
    };
  }

  factory N3.fromJson(Map<String, dynamic> json) {
    return N3(
      date: json['date'],
      n3: json['n3'],
      no: json['no'],
    );
  }
}

class N4 {
  String date;
  String n4;
  int no;

  N4({
    required this.date,
    required this.n4,
    required this.no,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'n4': n4,
      'no': no,
    };
  }

  factory N4.fromJson(Map<String, dynamic> json) {
    return N4(
      date: json['date'],
      n4: json['n4'],
      no: json['no'],
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
      'main1': main1,
      'main2': main2,
      'main3': main3,
      'main4': main4,
      'no': no,
    };
  }

  factory Qoo.fromJson(Map<String, dynamic> json) {
    return Qoo(
      date: json['date'],
      main1: json['main1'],
      main2: json['main2'],
      main3: json['main3'],
      main4: json['main4'],
      no: json['no'],
    );
  }
}
