import 'package:flutter/material.dart';
import '../../models/jiliang_model.dart';

class JiliangDataSource extends DataTableSource {
  final List<Jiliang> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double unitColWidth;
  final double statusColWidth;
  final double actionColWidth;

  JiliangDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.unitColWidth,
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
            child: Center(child: Text(w.dwid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: unitColWidth,
            child: Center(
              child: Text(w.danweimingcheng, textAlign: TextAlign.center),
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
  Widget _detailDialog(Jiliang w) {
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
                "Measurement Units Table",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("ID", w.dwid.toString()),
            _row("Unit Name", w.danweimingcheng),
            _row("Is It Active", w.shifouyouxiao == 1 ? "Active" : "No"),
            _row("Created By", w.rululenid.toString()),
            _row("Created Date", w.ruluriqi),
            _row("Update By (ID)", w.xiugairenid.toString()),
            _row("Update Time", w.xiugaishijian),

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
