class Fuzhao {
  final int fjllxid;
  final String mingcheng;
  final int shifouyouxiao;
  final int rululenid;
  final String ruluriqi;
  final String xiugairenid;
  final String xiugaishijian;

  Fuzhao({
    required this.fjllxid,
    required this.mingcheng,
    required this.shifouyouxiao,
    required this.rululenid,
    required this.ruluriqi,
    required this.xiugairenid,
    required this.xiugaishijian,
  });

  factory Fuzhao.fromJson(Map<String, dynamic> json) {
    return Fuzhao(
      fjllxid: json['FJLLX_ID'],
      mingcheng: json['MingCheng'],
      shifouyouxiao: json['ShiFouYouXiao'],
      rululenid: json['RuLuRen_ID'],
      ruluriqi: json['RuLuRiQi'],
      xiugairenid: json['XiuGaiRen_ID'],
      xiugaishijian: json['XiuGaiShiJian'],
    );
  }
}
