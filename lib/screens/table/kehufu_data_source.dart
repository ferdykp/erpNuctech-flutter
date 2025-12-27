import 'package:flutter/material.dart';
import '../../models/kehufu_model.dart';

class KehufuDataSource extends DataTableSource {
  final List<Kehufu> data;
  final BuildContext context;
  final bool isMobile;

  KehufuDataSource({
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
        DataCell(Text(w.khfzwhid.toString())),
        // DataCell(Text(w.picizhuangtai == 1 ? "Active" : "No")),
        DataCell(
          SizedBox(
            width: isMobile ? 80 : 300,
            child: Text(
              w.shokuanfangshiid.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // <<< PENTING
              textAlign: TextAlign.center,
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: isMobile ? 110 : 300,
            child: Text(
              w.fuzhaojiliang.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // <<< PENTING
              textAlign: TextAlign.center,
            ),
          ),
        ),
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

  // ===== DETAIL DIALOG =====
  Widget _detailDialog(Kehufu w) {
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
                "User Roles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("Custom Irradiated ID", w.khfzwhid.toString()),
            _row("Custom ID", w.khxxid.toString()),
            _row("Irradiated ID", w.fuzhaohuowuid.toString()),
            _row("Payment Method ID", w.shokuanfangshiid.toString()),
            _row("Cost Per Unit", w.danjianfeiyong.toString()),
            _row("Quantity", w.fuzhaojiliang.toString()),

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
