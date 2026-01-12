import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'table/jiliangji_data_source.dart';
import '../layouts/base_layout.dart';
import '../providers/jiliangji_provider.dart';

class JiliangjiListScreen extends StatefulWidget {
  const JiliangjiListScreen({super.key});

  @override
  State<JiliangjiListScreen> createState() => _JiliangjiListScreenState();
}

class _JiliangjiListScreenState extends State<JiliangjiListScreen> {
  static const double idColWidth = 20;
  static const double typeColWidth = 120;
  static const double seriColWidth = 110;
  static const double actionColWidth = 90;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JiliangjiProvider>().fetchJiliangji();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JiliangjiProvider>(context);

    return BaseLayout(title: "Dosimetry Type", child: _buildBody(provider));
  }

  Widget _buildBody(JiliangjiProvider provider) {
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

  Widget _buildTable(JiliangjiProvider provider) {
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
              header: const Text("Dosimeter Type"),
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
                    width: typeColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text(
                        "Dosimeter Type",
                        textAlign: TextAlign.center,
                        // softWrap: true,
                        // maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: seriColWidth, // ⬅️ atur lebar header
                    child: Center(
                      child: Text(
                        "Dosimeter S.A",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
              source: JiliangjiDataSource(
                data: provider.data,
                context: context,
                isMobile: isMobile,
                idColWidth: idColWidth,
                typeColWidth: typeColWidth,
                seriColWidth: seriColWidth,
                actionColWidth: actionColWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
