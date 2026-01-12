import 'package:flutter/material.dart';
import '../../models/weituodan_model.dart';

class WeituodanDataSource extends DataTableSource {
  final List<Weituodan> data;
  final BuildContext context;
  final bool isMobile;

  final double orderColWidth;
  final double arrivalColWidth;
  final double actionColWidth;

  WeituodanDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.orderColWidth,
    required this.arrivalColWidth,
    required this.actionColWidth,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final w = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          SizedBox(
            width: orderColWidth,
            child: Center(
              child: Text(
                w.weituodanhao,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: arrivalColWidth,
            child: Center(
              child: Text(
                w.daohuoriqi,
                textAlign: TextAlign.center,
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: actionColWidth,
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

  // ================= DETAIL DIALOG =================
  Widget _detailDialog(Weituodan w) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Customer Order Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("Order Number", w.weituodanhao),
            _row("Status", w.weituodanzhuangtai.toString()),
            _row("Arrival", w.daohuoriqi),
            _row("Est. Finish", w.yujichu),
            _row("Quantity", w.zongshu.toString()),
            _row("Total", w.yingshou.toString()),
            _row("Paid", w.yishou.toString()),
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
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: Text("$title:")),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
