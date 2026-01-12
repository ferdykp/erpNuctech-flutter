import 'package:flutter/material.dart';
import '../../models/fuzhaojielunleixing_model.dart';

class FuzhaoDataSource extends DataTableSource {
  final List<Fuzhao> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double catColWidth;
  final double validColWidth;
  final double actionColWidth;

  FuzhaoDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.catColWidth,
    required this.validColWidth,
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
            child: Center(child: Text(w.fjllxid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: catColWidth,
            child: Center(
              child: Text(w.mingcheng, textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: validColWidth,
            child: Center(
              child: Text(
                w.shifouyouxiao == 1 ? "Yes" : "No",
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
  Widget _detailDialog(Fuzhao w) {
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
            _row("ID", w.fjllxid.toString()),
            _row("Category", w.mingcheng),
            _row("Is Valid", w.shifouyouxiao == 1 ? "Yes" : "No"),
            _row("Created By (User ID)", w.rululenid.toString()),
            _row("Created Date", w.ruluriqi),
            _row("Updated By (User ID)", w.xiugairenid.toString()),
            _row("Updated At", w.xiugaishijian),
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
