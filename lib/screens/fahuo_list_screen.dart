import 'package:erp_nuctech/models/fahuo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/fahuo_provider.dart';

class FahuoListScreen extends StatefulWidget {
  const FahuoListScreen({super.key});

  @override
  State<FahuoListScreen> createState() => _FahuoListScreenState();
}

class _FahuoListScreenState extends State<FahuoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FahuoProvider>(context, listen: false).fetchFahuo();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FahuoProvider>(context);

    return BaseLayout(title: "Shipping Data", child: _buildBody(provider));
  }

  Widget _buildBody(FahuoProvider provider) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Text(
          provider.errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 14),
        ),
      );
    }

    if (provider.data.isEmpty) {
      return const Center(
        child: Text("No Data", style: TextStyle(fontSize: 14)),
      );
    }
    return _buildTable(provider);
  }

  Widget _buildTable(FahuoProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final fontSize = isMobile ? 12.0 : 14.0;
        final columnSpacing = isMobile ? 20.0 : 40.0;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              headingRowHeight: 46,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 64,
              columnSpacing: columnSpacing,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Operator")),
                DataColumn(label: Text("Operation Note")),
                DataColumn(label: Text("Action")),
              ],
              rows: provider.data.map((w) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        w.fhdid.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                    DataCell(
                      Text(w.tihuoren, style: TextStyle(fontSize: fontSize)),
                    ),
                    DataCell(
                      SizedBox(
                        width: isMobile ? 120 : 260,
                        child: Text(
                          w.cangguanyuan,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => _detailDialog(w),
                          );
                        },
                        child: const Text("Detail"),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _detailDialog(Fahuo w) {
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
                  "Fa Huo Detail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _detailRow("Fa Huo ID", w.fhdid.toString()),
              _detailRow("Task Count", w.fahuorenwushu.toString()),
              _detailRow("Total Packages", w.fahuozongbanshu.toString()),
              _detailRow("Total Items", w.fahuozongjianshu.toString()),
              _detailRow("Operator", w.tihuoren),
              _detailRow("Vehicle Plate", w.chepaihao),
              _detailRow("Box Number", w.xianghao),
              _detailRow("Start Time", w.chukukaishishijian),
              _detailRow("End Time", w.chukujhishishijan),
              _detailRow("Warehouse Staff", w.cangguanyuan),
              _detailRow("Status", w.fahuodanzhuangtai.toString()),
              _detailRow("Created By ID", w.rululenid.toString()),
              _detailRow("Created Date", w.ruluriqi),
              _detailRow("Updated By ID", w.xiugairenid.toString()),
              _detailRow("Updated Time", w.xiugaishijian),
              _detailRow("Fa Huo Code", w.fahuodanbianjao),
              _detailRow("Handler 1", w.banyungong1),
              _detailRow("Handler 2", w.banyungong2),

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

  Widget _detailRow(String title, String value) {
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

  //   return BaseLayout(
  //     title: "Fa Huo",
  //     child: provider.loading
  //         ? const Center(child: CircularProgressIndicator())
  //         : LayoutBuilder(
  //             builder: (context, constraints) {
  //               final isMobile = constraints.maxWidth < 600;

  //               final fontSize = isMobile ? 12.0 : 14.0;
  //               final columnSpacing = isMobile ? 20.0 : 40.0;

  //               return SingleChildScrollView(
  //                 scrollDirection: Axis.horizontal,
  //                 child: ConstrainedBox(
  //                   constraints: BoxConstraints(minWidth: constraints.maxWidth),
  //                   child: SingleChildScrollView(
  //                     scrollDirection: Axis.vertical,
  // child: DataTable(
  //   headingRowHeight: 46,
  //   dataRowMinHeight: 44,
  //   dataRowMaxHeight: 64,
  //   columnSpacing: columnSpacing,
  //   columns: const [
  //     DataColumn(label: Text("ID")),
  //     DataColumn(label: Text("Operator")),
  //     DataColumn(label: Text("Operation Note")),
  //     DataColumn(label: Text("Action")),
  //   ],
  //   rows: provider.data.map((w) {
  //     return DataRow(
  //       cells: [
  //         DataCell(
  //           Text(
  //             w.fhdid.toString(),
  //             style: TextStyle(fontSize: fontSize),
  //           ),
  //         ),
  //         DataCell(
  //           Text(
  //             w.tihuoren,
  //             style: TextStyle(fontSize: fontSize),
  //           ),
  //         ),
  //         DataCell(
  //           SizedBox(
  //             width: isMobile ? 120 : 260,
  //             child: Text(
  //               w.cangguanyuan,
  //               softWrap: true,
  //               overflow: TextOverflow.visible,
  //               style: TextStyle(fontSize: fontSize),
  //             ),
  //           ),
  //         ),
  //         DataCell(
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 8,
  //                 vertical: 8,
  //               ),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //             ),
  //             onPressed: () {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => _detailDialog(w),
  //               );
  //             },
  //             child: const Text("Detail"),
  //           ),
  //         ),
  //       ],
  //     );
  //   }).toList(),
  // ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //   );
  // }

  // ===================== DETAIL DIALOG =====================


