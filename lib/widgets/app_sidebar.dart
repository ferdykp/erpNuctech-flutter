// import 'package:erp_nuctech/models/fuzhaojielunleixing_model.dart';
import 'package:erp_nuctech/screens/caozuo_list_screen.dart';
import 'package:erp_nuctech/screens/fahuo_list_screen.dart';
import 'package:erp_nuctech/screens/fuzhaopi_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/warehouse_list_screen.dart';
import '../screens/chanpinxian_list_screen.dart';
import '../screens/fuzhaojielunleixing_list_screen.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.warehouse),
            title: const Text("Warehouse"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WarehouseListScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.factory),
            title: const Text("Line Production"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChanpinXianListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.factory),
            title: const Text("Opeartion Log"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CaozuoListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.factory),
            title: const Text("Shipping Data"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const FahuoListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.factory),
            title: const Text("Radiation Conlusion"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const FuzhaoListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.factory),
            title: const Text("Radiation Batch"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const FuzhaopiListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
