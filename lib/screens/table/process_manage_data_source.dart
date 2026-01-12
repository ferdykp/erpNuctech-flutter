import 'package:flutter/material.dart';
import '../../models/process_manage_model.dart';

class ProcessManageDataSource extends DataTableSource {
  final List<ProcessManageModel> data;
  final BuildContext context;
  final bool isMobile;

  final double _orderColWidth;
  final double _customerColWidth;
  final double _actionColWidth;

  ProcessManageDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required double orderColWidth,
    required double customerColWidth,
    required double actionColWidth,
  }) : _orderColWidth = orderColWidth,
       _customerColWidth = customerColWidth,
       _actionColWidth = actionColWidth;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        // Order Number
        DataCell(
          SizedBox(
            width: _orderColWidth,
            child: Center(
              child: Text(
                item.orderNo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),

        // Customer
        DataCell(
          SizedBox(
            width: _customerColWidth,
            child: Center(
              child: Text(
                item.customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
                    builder: (_) => _detailDialog(item),
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

  // ================= DETAIL DIALOG =================
  Widget _detailDialog(ProcessManageModel item) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Process Detail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _row("Order No", item.orderNo),
              _row("Task No", item.taskNo),
              _row("Customer", item.customerName),
              _row("Product", item.productName),
              _row("Batch No", item.batchNo ?? "-"),
              _row("Status", _taskStatusLabel(item.taskStatus)),
              _row("Quantity", item.quantity.toString()),
              _row("Min Dose", item.minDose.toString()),
              _row("Max Dose", item.maxDose.toString()),
              _row(
                "Dimension (L×W×H)",
                "${item.length} × ${item.width} × ${item.height}",
              ),
              _row("Weight", item.weight.toString()),
              _row("Density", item.density.toString()),
              _row("Submitted At", item.submittedAt),

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
