import 'package:flutter/material.dart';
import '../../models/jiliangji_model.dart';

class JiliangjiDataSource extends DataTableSource {
  final List<Jiliangji> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double typeColWidth;
  final double seriColWidth;
  final double actionColWidth;

  JiliangjiDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.typeColWidth,
    required this.seriColWidth,
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
            child: Center(child: Text(w.jljlxid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: typeColWidth,
            child: Center(
              child: Text(w.jiliangjileixing, textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: seriColWidth,
            child: Center(
              child: Text(w.jiliangjibianhao, textAlign: TextAlign.center),
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
  Widget _detailDialog(Jiliangji w) {
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
            _row("ID", w.jljlxid.toString()),
            _row("Dosimeter Type", w.jiliangjileixing),
            _row("Dosimeter Serial Number", w.jiliangjibianhao),
            _row("Dosimeter Serial Number", w.shifouyouxiao.toString()),
            _row("Sequence Number", w.xuhao.toString()),

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
