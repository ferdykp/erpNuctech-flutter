import 'package:erp_nuctech/models/fuzhaojielunleixing_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/fuzhaojielunleixing_provider.dart';

class FuzhaoListScreen extends StatefulWidget {
  const FuzhaoListScreen({super.key});

  @override
  State<FuzhaoListScreen> createState() => _FuzhaoListScreenState();
}

class _FuzhaoListScreenState extends State<FuzhaoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FuzhaoProvider>(context, listen: false).fetchFuzhao();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FuzhaoProvider>(context);

    return BaseLayout(
      title: "Radiation Conlusion",
      child: _buildBody(provider),
    );
  }

  Widget _buildBody(FuzhaoProvider provider) {
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

  Widget _buildTable(FuzhaoProvider provider) {
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
                DataColumn(label: Text("Category")),
                DataColumn(label: Text("Is Valid")),
                DataColumn(label: Text("Action")),
              ],
              rows: provider.data.map((w) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        w.fjllxid.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isMobile ? 80 : 260,
                        child: Text(
                          w.mingcheng,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
                    // DataCell(
                    //   Text(w.mingcheng, style: TextStyle(fontSize: fontSize)),
                    // ),
                    DataCell(
                      Text(
                        w.shifouyouxiao == 1 ? "Yes" : "No",
                        style: TextStyle(fontSize: fontSize),
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
        );
      },
    );
  }

  Widget _detailDialog(Fuzhao w) {
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

              _detailRow("ID", w.fjllxid.toString()),
              _detailRow("Category", w.mingcheng),
              _detailRow("Is Valid", w.shifouyouxiao == 1 ? "Yes" : "No"),
              _detailRow("Created By (User ID)", w.rululenid.toString()),
              _detailRow("Created Date", w.ruluriqi),
              _detailRow("Updated By (User ID)", w.xiugairenid.toString()),
              _detailRow("Updated At", w.xiugaishijian),

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

  //   return BaseLayout(
  //     title: "Radiation Conclution",
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
  //                         DataColumn(label: Text("Category")),
  //                         DataColumn(label: Text("Is Valid")),
  //                         DataColumn(label: Text("Action")),
  //                       ],
  //                       rows: provider.data.map((w) {
  //                         return DataRow(
  //                           cells: [
  //                             DataCell(
  //                               Text(
  //                                 w.fjllxid.toString(),
  //                                 style: TextStyle(fontSize: fontSize),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               SizedBox(
  //                                 width: isMobile ? 140 : 260,
  //                                 child: Text(
  //                                   w.mingcheng,
  //                                   softWrap: true,
  //                                   overflow: TextOverflow.visible,
  //                                   style: TextStyle(fontSize: fontSize),
  //                                 ),
  //                               ),
  //                             ),
  //                             DataCell(
  //                               Text(
  //                                 w.shifouyouxiao.toString(),
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


