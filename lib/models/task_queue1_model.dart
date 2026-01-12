class TaskQueue1Model {
  final int productionStatus;
  final String taskNo;
  final String productName;
  final String orderNo;
  final String customerName;
  final String submittedAt;

  final int quantity;
  final int shippedQuantity;
  final int remainingQuantity;

  final double sideA;
  final double sideB;
  final double sideC;

  final int loadFlag;

  TaskQueue1Model({
    required this.productionStatus,
    required this.taskNo,
    required this.productName,
    required this.orderNo,
    required this.customerName,
    required this.quantity,
    required this.shippedQuantity,
    required this.remainingQuantity,
    required this.sideA,
    required this.sideB,
    required this.sideC,
    required this.loadFlag,
    required this.submittedAt,
  });

  /// helper aman (int / double / string)
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  factory TaskQueue1Model.fromJson(Map<String, dynamic> json) {
    return TaskQueue1Model(
      productionStatus: _toInt(json['production_status']),
      taskNo: json['task_no'] ?? '',
      productName: json['product_name'] ?? '',
      orderNo: json['order_no'] ?? '',
      customerName: json['customer_name'] ?? '',

      quantity: _toInt(json['quantity']),
      shippedQuantity: _toInt(json['shipped_quantity']),
      remainingQuantity: _toInt(json['remaining_quantity']),
      submittedAt: json['submitted_at'] ?? '',

      sideA: _toDouble(json['side_a']),
      sideB: _toDouble(json['side_b']),
      sideC: _toDouble(json['side_c']),

      loadFlag: _toInt(json['load_flag']),
    );
  }
}
