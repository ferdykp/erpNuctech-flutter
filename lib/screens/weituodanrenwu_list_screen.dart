import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/weituodanrenwu_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/weituodanrenwu_provider.dart';

class WeituodanrenwuListScreen extends StatefulWidget {
  const WeituodanrenwuListScreen({super.key});

  @override
  State<WeituodanrenwuListScreen> createState() =>
      _WeituodanrenwuListScreenState();
}

class _WeituodanrenwuListScreenState extends State<WeituodanrenwuListScreen> {
  // === KONSISTEN WIDTH KOLOM (WAJIB SAMA DENGAN DATASOURCE) ===
  static const double idColWidth = 90;
  static const double nameColWidth = 180;
  static const double actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeituodanrenwuProvider>().fetchWeituodanrenwu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeituodanrenwuProvider>(context);
    return BaseLayout(title: "Detail Task", child: _buildBody(provider));
  }

  Widget _buildBody(WeituodanrenwuProvider provider) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Text(
          provider.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (provider.data.isEmpty) {
      return const Center(child: Text("No data"));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          // padding: const EdgeInsets.all(12),
          child: DataTableTheme(
            data: const DataTableThemeData(
              headingRowHeight: 48,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 56,
            ),
            child: PaginatedDataTable(
              header: const Text(
                "Detail Task",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              rowsPerPage: 10,
              columnSpacing: 0, // ⬅️ penting agar presisi
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: idColWidth,
                    child: const Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: nameColWidth,
                    child: const Center(
                      child: Text(
                        "Packaging",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: actionColWidth,
                    child: const Center(child: Text("Action")),
                  ),
                ),
              ],
              source: WeituodanrenwuDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                nameColWidth: nameColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
