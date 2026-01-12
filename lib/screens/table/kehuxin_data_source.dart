import 'package:flutter/material.dart';
import '../../models/kehuxin_model.dart';

class KehuxinDataSource extends DataTableSource {
  final List<Kehuxin> data;
  final BuildContext context;
  final bool isMobile;
  final double idColWidth;
  final double customColWidth;
  final double nameColWidth;
  final double actionColWidth;

  KehuxinDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.customColWidth,
    required this.nameColWidth,
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
            child: Center(child: Text(w.khxxid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: customColWidth,
            child: Center(
              child: Text(w.kehujianma.toString(), textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: nameColWidth,
            child: Center(
              child: Text(w.kehumingcheng, textAlign: TextAlign.center),
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
  Widget _detailDialog(Kehuxin w) {
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
                "Customer Contact Person",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("ID", w.khxxid.toString()),
            _row("Custom Code", w.khxxid.toString()),
            _row("Name", w.kehumingcheng),
            _row("fax", w.dizhi),
            _row("Telephone", w.dianhua),
            _row("Address", w.chuanzenhao),

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
