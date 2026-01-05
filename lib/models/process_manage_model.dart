class ProcessManageModel {
  final String orderNo;
  final String customerName;
  final String productName;
  final String? batchNo;
  final int taskStatus;
  final double minDose;
  final double maxDose;
  final int quantity;
  final double length;
  final double width;
  final double height;
  final double weight;
  final double density;
  final String submittedAt;
  final String createdBy;
  final String taskNo;

  ProcessManageModel({
    required this.orderNo,
    required this.customerName,
    required this.productName,
    this.batchNo,
    required this.taskStatus,
    required this.minDose,
    required this.maxDose,
    required this.quantity,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.density,
    required this.submittedAt,
    required this.createdBy,
    required this.taskNo,
  });

  factory ProcessManageModel.fromJson(Map<String, dynamic> json) {
    return ProcessManageModel(
      orderNo: json['order_no'] ?? '',
      customerName: json['customer_name'] ?? '',
      productName: json['product_name'] ?? '',
      batchNo: json['batch_no'],
      taskStatus: _toInt(json['task_status']),
      minDose: _toDouble(json['min_dose']),
      maxDose: _toDouble(json['max_dose']),
      quantity: _toInt(json['quantity']),
      length: _toDouble(json['length']),
      width: _toDouble(json['width']),
      height: _toDouble(json['height']),
      weight: _toDouble(json['weight']),
      density: _toDouble(json['density']),
      submittedAt: json['submitted_at'] ?? '',
      createdBy: json['created_by'] ?? '',
      taskNo: json['task_no'] ?? '',
    );
  }

  // ===== helpers =====
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
