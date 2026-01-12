import 'package:flutter/material.dart';
import '../../models/chanpinxian_model.dart';

class ChanpinxianDataSource extends DataTableSource {
  final List<ChanPinXian> data;
  final BuildContext context;
  final bool isMobile;

  final double idColWidth;
  final double productColWidth;
  final double functionColWidth;
  final double actionColWidth;

  ChanpinxianDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
    required this.productColWidth,
    required this.functionColWidth,
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
            child: Center(child: Text(w.id.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: productColWidth,
            child: Center(
              child: Text(w.namaProduksi, textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: functionColWidth,
            child: Center(child: Text(w.yongTu, textAlign: TextAlign.center)),
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
  Widget _detailDialog(ChanPinXian w) {
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
            _row("ID", w.id.toString()),
            _row("Production Name", w.namaProduksi),
            _row("Function", w.yongTu),
            _row("Created Date", w.ruLuRiQi),
            _row("Updated Time", w.xiuGaiShiJian),
            _row("Is Valid", w.shiFouYouXiao == 1 ? "Yes" : "No"),
            _row("Parameter K", w.k.toString()),
            _row("Parameter Ta", w.ta.toString()),
            _row("Parameter Tb", w.tb.toString()),
            _row("Parameter Tc", w.tc.toString()),
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
