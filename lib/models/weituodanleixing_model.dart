class Weituodanleixing {
  final int wtdlxid;
  final String weituodanlei;

  Weituodanleixing({required this.wtdlxid, required this.weituodanlei});

  factory Weituodanleixing.fromJson(Map<String, dynamic> json) {
    return Weituodanleixing(
      wtdlxid: json['WTDLX_ID'],
      weituodanlei: json['WeiTuoDanLeiXingMingCheng'],
    );
  }
}
