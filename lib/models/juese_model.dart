class Juese {
  final int xtjsid;
  final String juesemingcheng;
  final String juesemiaoshu;
  final int shifouyouxiao;

  Juese({
    required this.xtjsid,
    required this.juesemingcheng,
    required this.juesemiaoshu,
    required this.shifouyouxiao,
  });

  factory Juese.fromJson(Map<String, dynamic> json) {
    return Juese(
      xtjsid: json['XTJS_ID'],
      juesemingcheng: json['JueSeMingCheng'],
      juesemiaoshu: json['JueSeMiaoShu'],
      shifouyouxiao: json["ShiFouYouXiao"] == true ? 1 : 0,
    );
  }
}
