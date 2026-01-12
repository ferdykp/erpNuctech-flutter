import 'package:flutter/material.dart';
import '../../models/jiesuan_model.dart';

class JiesuanDataSource extends DataTableSource {
  final List<Jiesuan> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double paymentColWidth;
  final double statusColWidth;
  final double actionColWidth;

  JiesuanDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.paymentColWidth,
    required this.statusColWidth,
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
            width: idColWidth,
            child: Center(child: Text(w.jslxid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: paymentColWidth,
            child: Center(
              child: Text(w.jiesuanlei, textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: statusColWidth,
            child: Center(
              child: Text(
                w.shifouyouxiao == 1 ? "Active" : "No",
                textAlign: TextAlign.center,
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

  // ===== DETAIL DIALOG =====
  Widget _detailDialog(Jiesuan w) {
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
                "Batch Operation Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("ID", w.jslxid.toString()),
            _row("Payment", w.jiesuanlei),
            _row("Remarks", w.beizhu ?? "-"),
            _row("Is It Active", w.shifouyouxiao == 1 ? "Active" : "No"),
            _row("Created By (ID)", w.rululenid.toString()),
            _row("Created Date", w.ruluriqi),
            _row("Update By (ID)", w.xiugairenid?.toString() ?? "-"),
            _row("Update Time", w.xiugaishijian ?? "-"),

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
