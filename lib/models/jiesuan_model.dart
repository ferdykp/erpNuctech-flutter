class Jiesuan {
  final int jslxid;
  final String jiesuanlei;
  final String? beizhu;
  final int shifouyouxiao;
  final int rululenid;
  final String ruluriqi;
  final int? xiugairenid;
  final String? xiugaishijian;

  Jiesuan({
    required this.jslxid,
    required this.jiesuanlei,
    this.beizhu,
    required this.shifouyouxiao,
    required this.rululenid,
    required this.ruluriqi,
    this.xiugairenid,
    this.xiugaishijian,
  });

  factory Jiesuan.fromJson(Map<String, dynamic> json) {
    return Jiesuan(
      jslxid: json['JSLX_ID'],
      jiesuanlei: json['JiSuanLeiXingMingCheng'] ?? '',
      beizhu: json['BeiZhu'],
      shifouyouxiao: json["ShiFouYouXiao"] == true ? 1 : 0,
      rululenid: json['RuLuRen_ID'],
      ruluriqi: json['RuLuRiQi']?.toString() ?? '',
      xiugairenid: json['XiuGaiRen_ID'],
      xiugaishijian: json['XiuGaiShiJian']?.toString(),
    );
  }
}
