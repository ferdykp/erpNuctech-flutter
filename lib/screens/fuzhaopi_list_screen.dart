// import 'package:erp_nuctech/models/fuzhaopi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/fuzhaopi_data_source.dart'; // <<< DITAMBAHKAN
import '../layouts/base_layout.dart';
import '../providers/fuzhaopi_provider.dart';

class FuzhaopiListScreen extends StatefulWidget {
  const FuzhaopiListScreen({super.key});

  @override
  State<FuzhaopiListScreen> createState() => _FuzhaopiListScreenState();
}

class _FuzhaopiListScreenState extends State<FuzhaopiListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FuzhaopiProvider>(context, listen: false).fetchFuzhaopi();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FuzhaopiProvider>(context);

    return BaseLayout(
      title: "Radiation Conlusion",
      child: _buildBody(provider),
    );
  }

  Widget _buildBody(FuzhaopiProvider provider) {
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
        child: Text("No data", style: TextStyle(fontSize: 14)),
      );
    }

    return _buildTable(provider);
  }

  Widget _buildTable(FuzhaopiProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: DataTableTheme(
            data: const DataTableThemeData(
              dataRowMinHeight: 36, // <<< TAMBAHKAN
              dataRowMaxHeight: 58, // <<< TAMBAHKAN
            ),
            child: PaginatedDataTable(
              header: const Text("Radiation Batch Operation Logs"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("Log ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Batch Status",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 120, // ⬅️ atur lebar header
                    child: Text(
                      "Operation Description",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // DataColumn(label: Text("Action")),
                DataColumn(
                  label: Center(
                    child: Text(
                      "Action",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
              source: FuzhaopiDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildTable(FuzhaopiProvider provider) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final isMobile = constraints.maxWidth < 600;
  //       final fontSize = isMobile ? 12.0 : 14.0;
  //       final columnSpacing = isMobile ? 20.0 : 40.0;

  //       return SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(minWidth: constraints.maxWidth),
  //           child: DataTable(
  //             headingRowHeight: 46,
  //             dataRowMinHeight: 44,
  //             dataRowMaxHeight: 64,
  //             columnSpacing: columnSpacing,
  //             columns: const [
  //               DataColumn(label: Text("Log ID")),
  //               DataColumn(label: Text("Batch Status")),
  //               DataColumn(label: Text("Operation Desc")),
  //               DataColumn(label: Text("Action")),
  //             ],
  //             rows: provider.data.map((w) {
  //               return DataRow(
  //                 cells: [
  //                   DataCell(
  //                     Text(
  //                       w.pcczjlid.toString(),
  //                       style: TextStyle(fontSize: fontSize),
  //                     ),
  //                   ),
  //                   DataCell(
  //                     SizedBox(
  //                       width: isMobile ? 80 : 260,
  //                       child: Text(
  //                         w.picizhuangtai == 1 ? "Active" : "No",
  //                         softWrap: true,
  //                         overflow: TextOverflow.visible,
  //                         style: TextStyle(fontSize: fontSize),
  //                       ),
  //                     ),
  //                   ),
  //                   // DataCell(
  //                   //   Text(w.mingcheng, style: TextStyle(fontSize: fontSize)),
  //                   // ),
  //                   DataCell(
  //                     Text(
  //                       w.caozuoneirong,
  //                       style: TextStyle(fontSize: fontSize),
  //                     ),
  //                   ),

  //                   DataCell(
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         padding: const EdgeInsets.symmetric(
  //                           horizontal: 10,
  //                           vertical: 8,
  //                         ),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                       ),
  //                       onPressed: () {
  //                         showDialog(
  //                           context: context,
  //                           builder: (_) => _detailDialog(w),
  //                         );
  //                       },
  //                       child: const Text("Detail"),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _detailDialog(Fuzhaopi w) {
  //   return Dialog(
  //     insetPadding: const EdgeInsets.all(16),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Center(
  //               child: Text(
  //                 "Production Line Detail",
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             const SizedBox(height: 20),

  //             _detailRow("Batch Operation Log ID", w.pcczjlid.toString()),
  //             _detailRow("Radiation Batch Info ID", w.fzpcxxid.toString()),
  //             _detailRow(
  //               "Batch Status",
  //               w.picizhuangtai == 1 ? "Active" : "No",
  //             ),
  //             _detailRow("Operation Description", w.caozuoneirong),
  //             _detailRow("Operator", w.caozuoren),
  //             _detailRow("Operation Time", w.caozuoshijian),

  //             const SizedBox(height: 24),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: ElevatedButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text("Close"),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _detailRow(String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 150,
  //           child: Text(
  //             "$title:",
  //             style: const TextStyle(fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //         Expanded(child: Text(value)),
  //       ],
  //     ),
  //   );
  // }
}
