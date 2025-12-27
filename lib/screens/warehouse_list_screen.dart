import 'package:erp_nuctech/screens/table/warehouse_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../layouts/base_layout.dart';
import '../providers/warehouse_provider.dart';
// import '../models/warehouse_model.dart';

class WarehouseListScreen extends StatefulWidget {
  const WarehouseListScreen({super.key});

  @override
  State<WarehouseListScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WarehouseProvider>().fetchWarehouses();
    });
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

        return SingleChildScrollView(
          child: DataTableTheme(
            data: const DataTableThemeData(
              dataRowMinHeight: 36, // <<< TAMBAHKAN
              dataRowMaxHeight: 58, // <<< TAMBAHKAN
            ),
            child: PaginatedDataTable(
              header: const Text("Warehouse"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Category",
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
                      "PIC",
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
              source: WarehouseDataSource(
                data: provider.warehouses,
                context: context,
                isMobile: isMobile,
              ),
            ),
          ),
        );
      },
    );
  }
  // =================================================

  // =================== DETAIL DIALOG ===================
  // Widget _detailDialog(Warehouse w) {
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
  //                 "Warehouse Detail",
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             const SizedBox(height: 20),

  //             _detailRow("Warehouse ID", w.id.toString()),
  //             _detailRow("Category", w.nama),
  //             _detailRow("Area", w.quYuShu.toString()),
  //             _detailRow("PIC", w.fuZeRen),
  //             _detailRow("Size", w.luas.toString()),
  //             _detailRow("Created Date", w.ruLuRiQi),
  //             _detailRow("Updated Date", w.xiuGaiShiJian),

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
  //           width: 140,
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
