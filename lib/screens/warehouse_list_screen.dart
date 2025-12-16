// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../layouts/base_layout.dart';
// import '../providers/warehouse_provider.dart';
// import '../models/warehouse_model.dart';

// class WarehouseListScreen extends StatefulWidget {
//   const WarehouseListScreen({super.key});

//   @override
//   State<WarehouseListScreen> createState() => _WarehouseListScreenState();
// }

// class _WarehouseListScreenState extends State<WarehouseListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<WarehouseProvider>(context, listen: false).fetchWarehouses();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<WarehouseProvider>(context);

//     return BaseLayout(
//       title: "Warehouse",
//       child: provider.loading
//           ? const Center(child: CircularProgressIndicator())
//           : LayoutBuilder(
//               builder: (context, constraints) {
//                 final isMobile = constraints.maxWidth < 600;

//                 final fontSize = isMobile ? 12.0 : 14.0;
//                 final columnSpacing = isMobile ? 20.0 : 40.0;

//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(minWidth: constraints.maxWidth),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: DataTable(
//                         headingRowHeight: 46,
//                         dataRowMinHeight: 44,
//                         dataRowMaxHeight: 60,
//                         columnSpacing: columnSpacing,
//                         columns: const [
//                           DataColumn(label: Text("ID")),
//                           DataColumn(label: Text("Category")),
//                           DataColumn(label: Text("PIC")),
//                           DataColumn(label: Text("Action")),
//                         ],
//                         rows: provider.warehouses.map((w) {
//                           return DataRow(
//                             cells: [
//                               // ID
//                               DataCell(
//                                 Text(
//                                   w.id.toString(),
//                                   style: TextStyle(fontSize: fontSize),
//                                 ),
//                               ),

//                               // Category (ellipsis)
//                               DataCell(
//                                 SizedBox(
//                                   width: isMobile ? 100 : 200,
//                                   child: Text(
//                                     w.nama,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(fontSize: fontSize),
//                                   ),
//                                 ),
//                               ),

//                               // PIC (ellipsis)
//                               DataCell(
//                                 SizedBox(
//                                   width: isMobile ? 80 : 200,
//                                   child: Text(
//                                     w.fuZeRen,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(fontSize: fontSize),
//                                   ),
//                                 ),
//                               ),

//                               // Action
//                               DataCell(
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                       vertical: 8,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (_) => _detailDialog(w),
//                                     );
//                                   },
//                                   child: const Text("Detail"),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   // ===================== DETAIL DIALOG =====================

//   Widget _detailDialog(Warehouse w) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Center(
//                 child: Text(
//                   "Warehouse Detail",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               _detailRow("Warehouse ID", w.id.toString()),
//               _detailRow("Category", w.nama),
//               _detailRow("Area", w.quYuShu.toString()),
//               _detailRow("PIC", w.fuZeRen),
//               _detailRow("Size", w.luas.toString()),
//               _detailRow("Created Date", w.ruLuRiQi),
//               _detailRow("Updated Date", w.xiuGaiShiJian),

//               const SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("Close"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ===================== DETAIL ROW =====================

//   Widget _detailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(
//               "$title:",
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../layouts/base_layout.dart';
import '../providers/warehouse_provider.dart';
import '../models/warehouse_model.dart';

class WarehouseListScreen extends StatefulWidget {
  const WarehouseListScreen({super.key});

  @override
  State<WarehouseListScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WarehouseProvider>(context, listen: false).fetchWarehouses();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WarehouseProvider>(context);

    return BaseLayout(title: "Warehouse", child: _buildBody(provider));
  }

  // =================== 🆕 MAIN BODY HANDLER ===================
  Widget _buildBody(WarehouseProvider provider) {
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

    if (provider.warehouses.isEmpty) {
      return const Center(
        child: Text(
          "No warehouse data available",
          style: TextStyle(fontSize: 14),
        ),
      );
    }

    return _buildTable(provider);
  }
  // ===========================================================

  // =================== DATA TABLE ===================
  Widget _buildTable(WarehouseProvider provider) {
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
              dataRowMaxHeight: 56,
              columnSpacing: columnSpacing,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Category")),
                DataColumn(label: Text("PIC")),
                DataColumn(label: Text("Action")),
              ],
              rows: provider.warehouses.map((w) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        w.id.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),

                    // Category (ellipsis)
                    DataCell(
                      SizedBox(
                        width: isMobile ? 120 : 220,
                        child: Text(
                          w.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),

                    // PIC (ellipsis)
                    DataCell(
                      SizedBox(
                        width: isMobile ? 100 : 200,
                        child: Text(
                          w.fuZeRen,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),

                    DataCell(
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
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
  // =================================================

  // =================== DETAIL DIALOG ===================
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

              _detailRow("Warehouse ID", w.id.toString()),
              _detailRow("Category", w.nama),
              _detailRow("Area", w.quYuShu.toString()),
              _detailRow("PIC", w.fuZeRen),
              _detailRow("Size", w.luas.toString()),
              _detailRow("Created Date", w.ruLuRiQi),
              _detailRow("Updated Date", w.xiuGaiShiJian),

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
