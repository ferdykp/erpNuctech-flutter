import 'package:erp_nuctech/screens/juese_list_screen.dart';
import 'package:erp_nuctech/screens/kehuxin_list_screen.dart';
import 'package:erp_nuctech/screens/zuzhi_list_screen.dart';
import 'package:flutter/material.dart';

import '../screens/warehouse_list_screen.dart';
import '../screens/chanpinxian_list_screen.dart';
import '../screens/caozuo_list_screen.dart';
import '../screens/fahuo_list_screen.dart';
import '../screens/fuzhaopi_list_screen.dart';
import '../screens/fuzhaojielunleixing_list_screen.dart';
import '../screens/jiesuan_list_screen.dart';
import '../screens/jiliang_screen_list.dart';
import '../screens/jiliangji_screen_list.dart';
import '../screens/kehufu_list_screen.dart';
import '../screens/kehuli_screen_list.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _sectionTitle("MASTER DATA"),
                _menuItem(
                  context,
                  icon: Icons.people_alt_outlined,
                  title: "User Role",
                  page: const JueseListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.warehouse_outlined,
                  title: "Warehouse",
                  page: const WarehouseListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.precision_manufacturing_outlined,
                  title: "Line Production",
                  page: const ChanpinXianListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.rule_folder_outlined,
                  title: "Radiation Conclusion",
                  page: const FuzhaoListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.layers_outlined,
                  title: "Radiation Batch",
                  page: const FuzhaopiListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.payments_outlined,
                  title: "Payment Type",
                  page: const JiesuanListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.straighten_outlined,
                  title: "Measurement Units",
                  page: const JiliangListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.monitor_heart_outlined,
                  title: "Dosimeter Type",
                  page: const JiliangjiListScreen(),
                ),

                const SizedBox(height: 8),
                const Divider(),

                _sectionTitle("TRANSACTION"),
                _menuItem(
                  context,
                  icon: Icons.list_alt_outlined,
                  title: "Operation Log",
                  page: const CaozuoListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: "Shipping Data",
                  page: const FahuoListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.inventory_2_outlined,
                  title: "Customer Irradiated Goods",
                  page: const KehufuListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.contact_page_outlined,
                  title: "Customer Contact Person",
                  page: const KehuliListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.contact_page_outlined,
                  title: "Customer Information",
                  page: const KehuxinListScreen(),
                ),
                _menuItem(
                  context,
                  icon: Icons.contact_page_outlined,
                  title: "Organization Structure",
                  page: const ZuzhiListScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Image.asset(
              'assets/images/logo-txt-removebg.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "ERP Management System",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  // ================= MENU ITEM =================
  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      dense: true,
      horizontalTitleGap: 12,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}
