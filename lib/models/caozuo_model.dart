class CaoZuo {
  final int czrzid;
  final String caozuoren;
  final String caozuoshijan;
  final String caozuoneirong;
  final String caozuogongneng;

  CaoZuo({
    required this.czrzid,
    required this.caozuoren,
    required this.caozuoshijan,
    required this.caozuoneirong,
    required this.caozuogongneng,
  });

  factory CaoZuo.fromJson(Map<String, dynamic> json) {
    return CaoZuo(
      czrzid: json["CZRZID"],
      caozuoren: json["CaoZuoRen"],
      caozuoshijan: json["CaoZuoShiJian"],
      caozuoneirong: json["CaoZuoNeiRong"],
      caozuogongneng: json["CaoZuoGongNeng"],
    );
  }
}
