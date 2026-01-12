import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/task_queue1_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/task_queue1_provider.dart';

class TaskQueue1ListScreen extends StatefulWidget {
  const TaskQueue1ListScreen({super.key});

  @override
  State<TaskQueue1ListScreen> createState() => _TaskQueue1ListScreenState();
}

class _TaskQueue1ListScreenState extends State<TaskQueue1ListScreen> {
  static const double _noOrderColWidth = 100;
  static const double _productColWidth = 130;
  static const double _actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskQueue1Provider>().fetchTaskQueue1();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskQueue1Provider>(context);

    return BaseLayout(title: "Task Queue Acc 1", child: _buildBody(provider));
  }

  Widget _buildBody(TaskQueue1Provider provider) {
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

  Widget _buildTable(TaskQueue1Provider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: DataTableTheme(
            data: const DataTableThemeData(
              headingRowHeight: 48,
              dataRowMinHeight: 36,
              dataRowMaxHeight: 58,
            ),
            child: PaginatedDataTable(
              header: const Text("Task Queue Acc 1"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 12 : 32,
              columns: const [
                // DataColumn(label: Text("Order Number")),
                DataColumn(
                  label: SizedBox(
                    width: _noOrderColWidth,
                    child: Center(child: Text("Order Number")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _productColWidth,
                    child: Center(
                      child: Text("Product", textAlign: TextAlign.center),
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
              source: TaskQueue1DataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                noOrderColWidth: _noOrderColWidth,
                productColWidth: _productColWidth,
                actionColWidth: _actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
