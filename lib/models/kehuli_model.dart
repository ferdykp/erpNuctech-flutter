class Kehuli {
  final int khlxrid;
  final int khxxid;
  final String xingming;
  final String xingmingquanpin;
  final int xiengbieid;
  final String dianhua;
  final String shouji;
  final String youxiang;
  final int xlid;
  final String zhiwumingcheng;
  final String chushengriqi;
  final String beizhu;
  final int shifouzaizhi;

  Kehuli({
    required this.khlxrid,
    required this.khxxid,
    required this.xingming,
    required this.xingmingquanpin,
    required this.xiengbieid,
    required this.dianhua,
    required this.shouji,
    required this.youxiang,
    required this.xlid,
    required this.zhiwumingcheng,
    required this.chushengriqi,
    required this.beizhu,
    required this.shifouzaizhi,
  });

  /// ✅ HARUS static
  static int parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is bool) return v ? 1 : 0;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  factory Kehuli.fromJson(Map<String, dynamic> json) {
    return Kehuli(
      khlxrid: parseInt(json['KHLXR_ID']),
      khxxid: parseInt(json['KHXX_ID']),
      xingming: json['XingMing'] ?? '',
      xingmingquanpin: json['XingMingQuanPin'] ?? '',
      xiengbieid: parseInt(json['XingBie_ID']),
      dianhua: json['DianHua'] ?? '',
      shouji: json['ShouJi'] ?? '',
      youxiang: json['YouXiang'] ?? '',
      xlid: parseInt(json['XL_ID']),
      zhiwumingcheng: json['ZhiWuMingCheng'] ?? '',
      chushengriqi: json['ChuShengRiQi'] ?? '',
      beizhu: json['BeiZhu'] ?? '',
      shifouzaizhi: parseInt(json['ShiFouZaiZhi']),
    );
  }
}
