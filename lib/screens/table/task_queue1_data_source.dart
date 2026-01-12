import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task_queue1_model.dart';

class TaskQueue1DataSource extends DataTableSource {
  final List<TaskQueue1Model> data;
  final BuildContext context;
  final bool isMobile;

  final double _noOrderColWidth;
  final double _productColWidth;
  final double _actionColWidth;

  TaskQueue1DataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required double noOrderColWidth,
    required double productColWidth,
    required double actionColWidth,
  }) : _noOrderColWidth = noOrderColWidth,
       _productColWidth = productColWidth,
       _actionColWidth = actionColWidth {
    _sortDataByLatest();
  }

  void _sortDataByLatest() {
    // 1. Paksa locale ke 'en_US' agar mengerti "Tue", "Dec", dll.
    // 2. Gunakan 'z' atau kutip 'GMT' tergantung versi intl
    DateFormat inputFormat = DateFormat(
      "EEE, dd MMM yyyy HH:mm:ss 'GMT'",
      "en_US",
    );

    data.sort((a, b) {
      try {
        // Membersihkan whitespace berlebih jika ada
        DateTime dateA = inputFormat.parse(a.submittedAt.trim());
        DateTime dateB = inputFormat.parse(b.submittedAt.trim());

        return dateB.compareTo(dateA);
      } catch (e) {
        // Fallback: Jika gagal, coba gunakan DateTime.parse standar
        // atau biarkan di posisi bawah
        DateTime? fallbackA = DateTime.tryParse(a.submittedAt);
        DateTime? fallbackB = DateTime.tryParse(b.submittedAt);

        if (fallbackA != null && fallbackB != null) {
          return fallbackB.compareTo(fallbackA);
        }
        return 1;
      }
    });
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final w = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        // Order No
        // DataCell(Text(w.orderNo)),
        DataCell(
          SizedBox(
            width: _noOrderColWidth,
            child: Center(
              child: Text(w.orderNo, maxLines: 1, textAlign: TextAlign.center),
            ),
          ),
        ),

        // Product Name
        DataCell(
          SizedBox(
            width: _productColWidth,
            child: Center(
              child: Text(w.productName, textAlign: TextAlign.center),
            ),
          ),
        ),

        // Action
        DataCell(
          SizedBox(
            width: _actionColWidth,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => _detailDialog(w),
                  );
                },
                child: const Text("Detail"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;

  Widget _detailDialog(TaskQueue1Model w) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Process Detail",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _row("Order No", w.orderNo),
                _row("Task No", w.taskNo),
                _row("Customer", w.customerName),
                _row("Product", w.productName),
                _row("Status", _taskStatusLabel(w.productionStatus)),
                _row("Quantity", w.quantity.toString()),
                _row("Shipped Qty", w.shippedQuantity.toString()),
                _row("Remaining Qty", w.remainingQuantity.toString()),
                _row("Dimension", "${w.sideA} × ${w.sideB} × ${w.sideC}"),
                _row("Load Flag", w.loadFlag == 1 ? "Yes" : "No"),
                _row("Submitted At", w.submittedAt),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  String _taskStatusLabel(int status) {
    switch (status) {
      case 1:
        return "Created";
      case 5:
        return "Processing";
      case 9:
        return "Completed";
      default:
        return "Unknown";
    }
  }
}
