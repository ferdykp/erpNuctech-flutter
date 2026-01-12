import 'package:flutter/material.dart';
import '../../models/juese_model.dart';

class JueseDataSource extends DataTableSource {
  final List<Juese> data;
  final BuildContext context;
  final bool isMobile;

  final double _idColWidth;
  final double _nameColWidth;
  final double _actionColWidth;

  JueseDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required double idColWidth,
    required double nameColWidth,
    required double actionColWidth,
  }) : _idColWidth = idColWidth,
       _nameColWidth = nameColWidth,
       _actionColWidth = actionColWidth;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final w = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text(w.xtjsid.toString())),
        DataCell(
          SizedBox(
            width: _idColWidth,
            child: Center(child: Text(w.xtjsid.toString())),
          ),
        ),
        DataCell(
          SizedBox(
            width: _nameColWidth,
            child: Center(
              child: Text(w.juesemingcheng, textAlign: TextAlign.center),
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: _actionColWidth,
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
  Widget _detailDialog(Juese w) {
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
            _row("ID", w.xtjsid.toString()),
            _row("Role Name", w.juesemingcheng),
            _row("Role Description", w.juesemiaoshu.toString()),
            _row("Is It Active", w.shifouyouxiao == 1 ? "Active" : "No"),

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
