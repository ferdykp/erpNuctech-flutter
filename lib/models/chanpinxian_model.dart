class ChanPinXian {
  final int id;
  final String namaProduksi;
  final String yongTu;
  final String ruLuRiQi;
  final String xiuGaiShiJian;
  final int shiFouYouXiao;
  final double k;
  final double ta;
  final double tb;
  final double tc;

  ChanPinXian({
    required this.id,
    required this.namaProduksi,
    required this.yongTu,
    required this.ruLuRiQi,
    required this.xiuGaiShiJian,
    required this.shiFouYouXiao,
    required this.k,
    required this.ta,
    required this.tb,
    required this.tc,
  });

  factory ChanPinXian.fromJson(Map<String, dynamic> json) {
    return ChanPinXian(
      id: json["CPX_ID"],
      namaProduksi: json["ChanPinXian"],
      yongTu: json["YongTu"] ?? "-",
      ruLuRiQi: json["RuLuRiQi"] ?? "-",
      xiuGaiShiJian: json["XiuGaiShiJian"] ?? "-",
      shiFouYouXiao: json["ShiFouYouXiao"] ?? 0,
      k: (json["K"] ?? 0).toDouble(),
      ta: (json["Ta"] ?? 0).toDouble(),
      tb: (json["Tb"] ?? 0).toDouble(),
      tc: (json["Tc"] ?? 0).toDouble(),
    );
  }
}
