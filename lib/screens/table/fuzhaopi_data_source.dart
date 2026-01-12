import 'package:flutter/material.dart';
import '../../models/fuzhaopi_model.dart';

class FuzhaopiDataSource extends DataTableSource {
  final List<Fuzhaopi> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double statusColWidth;
  final double opsColWidth;
  final double actionColWidth;

  FuzhaopiDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.statusColWidth,
    required this.opsColWidth,
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
            child: Center(child: Text(w.pcczjlid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: statusColWidth,
            child: Center(
              child: Text(
                w.picizhuangtai == 1 ? "Active" : "No",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: opsColWidth,
            child: Center(
              child: Text(w.caozuoneirong, textAlign: TextAlign.center),
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
  Widget _detailDialog(Fuzhaopi w) {
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
            _row("Log ID", w.pcczjlid.toString()),
            _row("Batch Info ID", w.fzpcxxid.toString()),
            _row("Status", w.picizhuangtai == 1 ? "Active" : "No"),
            _row("Operation", w.caozuoneirong),
            _row("Operator", w.caozuoren),
            _row("Time", w.caozuoshijian),
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
