class Zuzhi {
  final int gszzjgid;
  final String zuozhimingcheng;
  final String lianxidianhua;
  final String fuzuren;
  final int shifouyouxiao;
  final int rululenid;
  final String ruluriqi;
  final int xiugairen;
  final String xiugaishijian;

  Zuzhi({
    required this.gszzjgid,
    required this.zuozhimingcheng,
    required this.lianxidianhua,
    required this.fuzuren,
    required this.shifouyouxiao,
    required this.rululenid,
    required this.ruluriqi,
    required this.xiugairen,
    required this.xiugaishijian,
  });

  factory Zuzhi.fromJson(Map<String, dynamic> json) {
    return Zuzhi(
      gszzjgid: json['GSZZJG_ID'],
      zuozhimingcheng: json['ZuoZhiMingCheng'],
      lianxidianhua: json['LianXiDianHua'] ?? "-",
      fuzuren: json['FuZeRen'] ?? "-",
      shifouyouxiao: json['ShiFouYouXiao'] == true ? 1 : 0,
      rululenid: json['RuLuRen_ID'],
      ruluriqi: json['RuLuRiQi'],
      xiugairen: json['XiuGaiRen_ID'],
      xiugaishijian: json['XiuGaiShiJian'],
    );
  }
}
