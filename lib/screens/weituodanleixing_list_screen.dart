import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/weituodanleixing_data_source.dart.dart';
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

  Widget _buildTable(WeituodanleixingProvider provider) {
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
              header: const Text("Order Type"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Order Type Name",
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
              source: WeituodanleixingDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
              ),
            ),
          ),
        );
      },
    );
  }
}
