import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/weituodan_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/weituodan_provider.dart';

class WeituodanListScreen extends StatefulWidget {
  const WeituodanListScreen({super.key});

  @override
  State<WeituodanListScreen> createState() => _WeituodanListScreenState();
}

class _WeituodanListScreenState extends State<WeituodanListScreen> {
  // === WIDTH KOLOM KONSISTEN ===
  static const double orderColWidth = 110;
  static const double arrivalColWidth = 150;
  static const double actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeituodanProvider>().fetchWeituodan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeituodanProvider>(context);
    return BaseLayout(title: "Order Job", child: _buildBody(provider));
  }

  Widget _buildBody(WeituodanProvider provider) {
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
              dataRowMaxHeight: 58,
            ),
            child: PaginatedDataTable(
              header: const Text(
                "Customer Order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              rowsPerPage: 10,
              columnSpacing: 0, // ⬅️ wajib agar sejajar
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: orderColWidth,
                    child: const Center(child: Text("Order Number")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: arrivalColWidth,
                    child: const Center(
                      child: Text(
                        "Arrival",
                        // maxLines: 1,
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
              source: WeituodanDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                orderColWidth: orderColWidth,
                arrivalColWidth: arrivalColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
