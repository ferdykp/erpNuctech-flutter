class Fahuo {
  final int fhdid;
  final int fahuorenwushu;
  final int fahuozongbanshu;
  final int fahuozongjianshu;
  final String tihuoren;
  final String chepaihao;
  final String xianghao;
  final String chukukaishishijian;
  final String chukujhishishijan;
  final String cangguanyuan;
  final int fahuodanzhuangtai;
  final int rululenid;
  final String ruluriqi;
  final int xiugairenid;
  final String xiugaishijian;
  final String fahuodanbianjao;
  final String banyungong1;
  final String banyungong2;

  Fahuo({
    required this.fhdid,
    required this.fahuorenwushu,
    required this.fahuozongbanshu,
    required this.fahuozongjianshu,
    required this.tihuoren,
    required this.chepaihao,
    required this.xianghao,
    required this.chukukaishishijian,
    required this.chukujhishishijan,
    required this.cangguanyuan,
    required this.fahuodanzhuangtai,
    required this.rululenid,
    required this.ruluriqi,
    required this.xiugairenid,
    required this.xiugaishijian,
    required this.fahuodanbianjao,
    required this.banyungong1,
    required this.banyungong2,
  });

  factory Fahuo.fromJson(Map<String, dynamic> json) {
    return Fahuo(
      fhdid: json['FHD_ID'],
      fahuorenwushu: json['faHuoRenWuShu'],
      fahuozongbanshu: json['FaHuoZongBanShu'],
      fahuozongjianshu: json['FaHuoZongJianShu'],
      tihuoren: json['TiHuoRen'],
      chepaihao: json['ChePaiHao'],
      xianghao: json['XiangHao'],
      chukukaishishijian: json['ChuKuKaiShiShiJian'],
      chukujhishishijan: json['ChuKuJieShuShiJian'],
      cangguanyuan: json['CangGuanYuan'],
      fahuodanzhuangtai: json['FaHuoDanZhuangTai'],
      rululenid: json['RuLuRen_ID'],
      ruluriqi: json['RuLuRiQi'],
      xiugairenid: json['XiuGaiRen_ID'],
      xiugaishijian: json['XiuGaiShiJian'],
      fahuodanbianjao: json['faHuoDanBianHao'],
      banyungong1: json['BanYunGong1'],
      banyungong2: json['BanYunGong2'],
    );
  }
}
