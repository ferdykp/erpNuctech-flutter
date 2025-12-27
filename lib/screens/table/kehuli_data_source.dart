import 'package:flutter/material.dart';
import '../../models/kehuli_model.dart';

class KehuliDataSource extends DataTableSource {
  final List<Kehuli> data;
  final BuildContext context;
  final bool isMobile;

  KehuliDataSource({
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
        DataCell(Text(w.khlxrid.toString())),
        // DataCell(Text(w.picizhuangtai == 1 ? "Active" : "No")),
        DataCell(
          SizedBox(
            width: isMobile ? 80 : 300,
            child: Text(
              w.xingming,
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
              w.shouji,
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
  Widget _detailDialog(Kehuli w) {
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
            _row("Customer Contact ID", w.khlxrid.toString()),
            _row("Custom ID", w.khxxid.toString()),
            _row("Name", w.xingming),
            _row("Full Name", w.xingmingquanpin),
            _row("Gender ID", w.xiengbieid.toString()),
            _row("Telephone", w.dianhua),
            _row("Mobile Phone", w.shouji),
            _row("Email", w.youxiang),
            _row("Education Level", w.xlid.toString()),
            _row("Job Title", w.zhiwumingcheng),
            _row("Date of Birth", w.chushengriqi),
            _row("Remarks", w.beizhu.toString()),
            _row("Employment Status", w.shifouzaizhi == 1 ? 'Active' : 'No'),

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
