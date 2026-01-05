import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/process_manage_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/process_manage_provider.dart';

class ProcessManageListScreen extends StatefulWidget {
  const ProcessManageListScreen({super.key});

  @override
  State<ProcessManageListScreen> createState() =>
      _ProcessManageListScreenState();
}

class _ProcessManageListScreenState extends State<ProcessManageListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProcessManageProvider>().fetchProcessManage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProcessManageProvider>(context);

    return BaseLayout(title: "Process Management", child: _buildBody(provider));
  }

  Widget _buildBody(ProcessManageProvider provider) {
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

  Widget _buildTable(ProcessManageProvider provider) {
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
              header: const Text("Process Management"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("Order Number")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Customer",
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
                      "Product",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // DataColumn(
                //   label: SizedBox(
                //     width: 120, // ⬅️ atur lebar header
                //     child: Text(
                //       "Status",
                //       textAlign: TextAlign.center,
                //       softWrap: true,
                //       maxLines: 2,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),

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
              source: ProcessManageDataSource(
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
