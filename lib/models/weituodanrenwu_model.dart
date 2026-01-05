class Weituodanrenwu {
  final String renwunhao;
  final double zongtiji;
  final double danjianmao;
  final double zongmao;
  final String baozhuang;
  final double yaoqiuzuixiao;
  final double yaoqiuzuidaiji;
  final double danjia;
  final double zhekou;
  final double jine;

  Weituodanrenwu({
    required this.renwunhao,
    required this.zongtiji,
    required this.danjianmao,
    required this.zongmao,
    required this.baozhuang,
    required this.yaoqiuzuixiao,
    required this.yaoqiuzuidaiji,
    required this.danjia,
    required this.zhekou,
    required this.jine,
  });

  factory Weituodanrenwu.fromJson(Map<String, dynamic> json) {
    return Weituodanrenwu(
      renwunhao: json['RenWuHao'],
      zongtiji: double.parse(json['ZongTiJi'].toString()),
      danjianmao: double.parse(json['DanJianMaoZhong'].toString()),
      zongmao: double.parse(json['ZongMaoZhong'].toString()),
      baozhuang: json['BaoZhuangGuiGe'],
      yaoqiuzuixiao: double.parse(json['YaoQiuZuiXiaoJiLiang']),
      yaoqiuzuidaiji: double.parse(json['YaoQiuZuiDaJiLiang'].toString()),
      danjia: double.parse(json['DanJia'].toString()),
      zhekou: double.parse(json['ZheKou'].toString()),
      jine: double.parse(json['JinE'].toString()),
    );
  }
}
