import 'dart:async';

import 'package:bank/data/models/add_bank_model.dart';
import 'package:bank/presentation/view/screens/edit_bank_screen.dart';
import 'package:bank/presentation/view_model/cubit/bank_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Widget itemListAccountsBank(
    {required AddBankModel model,
    required BuildContext context,
    required int index}) {
  DateTime selectedDateTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


  Future<void> _selectDateTime() async {
    // اختيار التاريخ
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // اختيار الوقت
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

   //d
      if (pickedTime != null) {
        // دمج التاريخ والوقت المختار

        selectedDateTime = DateTime(
          
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
          DateTime.now().second,
        );

        // حساب الفرق بين التاريخ والوقت الحالي والمختار بالثواني
      

        print('Selected DateTime: $selectedDateTime');
      }
    }
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      border: Border.all(color: Colors.black),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       // Navigator.pushAndRemoveUntil(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //       builder: (context) => EditBankScreen(
              //       //         index: index,
              //       //         model: model,
              //       //       ),
              //       //     ),
              //       //     (route) => false);
              //     },
              //     icon: const Icon(
              //       Icons.edit,
              //       color: Colors.amber,
              //     )),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    context.read<BankCubit>().deleteBank(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          Row(
            children: [
              const Text(
                'Bank Name : ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(),
              Text(
                model.bankName,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              const Text(
                'Amount : ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(),
              Text(
                model.amount,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              const Text(
                'Years : ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(),
              Text(
                model.year,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              const Text(
                'Percentage : ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(),
              Text(
                model.percent + '%',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              const Text(
                'Date Ceated : ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(),
              Text(
                DateFormat('yyyy-MM-dd – kk:mm')
                    .format(model.createAt ?? DateTime.now()),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  'Amount After second: ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Spacer(),
                Text(
                  model.finalAmount,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'Final Amount After ${model.year} years : ',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model.amountAfterYears.toString(),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: _selectDateTime, child: Text('Amount After Unknown Date')),
          TextButton(
              onPressed: () {
                context.read<BankCubit>().calculateFinalAmount(
                    double.parse(model.amount),
                    double.parse(model.percent),
                    model.createAt!,
                    selectedDateTime);
              },
              child: Text('${context.read<BankCubit>().money.toString()}')),
        ],
      ),
    ),
  );
}
