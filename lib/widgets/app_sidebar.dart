import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ===== PROVIDER =====
import '../providers/auth_provider.dart';

// ===== SCREENS =====
import '../screens/juese_list_screen.dart';
import '../screens/kehuxin_list_screen.dart';
import '../screens/process_manage_list_screen.dart';
import '../screens/register_screen.dart';
import '../screens/task_queue1_list_screen.dart';
import '../screens/weituodan_list_screen.dart';
import '../screens/weituodanleixing_list_screen.dart';
import '../screens/weituodanrenwu_list_screen.dart';
// import '../screens/zuzhi_list_screen.dart';

import '../screens/warehouse_list_screen.dart';
import '../screens/chanpinxian_list_screen.dart';
import '../screens/caozuo_list_screen.dart';
import '../screens/fahuo_list_screen.dart';
import '../screens/fuzhaopi_list_screen.dart';
import '../screens/fuzhaojielunleixing_list_screen.dart';
import '../screens/jiesuan_list_screen.dart';
import '../screens/jiliang_screen_list.dart';
import '../screens/jiliangji_screen_list.dart';
// import '../screens/kehufu_list_screen.dart';
import '../screens/kehuli_screen_list.dart';

// ======================================================
// ===================== MODEL ==========================
// ======================================================
class SidebarMenu {
  final String title;
  final IconData icon;
  final Widget page;
  final bool adminOnly;

  const SidebarMenu({
    required this.title,
    required this.icon,
    required this.page,
    this.adminOnly = false,
  });
}

// ======================================================
// ================= MENU CONFIG ========================
// ======================================================
final List<Map<String, dynamic>> sidebarSections = [
  {
    "title": "Management Production",
    "menus": const [
      SidebarMenu(
        title: "Process Management",
        icon: Icons.settings_outlined,
        page: ProcessManageListScreen(),
      ),
      SidebarMenu(
        title: "Task Queue Acc 1",
        icon: Icons.queue_outlined,
        page: TaskQueue1ListScreen(),
      ),
    ],
  },
  {
    "title": "Order Job",
    "menus": const [
      SidebarMenu(
        title: "Customer Order",
        icon: Icons.assignment_outlined,
        page: WeituodanListScreen(),
      ),
      SidebarMenu(
        title: "Type Service",
        icon: Icons.category_outlined,
        page: WeituodanleixingListScreen(),
      ),
      SidebarMenu(
        title: "Work Detail",
        icon: Icons.work_outline,
        page: WeituodanrenwuListScreen(),
      ),
    ],
  },
  {
    "title": "MASTER DATA",
    "adminOnly": true,
    "menus": const [
      SidebarMenu(
        title: "User Role",
        icon: Icons.people_outline,
        page: JueseListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Warehouse",
        icon: Icons.warehouse_outlined,
        page: WarehouseListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Line Production",
        icon: Icons.precision_manufacturing_outlined,
        page: ChanpinXianListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Radiation Conclusion",
        icon: Icons.rule_folder_outlined,
        page: FuzhaoListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Radiation Batch",
        icon: Icons.layers_outlined,
        page: FuzhaopiListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Payment Type",
        icon: Icons.payments_outlined,
        page: JiesuanListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Measurement Units",
        icon: Icons.straighten_outlined,
        page: JiliangListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Dosimeter Type",
        icon: Icons.monitor_heart_outlined,
        page: JiliangjiListScreen(),
        adminOnly: true,
      ),
    ],
  },
  {
    "title": "TRANSACTION",
    "adminOnly": true,
    "menus": const [
      SidebarMenu(
        title: "Operation Log",
        icon: Icons.list_alt_outlined,
        page: CaozuoListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Shipping Data",
        icon: Icons.local_shipping_outlined,
        page: FahuoListScreen(),
        adminOnly: true,
      ),
      // SidebarMenu(
      //   title: "Customer Irradiated Goods",
      //   icon: Icons.inventory_2_outlined,
      //   page: KehufuListScreen(),
      //   adminOnly: true,
      // ),
      SidebarMenu(
        title: "Customer Contact Person",
        icon: Icons.contact_page_outlined,
        page: KehuliListScreen(),
        adminOnly: true,
      ),
      SidebarMenu(
        title: "Customer Information",
        icon: Icons.account_circle_outlined,
        page: KehuxinListScreen(),
        adminOnly: true,
      ),
      // SidebarMenu(
      //   title: "Organization Structure",
      //   icon: Icons.account_tree_outlined,
      //   page: ZuzhiListScreen(),
      //   adminOnly: true,
      // ),
      SidebarMenu(
        title: "Register User",
        icon: Icons.person_add_alt_outlined,
        page: RegisterScreen(),
        adminOnly: true,
      ),
    ],
  },
];

// ======================================================
// ===================== WIDGET =========================
// ======================================================
class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: sidebarSections
                  .where(
                    (section) => section["adminOnly"] != true || auth.isAdmin,
                  )
                  .expand(
                    (section) => _buildSection(
                      context,
                      auth,
                      title: section["title"],
                      menus: section["menus"],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final username = auth.user?.username ?? "Guest";

        return Container(
          height: 180,
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
              const SizedBox(height: 6),
              Text(
                "Welcome, $username !",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= SECTION =================
  List<Widget> _buildSection(
    BuildContext context,
    AuthProvider auth, {
    required String title,
    required List<SidebarMenu> menus,
  }) {
    return [
      _sectionTitle(title),
      ...menus
          .where((menu) => !menu.adminOnly || auth.isAdmin)
          .map(
            (menu) => _menuItem(
              context,
              icon: menu.icon,
              title: menu.title,
              page: menu.page,
            ),
          ),
    ];
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
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
