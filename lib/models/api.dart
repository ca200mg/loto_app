import 'package:loto_app/models/lotos.dart';

class ParsedData {
  List<Bingo> bingo5;
  List<Loto6> loto6;
  List<Loto7> loto7;
  List<Miniloto> miniloto;
  List<N3> n3;
  List<N4> n4;
  List<Qoo> qoo;

  ParsedData({
    required this.bingo5,
    required this.loto6,
    required this.loto7,
    required this.miniloto,
    required this.n3,
    required this.n4,
    required this.qoo,
  });

  factory ParsedData.fromJson(Map<String, dynamic> json) {
    return ParsedData(
      bingo5: List<Bingo>.from(json['bingo'].map((x) => Bingo.fromJson(x))),
      loto6: List<Loto6>.from(json['loto6'].map((x) => Loto6.fromJson(x))),
      loto7: List<Loto7>.from(json['loto7'].map((x) => Loto7.fromJson(x))),
      miniloto: List<Miniloto>.from(json['miniloto'].map((x) => Miniloto.fromJson(x))),
      n3: List<N3>.from(json['n3'].map((x) => N3.fromJson(x))),
      n4: List<N4>.from(json['n4'].map((x) => N4.fromJson(x))),
      qoo: List<Qoo>.from(json['qoo'].map((x) => Qoo.fromJson(x))),
    );
  }
}