class Fuzhaopi {
  final int pcczjlid;
  final int fzpcxxid;
  final int picizhuangtai;
  final String caozuoneirong;
  final String caozuoren;
  final String caozuoshijian;

  Fuzhaopi({
    required this.pcczjlid,
    required this.fzpcxxid,
    required this.picizhuangtai,
    required this.caozuoneirong,
    required this.caozuoren,
    required this.caozuoshijian,
  });

  factory Fuzhaopi.fromJson(Map<String, dynamic> json) {
    return Fuzhaopi(
      pcczjlid: json['PCCZJL_ID'],
      fzpcxxid: json['FZPCXX_ID'],
      picizhuangtai: json['PiCiZhuangTai'],
      caozuoneirong: json['CaoZuoNeiRong'],
      caozuoren: json['CaoZuoRen'],
      caozuoshijian: json['CaoZuoShiJian'],
    );
  }
}
