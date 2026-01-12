// import 'package:erp_nuctech/models/fuzhaopi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/kehuli_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/kehuli_provider.dart';

class KehuliListScreen extends StatefulWidget {
  const KehuliListScreen({super.key});

  @override
  State<KehuliListScreen> createState() => _KehuliListScreenState();
}

class _KehuliListScreenState extends State<KehuliListScreen> {
  static const double idColWidth = 40;
  static const double nameColWidth = 90;
  static const double phoneColWidth = 100;
  static const double actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KehuliProvider>().fetchKehuli();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KehuliProvider>(context);

    return BaseLayout(title: "Customer Contacts", child: _buildBody(provider));
  }

  Widget _buildBody(KehuliProvider provider) {
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

  Widget _buildTable(KehuliProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: DataTableTheme(
            data: const DataTableThemeData(
              dataRowMinHeight: 36,
              dataRowMaxHeight: 58,
            ),
            child: PaginatedDataTable(
              header: const Text("Customer Contact Person"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(
                  label: SizedBox(
                    width: idColWidth,
                    child: Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: nameColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("Name", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: phoneColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text(
                        "Mobile Phone",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),

                // DataColumn(label: Text("Action")),
                DataColumn(
                  label: SizedBox(
                    width: actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: KehuliDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                nameColWidth: nameColWidth,
                phoneColWidth: phoneColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
