import 'package:bank/data/hive/hive_database.dart';
import 'package:bank/presentation/view/screens/add_bank_screen.dart';
import 'package:bank/presentation/view/screens/show_banks.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await HiveDatabase().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowBankAccounts(),
    );
  }
}
