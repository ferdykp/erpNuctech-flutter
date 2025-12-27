class Warehouse {
  final int id;
  final String nama;
  final int quYuShu;
  final String fuZeRen;
  final double luas;

  final String ruLuRiQi;
  final String xiuGaiShiJian;

  Warehouse({
    required this.id,
    required this.nama,
    required this.quYuShu,
    required this.fuZeRen,
    required this.luas,
    required this.ruLuRiQi,
    required this.xiuGaiShiJian,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json["CKJBXX_ID"] ?? 0,
      nama: json["CangKuMingCheng"] ?? "-",
      quYuShu: json["QuYuShu"] ?? 0,
      fuZeRen: json["FuZeRen"] ?? "-",
      luas: double.parse(json['MianJi'].toString()),
      ruLuRiQi: json["RuLuRiQi"] ?? "-",
      xiuGaiShiJian: json["XiuGaiShiJian"] ?? "-",
    );
  }
}

// class Warehouse {
//   final int id;
//   final String nama;
//   final double luas;
//   final String fuZeRen;
//   final int quYuShu;

//   Warehouse({
//     required this.id,
//     required this.nama,
//     required this.luas,
//     required this.fuZeRen,
//     required this.quYuShu,
//   });

//   factory Warehouse.fromJson(Map<String, dynamic> json) {
//     return Warehouse(
//       id: json["CKJBXX_ID"],
//       nama: json["CangKuMingCheng"],
//       luas: (json["MianJi"] as num).toDouble(),
//       fuZeRen: json["FuZeRen"] ?? "-",
//       quYuShu: json["QuYuShu"] ?? 0,
//     );
//   }
// }
