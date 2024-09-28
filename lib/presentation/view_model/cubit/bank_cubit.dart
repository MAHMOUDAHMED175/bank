import 'dart:math';
import 'package:bank/data/hive/hive_database.dart';
import 'package:bank/data/models/add_bank_model.dart';
import 'package:bank/presentation/view_model/cubit/bank_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit() : super(initBankState());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  String result = '';
  String finalAmount = '';

  Future<void> addBank(context) async {
    try {
      emit(loadingBankState());
      if (amountController.text.isEmpty ||
          yearController.text.isEmpty ||
          percentController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all data')),
        );
        return;
      }

      // حساب المبلغ النهائي
      finalAmount = (
        int.parse(amountController.text) *
            (pow(
              (1 + (int.parse(percentController.text) / 100.0)),
              int.parse(yearController.text),
            )),
      ).toString();

      await HiveDatabase().bankBox!.add(
            AddBankModel(
              amount: amountController.text,
              finalAmount: finalAmount,
              bankName: bankController.text,
              percent: percentController.text,
              year: yearController.text,
              createAt: DateTime.now(),
              amountAfterYears: (
                int.parse(amountController.text) *
                    (pow(
                      (1 + (int.parse(percentController.text) / 100.0)),
                      int.parse(yearController.text),
                    )),
              ).toString(),
            ),
          );
      emit(successBankState());
    } catch (e) {
      emit(errorBankState());
    }
  }

  Future<void> deleteBank(int index) async {
    try {
      emit(loadingDeleteBankState());
      await HiveDatabase().bankBox!.deleteAt(index);
      emit(successDeleteBankState());
    } catch (e) {
      emit(errorDeleteBankState());
    }
  }

  // // وظيفة التعديل
  // Future<void> editBank(int index, AddBankModel updatedModel, context) async {
  //   try {
  //     emit(loadingEditeBankState());

  //     // حساب المبلغ النهائي
  //     finalAmount = (
  //       int.parse(amountController.text) *
  //           (pow(
  //             (1 + (int.parse(percentController.text) / 100.0)),
  //             int.parse(yearController.text),
  //           )),
  //     ).toString();

  //     await HiveDatabase().bankBox!.putAt(
  //           index,
  //           AddBankModel(
  //             amount: updatedModel.amount,
  //             finalAmount: finalAmount,
  //             bankName: updatedModel.bankName,
  //             percent: updatedModel.percent,
  //             year: updatedModel.year,
  //           ),
  //         );
  //     emit(successEditeBankState());
  //   } catch (e) {
  //     emit(errorEditeBankState());
  //   }
  // }

  List<AddBankModel> get bankList {
    return HiveDatabase().bankBox!.values.toList();
  }

  // تحديث المبلغ كل ثانية
  void calcFinalAmount(
    DateTime createAt,
    double initialAmount,
    double percentPerSecond,
    int index,
    AddBankModel Model,
    context,
  ) {
    // إنشاء مؤقت جديد
    final hoursPassed = DateTime.now().difference(createAt).inSeconds;

    final updatedAmount =
        initialAmount * pow((1 + percentPerSecond / 100), hoursPassed);

    Model.finalAmount = updatedAmount.toString();

    // editBank(index, Model, context);

    // تحديث الحالة مع المبلغ الجديد
    emit(timerBankState());
  }

  double money = 0.0;
  void calculateFinalAmount(double initialAmount, double percent,
      DateTime createdat, DateTime endDate) {
    final difference = endDate.difference(createdat).inSeconds;
    money = initialAmount *
        pow((1 + percent / 100), difference / (365 * 24 * 60 * 60));

    print(
        'ssssssssssssss${endDate.toString()} dd${createdat.toString()} wwwwwwwwwwwwwwwww${initialAmount.toString()}ddddddddddddddddddd${percent.toString()}gggggggggggggg${difference.toString()}');
    print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu' + money.toString());
    emit(AmmountafterBankState());
  }
}
