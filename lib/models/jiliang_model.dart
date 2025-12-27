class Jiliang {
  final int dwid;
  final String danweimingcheng;
  final int shifouyouxiao;
  final int rululenid;
  final String ruluriqi;
  final int xiugairenid;
  final String xiugaishijian;

  Jiliang({
    required this.dwid,
    required this.danweimingcheng,
    required this.shifouyouxiao,
    required this.rululenid,
    required this.ruluriqi,
    required this.xiugairenid,
    required this.xiugaishijian,
  });

  factory Jiliang.fromJson(Map<String, dynamic> json) {
    return Jiliang(
      dwid: json['DW_ID'],
      danweimingcheng: json['DanWeiMingCheng'],
      shifouyouxiao: json["ShiFouYouXiao"] == true ? 1 : 0,
      rululenid: json['RuLuRen_ID'],
      ruluriqi: json['RuLuRiQi'],
      xiugairenid: json['XiuGaiRen_ID'],
      xiugaishijian: json['XiuGaiShiJian'],
    );
  }
}
