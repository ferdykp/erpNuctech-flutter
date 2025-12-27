import 'package:flutter/material.dart';
import '../../models/warehouse_model.dart';

class WarehouseDataSource extends DataTableSource {
  final List<Warehouse> data;
  final BuildContext context;
  final bool isMobile;

  WarehouseDataSource({
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
        DataCell(Text(w.id.toString())),
        // DataCell(Text(w.picizhuangtai == 1 ? "Active" : "No")),
        DataCell(
          SizedBox(
            width: isMobile ? 80 : 300,
            child: Text(
              w.nama,
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
              w.fuZeRen,
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
  Widget _detailDialog(Warehouse w) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Warehouse Detail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _row("Warehouse ID", w.id.toString()),
              _row("Category", w.nama),
              _row("Area", w.quYuShu.toString()),
              _row("PIC", w.fuZeRen),
              _row("Size", w.luas.toString()),
              _row("Created Date", w.ruLuRiQi),
              _row("Updated Date", w.xiuGaiShiJian),

              const SizedBox(height: 24),
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
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
}
