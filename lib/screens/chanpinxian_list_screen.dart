// import 'package:erp_nuctech/models/chanpinxian_model.dart';
import 'package:erp_nuctech/screens/table/chanpinxian_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layouts/base_layout.dart';
import '../providers/chanpinxian_provider.dart';

class ChanpinXianListScreen extends StatefulWidget {
  const ChanpinXianListScreen({super.key});

  @override
  State<ChanpinXianListScreen> createState() => _ChanpinXianListScreenState();
}

class _ChanpinXianListScreenState extends State<ChanpinXianListScreen> {
  static const double idColWidth = 20;
  static const double productColWidth = 110;
  static const double functionColWidth = 90;
  static const double actionColWidth = 90;

  @override
  void initState() {
    super.initState();
    Provider.of<ChanPinXianProvider>(context, listen: false).fetchChanpinxian();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChanPinXianProvider>(context);
    return BaseLayout(title: "Line Production", child: _buildBody(provider));
  }

  Widget _buildBody(ChanPinXianProvider provider) {
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

  Widget _buildTable(ChanPinXianProvider provider) {
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
              header: const Text("Line Production"),
              rowsPerPage: 10,
              columnSpacing: isMobile ? 12 : 32,
              columns: const [
                DataColumn(
                  label: SizedBox(
                    width: idColWidth,
                    child: Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: productColWidth,
                    child: Center(
                      child: Text(
                        "Production Name",
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                DataColumn(
                  label: SizedBox(
                    width: functionColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("Function", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: ChanpinxianDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                productColWidth: productColWidth,
                functionColWidth: functionColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
