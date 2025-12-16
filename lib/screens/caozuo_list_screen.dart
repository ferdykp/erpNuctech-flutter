import 'package:erp_nuctech/models/caozuo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/caozuo_provider.dart';

class CaozuoListScreen extends StatefulWidget {
  const CaozuoListScreen({super.key});

  @override
  State<CaozuoListScreen> createState() => _CaozuoListScreenState();
}

class _CaozuoListScreenState extends State<CaozuoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CaozuoProvider>(context, listen: false).fetchCaoZuo();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CaozuoProvider>(context);
    return BaseLayout(title: "Testing", child: _buildBody(provider));
  }

  Widget _buildBody(CaozuoProvider provider) {
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

  Widget _buildTable(CaozuoProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final fontSize = isMobile ? 12.0 : 14.0;
        final columnSpacing = isMobile ? 20.0 : 40.0;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowHeight: 46,
                dataRowMinHeight: 44,
                dataRowMaxHeight: 104,
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
                          w.czrzid.toString(),
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                      DataCell(
                        Text(w.caozuoren, style: TextStyle(fontSize: fontSize)),
                      ),
                      DataCell(
                        SizedBox(
                          width: isMobile ? 140 : 280,
                          child: Text(
                            w.caozuoneirong,
                            maxLines: 3,
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
                              horizontal: 10,
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
          ),
        );
      },
    );
  }

  //   return BaseLayout(
  //     title: "Operation Log",
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
  //                     child: DataTable(
  //                       headingRowHeight: 46,
  //                       dataRowMinHeight: 44,
  //                       dataRowMaxHeight: 104,
  //                       columnSpacing: columnSpacing,
  //                       columns: const [
  //                         DataColumn(label: Text("ID")),
  //                         DataColumn(label: Text("Operator")),
  //                         DataColumn(label: Text("Operation Note")),
  //                         DataColumn(label: Text("Action")),
  //                       ],
  //                       rows: provider.data.map((w) {
  //                         return DataRow(
  //                           cells: [
  //                             DataCell(
  //                               Text(
  //                                 w.czrzid.toString(),
  //                                 style: TextStyle(fontSize: fontSize),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               Text(
  //                                 w.caozuoren,
  //                                 style: TextStyle(fontSize: fontSize),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               SizedBox(
  //                                 width: isMobile ? 140 : 280,
  //                                 child: Text(
  //                                   w.caozuoneirong,
  //                                   maxLines: 3,
  //                                   softWrap: true,
  //                                   overflow: TextOverflow.visible,
  //                                   style: TextStyle(fontSize: fontSize),
  //                                 ),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               ElevatedButton(
  //                                 style: ElevatedButton.styleFrom(
  //                                   padding: const EdgeInsets.symmetric(
  //                                     horizontal: 10,
  //                                     vertical: 8,
  //                                   ),
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(20),
  //                                   ),
  //                                 ),
  //                                 onPressed: () {
  //                                   showDialog(
  //                                     context: context,
  //                                     builder: (_) => _detailDialog(w),
  //                                   );
  //                                 },
  //                                 child: const Text("Detail"),
  //                               ),
  //                             ),
  //                           ],
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //   );
  // }

  // ===================== DETAIL DIALOG =====================

  Widget _detailDialog(CaoZuo w) {
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
                  "Operation Detail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _detailRow("Log ID", w.czrzid.toString()),
              _detailRow("Operator", w.caozuoren),
              _detailRow("Operation Time", w.caozuoshijan),
              _detailRow("Operation Note", w.caozuoneirong),
              _detailRow("Operation Function", w.caozuogongneng),

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
            width: 150,
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
