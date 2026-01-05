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

  Widget _buildTable(WeituodanrenwuProvider provider) {
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
              header: const Text("Detail Task"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Packaging",
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
              source: WeituodanrenwuDataSource(
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
