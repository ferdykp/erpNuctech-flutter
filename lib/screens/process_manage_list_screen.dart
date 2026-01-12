import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/process_manage_provider.dart';
import 'table/process_manage_data_source.dart';

class ProcessManageListScreen extends StatefulWidget {
  const ProcessManageListScreen({super.key});

  @override
  State<ProcessManageListScreen> createState() =>
      _ProcessManageListScreenState();
}

class _ProcessManageListScreenState extends State<ProcessManageListScreen> {
  static const double _orderColWidth = 100;
  static const double _customerColWidth = 130;
  static const double _actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProcessManageProvider>().fetchProcessManage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProcessManageProvider>();

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
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (provider.data.isEmpty) {
      return const Center(child: Text("No data"));
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
              headingRowHeight: 48,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 56,
            ),
            child: PaginatedDataTable(
              header: const Text("Process List"),
              rowsPerPage: 10,
              columnSpacing: isMobile ? 12 : 32,
              columns: const [
                DataColumn(
                  label: SizedBox(
                    width: _orderColWidth,
                    child: Center(child: Text("Order No")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _customerColWidth,
                    child: Center(child: Text("Customer")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: ProcessManageDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                orderColWidth: _orderColWidth,
                customerColWidth: _customerColWidth,
                actionColWidth: _actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
