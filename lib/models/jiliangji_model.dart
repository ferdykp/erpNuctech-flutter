class Jiliangji {
  final int jljlxid;
  final String jiliangjileixing;
  final String jiliangjibianhao;
  final int shifouyouxiao;
  final int xuhao;

  Jiliangji({
    required this.jljlxid,
    required this.jiliangjileixing,
    required this.jiliangjibianhao,
    required this.shifouyouxiao,
    required this.xuhao,
  });

  factory Jiliangji.fromJson(Map<String, dynamic> json) {
    return Jiliangji(
      jljlxid: json['JLJLX_ID'],
      jiliangjileixing: json['JiLiangJiLeiXing'],
      jiliangjibianhao: json['JiLiangJiBianHao'],
      shifouyouxiao: json["ShiFouYouXiao"] == true ? 1 : 0,
      xuhao: json['XuHao'],
    );
  }
}
