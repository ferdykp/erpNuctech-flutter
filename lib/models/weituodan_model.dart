class Weituodan {
  final String weituodanhao;
  final int weituodanzhuangtai;
  final String daohuoriqi;
  final String yujichu;
  final int zongshu;
  final double yingshou;
  final double yishou;

  Weituodan({
    required this.weituodanhao,
    required this.weituodanzhuangtai,
    required this.daohuoriqi,
    required this.yujichu,
    required this.zongshu,
    required this.yingshou,
    required this.yishou,
  });

  factory Weituodan.fromJson(Map<String, dynamic> json) {
    return Weituodan(
      weituodanhao: json['WeiTuoDanHao'],
      weituodanzhuangtai: json['WeiTuoDanZhuangTai'],
      daohuoriqi: json['DaoHuoRiQi'],
      yujichu: json['YuJiChuHuoShiJian'],
      zongshu: json['ZongShuLiang'],
      yingshou: double.parse(json['YingShouZongJinE'].toString()),
      yishou: double.parse(json['YiShouJinE'].toString()),
    );
  }
}
