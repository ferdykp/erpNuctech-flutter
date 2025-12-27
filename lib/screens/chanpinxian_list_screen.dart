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
  @override
  void initState() {
    super.initState();
    Provider.of<ChanPinXianProvider>(context, listen: false).fetchChanpinxian();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChanPinXianProvider>(context);
    return BaseLayout(title: "Tes", child: _buildBody(provider));
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
              dataRowMinHeight: 36, // <<< TAMBAHKAN
              dataRowMaxHeight: 58, // <<< TAMBAHKAN
            ),
            child: PaginatedDataTable(
              header: const Text("ChanPinXian"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Production Name")),
                DataColumn(label: Text("Function")),
                DataColumn(label: Text("Action")),
              ],
              source: ChanpinxianDataSource(
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
