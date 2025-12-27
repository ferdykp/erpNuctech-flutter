class Kehufu {
  final int khfzwhid;
  final int khxxid;
  final int fuzhaohuowuid;
  final int shokuanfangshiid;
  final double danjianfeiyong;
  final double fuzhaojiliang;

  Kehufu({
    required this.khfzwhid,
    required this.khxxid,
    required this.fuzhaohuowuid,
    required this.shokuanfangshiid,
    required this.danjianfeiyong,
    required this.fuzhaojiliang,
  });

  factory Kehufu.fromJson(Map<String, dynamic> json) {
    return Kehufu(
      khfzwhid: json['KHFZHW_ID'],
      khxxid: json['KHXX_ID'],
      fuzhaohuowuid: json['FuZhaoHuoWu_ID'],
      shokuanfangshiid: json['ShouKuanFangShi_ID'],
      danjianfeiyong: double.parse(json['DanJianFeiYong'].toString()),
      fuzhaojiliang: double.parse(json['FuZhaoJiLiang'].toString()),
    );
  }
}
