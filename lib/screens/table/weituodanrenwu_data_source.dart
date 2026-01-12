import 'package:flutter/material.dart';
import '../../models/weituodanrenwu_model.dart';

class WeituodanrenwuDataSource extends DataTableSource {
  final List<Weituodanrenwu> data;
  final BuildContext context;
  final bool isMobile;

  final double idColWidth;
  final double nameColWidth;
  final double actionColWidth;

  WeituodanrenwuDataSource({
    required this.data,
    required this.context,
    required this.isMobile,
    required this.idColWidth,
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
            child: Center(
              child: Text(w.renwunhao.toString(), textAlign: TextAlign.center),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: nameColWidth,
            child: Center(
              child: Text(
                w.baozhuang,
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
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

  // ================= DETAIL DIALOG =================
  Widget _detailDialog(Weituodanrenwu w) {
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
                "Detail Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _row("ID Task", w.renwunhao.toString()),
            _row("Weight per Unit", w.danjianmao.toString()),
            _row("Weight Total", w.zongmao.toString()),
            _row("Packaging", w.baozhuang),
            _row("Dose Min", w.yaoqiuzuixiao.toString()),
            _row("Dose Max", w.yaoqiuzuidaiji.toString()),
            _row("Estimate", w.jine.toString()),
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
