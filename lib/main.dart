// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'core/widgets/app_layout.dart';
// import 'features/users/provider/user_table_provider.dart';
// import 'features/users/presentation/pages/user_page.dart';
// import 'core/theme/app_theme.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => UserTableProvider()..loadMockUsers(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hybrid Sidebar Dashboard',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme, // <-- gunakan theme yang sudah dibuat
//       home: const HomeShell(),
//     );
//   }
// }

// /// HomeShell pakai IndexedStack — cepat dan mempertahankan state tiap halaman
// class HomeShell extends StatefulWidget {
//   const HomeShell({super.key});
//   @override
//   State<HomeShell> createState() => _HomeShellState();
// }

// class _HomeShellState extends State<HomeShell> {
//   int idx = 1; // default: Users
//   bool sidebarCollapsed = false;

//   final List<Widget> pages = const [
//     Center(child: Text('Dashboard utama (Placeholder)')),
//     UserPage(),
//     Center(child: Text('Settings (Placeholder)')),
//   ];

//   void onSelect(int i) => setState(() => idx = i);
//   void toggleSidebar() => setState(() => sidebarCollapsed = !sidebarCollapsed);

//   @override
//   Widget build(BuildContext context) {
//     // NOTE: put `child` argument last when instantiating widgets (lint)
//     return AppLayout(
//       selectedIndex: idx,
//       isCollapsed: sidebarCollapsed,
//       onSelect: onSelect,
//       onToggleCollapsed: toggleSidebar,
//       child: IndexedStack(index: idx, children: pages),
//     );
//   }
// }
import 'package:erp_nuctech/providers/caozuo_provider.dart';
import 'package:erp_nuctech/providers/fahuo_provider.dart';
import 'package:erp_nuctech/providers/fuzhaojielunleixing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/warehouse_provider.dart';
import 'providers/chanpinxian_provider.dart';
import 'screens/warehouse_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WarehouseProvider()),
        ChangeNotifierProvider(create: (_) => ChanPinXianProvider()),
        ChangeNotifierProvider(create: (_) => CaozuoProvider()),
        ChangeNotifierProvider(create: (_) => FahuoProvider()),
        ChangeNotifierProvider(create: (_) => FuzhaoProvider()),

        // ➜ provider tambahan
      ],
      child: MaterialApp(
        title: "ERP Monitoring",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const WarehouseListScreen(),
      ),
    );
  }
}
