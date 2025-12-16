import 'package:erp_nuctech/models/chanpinxian_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/chanpinxian_provider.dart';

class ChanpinXianListScreen extends StatefulWidget {
  const ChanpinXianListScreen({super.key});

  @override
  State<ChanpinXianListScreen> createState() => _ChanpinXianListScreenState();
}

class _ChanpinXianListScreenState extends State<ChanpinXianListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChanPinXianProvider>(context, listen: false).fetchChanpinxian();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChanPinXianProvider>(context);
    return BaseLayout(title: "Tes", child: _buildBody(provider));
  }

  Widget _buildBody(ChanPinXianProvider provider) {
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

  Widget _buildTable(ChanPinXianProvider provider) {
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
                dataRowMaxHeight: 64,
                columnSpacing: columnSpacing,
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Production Name")),
                  DataColumn(label: Text("Function")),
                  DataColumn(label: Text("Action")),
                ],
                rows: provider.data.map((w) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          w.id.toString(),
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isMobile ? 140 : 260,
                          child: Text(
                            w.namaProduksi,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(w.yongTu, style: TextStyle(fontSize: fontSize)),
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
  //     title: "Production Line",
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
  //                       dataRowMaxHeight: 64,
  //                       columnSpacing: columnSpacing,
  //                       columns: const [
  //                         DataColumn(label: Text("ID")),
  //                         DataColumn(label: Text("Production Name")),
  //                         DataColumn(label: Text("Function")),
  //                         DataColumn(label: Text("Action")),
  //                       ],
  //                       rows: provider.data.map((w) {
  //                         return DataRow(
  //                           cells: [
  //                             DataCell(
  //                               Text(
  //                                 w.id.toString(),
  //                                 style: TextStyle(fontSize: fontSize),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               SizedBox(
  //                                 width: isMobile ? 140 : 260,
  //                                 child: Text(
  //                                   w.namaProduksi,
  //                                   softWrap: true,
  //                                   overflow: TextOverflow.visible,
  //                                   style: TextStyle(fontSize: fontSize),
  //                                 ),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               Text(
  //                                 w.yongTu,
  //                                 style: TextStyle(fontSize: fontSize),
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

  Widget _detailDialog(ChanPinXian w) {
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
                  "Production Line Detail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _detailRow("ID", w.id.toString()),
              _detailRow("Production Name", w.namaProduksi),
              _detailRow("Function", w.yongTu),
              _detailRow("Created Date", w.ruLuRiQi),
              _detailRow("Updated Time", w.xiuGaiShiJian),
              _detailRow("Is Valid", w.shiFouYouXiao == 1 ? "Yes" : "No"),
              _detailRow("Parameter K", w.k.toString()),
              _detailRow("Parameter Ta", w.ta.toString()),
              _detailRow("Parameter Tb", w.tb.toString()),
              _detailRow("Parameter Tc", w.tc.toString()),

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
