import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/weituodanleixing_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/weituodanleixing_provider.dart';

class WeituodanleixingListScreen extends StatefulWidget {
  const WeituodanleixingListScreen({super.key});

  @override
  State<WeituodanleixingListScreen> createState() =>
      _WeituodanleixingListScreenState();
}

class _WeituodanleixingListScreenState
    extends State<WeituodanleixingListScreen> {
  static const double idColWidth = 20;
  static const double nameColWidth = 200;
  static const double actionColWidth = 90;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeituodanleixingProvider>().fetchWeituodanleixing();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeituodanleixingProvider>(context);
    return BaseLayout(title: "Order Type", child: _buildBody(provider));
  }

  Widget _buildBody(WeituodanleixingProvider provider) {
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
          // padding: const EdgeInsets.all(),
          child: DataTableTheme(
            data: const DataTableThemeData(
              headingRowHeight: 48,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 56,
            ),
            child: PaginatedDataTable(
              header: const Text(
                "Order Type",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
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
                        "Order Type Name",
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
              source: WeituodanleixingDataSource(
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
