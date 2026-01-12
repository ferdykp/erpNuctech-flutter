// import 'package:erp_nuctech/models/caozuo_model.dart';
import 'package:erp_nuctech/screens/table/caozuo_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/caozuo_provider.dart';

class CaozuoListScreen extends StatefulWidget {
  const CaozuoListScreen({super.key});

  @override
  State<CaozuoListScreen> createState() => _CaozuoListScreenState();
}

class _CaozuoListScreenState extends State<CaozuoListScreen> {
  static const double idColWidth = 60;
  static const double oprColWidth = 180;
  // static const double opsColWidth = 90;
  static const double actionColWidth = 100;

  @override
  void initState() {
    super.initState();
    Provider.of<CaozuoProvider>(context, listen: false).fetchCaozuo();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CaozuoProvider>(context);
    return BaseLayout(title: "Operation Logs", child: _buildBody(provider));
  }

  Widget _buildBody(CaozuoProvider provider) {
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
        child: Text("No Data", style: TextStyle(fontSize: 14)),
      );
    }
    return _buildTable(provider);
  }

  Widget _buildTable(CaozuoProvider provider) {
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
              header: const Text("Radiation Batch Operation Logs"),
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
                    width: oprColWidth,
                    child: Center(
                      child: Text("Operator", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                // DataColumn(
                //   label: SizedBox(
                //     width: opsColWidth,
                //     child: Center(
                //       child: Text(
                //         "Operation Note",
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
                DataColumn(
                  label: SizedBox(
                    width: actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],

              source: CaoZuoDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                oprColWidth: oprColWidth,
                // opsColWidth: opsColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
