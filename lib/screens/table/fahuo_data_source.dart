import 'package:flutter/material.dart';
import '../../models/fahuo_model.dart';

class FahuoDataSource extends DataTableSource {
  final List<Fahuo> data;
  final BuildContext context;
  final bool isMobile;

  FahuoDataSource({
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
        DataCell(Text(w.fhdid.toString())),
        // DataCell(Text(w.picizhuangtai == 1 ? "Active" : "No")),
        DataCell(
          SizedBox(
            width: isMobile ? 80 : 300,
            child: Text(
              w.tihuoren,
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
              w.cangguanyuan,
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
  Widget _detailDialog(Fahuo w) {
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
            _row("Fa Huo ID", w.fhdid.toString()),
            _row("Task Count", w.fahuorenwushu.toString()),
            _row("Total Packages", w.fahuozongbanshu.toString()),
            _row("Total Items", w.fahuozongjianshu.toString()),
            _row("Operator", w.tihuoren),
            _row("Vehicle Plate", w.chepaihao),
            _row("Box Number", w.xianghao),
            _row("Start Time", w.chukukaishishijian),
            _row("End Time", w.chukujhishishijan),
            _row("Warehouse Staff", w.cangguanyuan),
            _row("Status", w.fahuodanzhuangtai.toString()),
            _row("Created By ID", w.rululenid.toString()),
            _row("Created Date", w.ruluriqi),
            _row("Updated By ID", w.xiugairenid.toString()),
            _row("Updated Time", w.xiugaishijian),
            _row("Fa Huo Code", w.fahuodanbianjao),
            _row("Handler 1", w.banyungong1),
            _row("Handler 2", w.banyungong2),
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
