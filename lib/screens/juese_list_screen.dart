// import 'package:erp_nuctech/models/fuzhaopi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/juese_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/juese_provider.dart';

class JueseListScreen extends StatefulWidget {
  const JueseListScreen({super.key});

  @override
  State<JueseListScreen> createState() => _JueseListScreenState();
}

class _JueseListScreenState extends State<JueseListScreen> {
  static const double _idColWidth = 40;
  static const double _nameColWidth = 190;
  static const double _actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JueseProvider>().fetchJuese();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JueseProvider>(context);

    return BaseLayout(title: "User Roles", child: _buildBody(provider));
  }

  Widget _buildBody(JueseProvider provider) {
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

  Widget _buildTable(JueseProvider provider) {
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
              header: const Text("Role"),
              rowsPerPage: 10,
              columnSpacing: isMobile ? 12 : 32,
              columns: const [
                DataColumn(
                  label: SizedBox(
                    width: _idColWidth,
                    child: Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: _nameColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("Role Name", textAlign: TextAlign.center),
                    ),
                  ),
                ),

                // DataColumn(label: Text("Action")),
                DataColumn(
                  label: SizedBox(
                    width: _actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: JueseDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: _idColWidth,
                nameColWidth: _nameColWidth,
                actionColWidth: _actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
