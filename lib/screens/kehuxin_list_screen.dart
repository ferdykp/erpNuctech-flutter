// import 'package:erp_nuctech/models/fuzhaopi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/kehuxin_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/kehuxin_provider.dart';

class KehuxinListScreen extends StatefulWidget {
  const KehuxinListScreen({super.key});

  @override
  State<KehuxinListScreen> createState() => _KehuxinListScreenState();
}

class _KehuxinListScreenState extends State<KehuxinListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KehuxinProvider>().fetchKehuxin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KehuxinProvider>(context);

    return BaseLayout(title: "Customer Contacts", child: _buildBody(provider));
  }

  Widget _buildBody(KehuxinProvider provider) {
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

  Widget _buildTable(KehuxinProvider provider) {
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
              header: const Text("Customer Information"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Customer Code",
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
                      "Name",
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
              source: KehuxinDataSource(
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
