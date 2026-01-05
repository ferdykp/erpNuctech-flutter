import 'package:flutter/material.dart';
import '../../models/process_manage_model.dart';

class ProcessManageDataSource extends DataTableSource {
  final List<ProcessManageModel> data;
  final BuildContext context;
  final bool isMobile;

  ProcessManageDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final w = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        // Order No
        DataCell(Text(w.orderNo)),

        // Customer Name
        DataCell(
          SizedBox(
            width: isMobile ? 100 : 220,
            child: Text(
              w.customerName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // Product Name
        DataCell(
          SizedBox(
            width: isMobile ? 100 : 220,
            child: Text(
              w.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // Task Status
        // DataCell(Text(_taskStatusLabel(w.taskStatus))),

        // Action
        DataCell(
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => _detailDialog(w));
            },
            child: const Text("Detail"),
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

  // ================= DETAIL DIALOG =================
  Widget _detailDialog(ProcessManageModel w) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
              _row("Batch No", w.batchNo ?? "-"),
              _row("Task Status", _taskStatusLabel(w.taskStatus)),
              _row("Quantity", w.quantity.toString()),
              _row("Min Dose", w.minDose.toString()),
              _row("Max Dose", w.maxDose.toString()),
              _row(
                "Dimension (L×W×H)",
                "${w.length} × ${w.width} × ${w.height}",
              ),
              _row("Weight", w.weight.toString()),
              _row("Density", w.density.toString()),
              _row("Submitted At", w.submittedAt),

              // _row("Created By", w.createdBy),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // ================= STATUS MAPPING =================
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
