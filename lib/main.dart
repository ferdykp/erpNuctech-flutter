// import 'package:erp_nuctech/models/jiliang_model.dart';
import 'package:erp_nuctech/providers/zuzhi_provider.dart';
import 'package:erp_nuctech/providers/juese_provider.dart';
import 'package:erp_nuctech/providers/kehuli_provider.dart';
import 'package:erp_nuctech/providers/caozuo_provider.dart';
import 'package:erp_nuctech/providers/fahuo_provider.dart';
import 'package:erp_nuctech/providers/fuzhaojielunleixing_provider.dart';
import 'package:erp_nuctech/providers/fuzhaopi_provider.dart';
import 'package:erp_nuctech/providers/jiesuan_provider.dart';
import 'package:erp_nuctech/providers/jiliang_provider.dart';
import 'package:erp_nuctech/providers/jiliangji_provider.dart';
import 'package:erp_nuctech/providers/kehufu_provider.dart';
import 'package:erp_nuctech/providers/kehuxin_provider.dart';
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
        ChangeNotifierProvider(create: (_) => FuzhaopiProvider()),
        ChangeNotifierProvider(create: (_) => JiesuanProvider()),
        ChangeNotifierProvider(create: (_) => JiliangProvider()),
        ChangeNotifierProvider(create: (_) => JiliangjiProvider()),
        ChangeNotifierProvider(create: (_) => KehufuProvider()),
        ChangeNotifierProvider(create: (_) => KehuliProvider()),
        ChangeNotifierProvider(create: (_) => JueseProvider()),
        ChangeNotifierProvider(create: (_) => KehuxinProvider()),
        ChangeNotifierProvider(create: (_) => ZuzhiProvider()),

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
