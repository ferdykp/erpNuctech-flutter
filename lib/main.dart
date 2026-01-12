// // import 'package:erp_nuctech/models/jiliang_model.dart';
// import 'package:erp_nuctech/providers/zuzhi_provider.dart';
// import 'package:erp_nuctech/providers/juese_provider.dart';
// import 'package:erp_nuctech/providers/kehuli_provider.dart';
// import 'package:erp_nuctech/providers/caozuo_provider.dart';
// import 'package:erp_nuctech/providers/fahuo_provider.dart';
// import 'package:erp_nuctech/providers/fuzhaojielunleixing_provider.dart';
// import 'package:erp_nuctech/providers/fuzhaopi_provider.dart';
// import 'package:erp_nuctech/providers/jiesuan_provider.dart';
// import 'package:erp_nuctech/providers/jiliang_provider.dart';
// import 'package:erp_nuctech/providers/jiliangji_provider.dart';
// import 'package:erp_nuctech/providers/kehufu_provider.dart';
// import 'package:erp_nuctech/providers/kehuxin_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/warehouse_provider.dart';
// import 'providers/chanpinxian_provider.dart';
// import 'screens/warehouse_list_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => WarehouseProvider()),
//         ChangeNotifierProvider(create: (_) => ChanPinXianProvider()),
//         ChangeNotifierProvider(create: (_) => CaozuoProvider()),
//         ChangeNotifierProvider(create: (_) => FahuoProvider()),
//         ChangeNotifierProvider(create: (_) => FuzhaoProvider()),
//         ChangeNotifierProvider(create: (_) => FuzhaopiProvider()),
//         ChangeNotifierProvider(create: (_) => JiesuanProvider()),
//         ChangeNotifierProvider(create: (_) => JiliangProvider()),
//         ChangeNotifierProvider(create: (_) => JiliangjiProvider()),
//         ChangeNotifierProvider(create: (_) => KehufuProvider()),
//         ChangeNotifierProvider(create: (_) => KehuliProvider()),
//         ChangeNotifierProvider(create: (_) => JueseProvider()),
//         ChangeNotifierProvider(create: (_) => KehuxinProvider()),
//         ChangeNotifierProvider(create: (_) => ZuzhiProvider()),

//         // ➜ provider tambahan
//       ],
//       child: MaterialApp(
//         title: "ERP Monitoring",
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//           useMaterial3: true,
//         ),
//         home: const WarehouseListScreen(),
//       ),
//     );
//   }
// }

import 'package:erp_nuctech/providers/process_manage_provider.dart';
import 'package:erp_nuctech/providers/task_queue1_provider.dart';
import 'package:erp_nuctech/providers/weituodan_provider.dart';
import 'package:erp_nuctech/providers/weituodanleixing_provider.dart';
import 'package:erp_nuctech/providers/weituodanrenwu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/warehouse_provider.dart';
import 'providers/chanpinxian_provider.dart';
import 'providers/caozuo_provider.dart';
import 'providers/fahuo_provider.dart';
import 'providers/fuzhaojielunleixing_provider.dart';
import 'providers/fuzhaopi_provider.dart';
import 'providers/jiesuan_provider.dart';
import 'providers/jiliang_provider.dart';
import 'providers/jiliangji_provider.dart';
// import 'providers/kehufu_provider.dart';
import 'providers/kehuli_provider.dart';
import 'providers/juese_provider.dart';
import 'providers/kehuxin_provider.dart';
// import 'providers/zuzhi_provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // <<< LOGIN
        ChangeNotifierProvider(create: (_) => WarehouseProvider()),
        ChangeNotifierProvider(create: (_) => ChanPinXianProvider()),
        ChangeNotifierProvider(create: (_) => CaozuoProvider()),
        ChangeNotifierProvider(create: (_) => FahuoProvider()),
        ChangeNotifierProvider(create: (_) => FuzhaoProvider()),
        ChangeNotifierProvider(create: (_) => FuzhaopiProvider()),
        ChangeNotifierProvider(create: (_) => JiesuanProvider()),
        ChangeNotifierProvider(create: (_) => JiliangProvider()),
        ChangeNotifierProvider(create: (_) => JiliangjiProvider()),
        // ChangeNotifierProvider(create: (_) => KehufuProvider()),
        ChangeNotifierProvider(create: (_) => KehuliProvider()),
        ChangeNotifierProvider(create: (_) => JueseProvider()),
        ChangeNotifierProvider(create: (_) => KehuxinProvider()),
        // ChangeNotifierProvider(create: (_) => ZuzhiProvider()),
        ChangeNotifierProvider(create: (_) => WeituodanProvider()),
        ChangeNotifierProvider(create: (_) => WeituodanleixingProvider()),
        ChangeNotifierProvider(create: (_) => WeituodanrenwuProvider()),
        ChangeNotifierProvider(create: (_) => ProcessManageProvider()),
        ChangeNotifierProvider(create: (_) => TaskQueue1Provider()),
      ],
      child: MaterialApp(
        title: "ERP Monitoring",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
