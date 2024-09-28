import 'package:hive/hive.dart';

part 'add_bank_model.g.dart';
@HiveType(typeId: 0)
class AddBankModel extends HiveObject {
  AddBankModel({
    required this.bankName,
    required this.amount,
    required this.year,
    required this.percent,
    required this.finalAmount,
    this.createAt,
     this.amountAfterYears,
  });

  @HiveField(0)
  String bankName;

  @HiveField(1)
  String amount;

  @HiveField(2)
  String year;
  @HiveField(3)
  String percent;
  @HiveField(4)
  String finalAmount;
  @HiveField(5)
  String? amountAfterYears;
 

  @HiveField(6)
 DateTime? createAt;
}
