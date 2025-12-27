class Kehuxin {
  final int khxxid;
  final String kehujianma;
  final String kehumingcheng;
  final String dizhi;
  final String dianhua;
  final String chuanzenhao;

  Kehuxin({
    required this.khxxid,
    required this.kehujianma,
    required this.kehumingcheng,
    required this.dizhi,
    required this.dianhua,
    required this.chuanzenhao,
  });

  factory Kehuxin.fromJson(Map<String, dynamic> json) {
    return Kehuxin(
      khxxid: json['KHXX_ID'] ?? '',
      kehujianma: json['KeHuJianMa'] ?? '',
      kehumingcheng: json['KeHuMingCheng'] ?? '',
      dizhi: json['DiZhi'] ?? '',
      dianhua: json['DianHua'] ?? '',
      chuanzenhao: json['ChuanZhenHao'] ?? '',
    );
  }
}
