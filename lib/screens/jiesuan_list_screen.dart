// import 'package:erp_nuctech/models/fuzhaopi_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/jiesuan_data_source.dart'; // <<< DITAMBAHKAN
import '../layouts/base_layout.dart';
import '../providers/jiesuan_provider.dart';

class JiesuanListScreen extends StatefulWidget {
  const JiesuanListScreen({super.key});

  @override
  State<JiesuanListScreen> createState() => _JiesuanListScreenState();
}

class _JiesuanListScreenState extends State<JiesuanListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JiesuanProvider>().fetchJiesuan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JiesuanProvider>(context);

    return BaseLayout(title: "Payment Type", child: _buildBody(provider));
  }

  Widget _buildBody(JiesuanProvider provider) {
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

  Widget _buildTable(JiesuanProvider provider) {
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
              header: const Text("Payment Type"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: 80, // ⬅️ atur lebar header
                    child: Text(
                      "Payment",
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
                      "Is It Active",
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
              source: JiesuanDataSource(
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
