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
  static const double _idColWidth = 20;
  static const double _catColWidth = 110;
  static const double _picColWidth = 90;
  static const double _actionColWidth = 90;
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
              headingRowHeight: 48,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 58,
            ),
            child: PaginatedDataTable(
              header: const Text("Warehouse"),
              rowsPerPage: 10,
              columnSpacing: isMobile ? 12 : 32,
              columns: const [
                // DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: _idColWidth,
                    child: Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _catColWidth,
                    child: Center(
                      child: Text("Category", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _picColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("PIC", textAlign: TextAlign.center),
                    ),
                  ),
                ),

                DataColumn(
                  label: SizedBox(
                    width: _actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: WarehouseDataSource(
                data: provider.warehouses,
                context: context,
                isMobile: isMobile,
                idColWidth: _idColWidth,
                catColWidth: _catColWidth,
                picColWidth: _picColWidth,
                actionColWidth: _actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
