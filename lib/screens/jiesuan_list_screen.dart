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
  static const double idColWidth = 30;
  static const double paymentColWidth = 110;
  static const double statusColWidth = 100;
  static const double actionColWidth = 90;
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
              dataRowMinHeight: 36,
              dataRowMaxHeight: 58,
            ),
            child: PaginatedDataTable(
              header: const Text("Payment Type"),
              rowsPerPage: isMobile ? 10 : 10,
              columnSpacing: isMobile ? 10 : 30,
              columns: const [
                // DataColumn(label: Text("ID")),
                DataColumn(
                  label: SizedBox(
                    width: idColWidth,
                    child: Center(child: Text("ID")),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: paymentColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("Payment", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: statusColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text("Is It Active", textAlign: TextAlign.center),
                    ),
                  ),
                ),

                // DataColumn(label: Text("Action")),
                DataColumn(
                  label: SizedBox(
                    width: actionColWidth,
                    child: Center(child: Text("Action")),
                  ),
                ),
              ],
              source: JiesuanDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                paymentColWidth: paymentColWidth,
                statusColWidth: statusColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
