import 'package:bank/data/models/add_bank_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  factory HiveDatabase() => _instance;

  HiveDatabase._();

  static final HiveDatabase _instance = HiveDatabase._();

  Box<AddBankModel>? bankBox;

  Future<void> setup() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AddBankModelAdapter());

    bankBox =
        await Hive.openBox<AddBankModel>('bank_box');

  }

  Future<void> clearAllBox() async {
    await bankBox!.clear();
  }
  
}
