import 'dart:math';

import 'package:bank/presentation/view/screens/show_banks.dart';
import 'package:bank/presentation/view_model/cubit/bank_cubit.dart';
import 'package:bank/presentation/view_model/cubit/bank_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBankScreen extends StatelessWidget {
  const AddBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => BankCubit(),
      child: BlocConsumer<BankCubit, BankState>(
        listener: (context, state) {
          if (state is successBankState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ShowBankAccounts(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<BankCubit>();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Calculate Interest'),
               actions: [
                IconButton(
                  icon: Icon(Icons.cancel,color: Colors.red,),
                  onPressed: () {
                    // قم بتنفيذ التعديلات المطلوبة
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowBankAccounts(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: cubit.bankController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          // التحقق إذا كان الحقل فارغًا
                          if (value == null || value.isEmpty) {
                            return 'Please enter the bank name';
                          }
                          return null; // إذا لم يكن هناك خطأ
                        },
                        decoration: const InputDecoration(
                          hintText: 'bank name here',
                          labelText: 'bank name here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const  SizedBox(height: 16),
                      TextFormField(
                         validator: (value) {
                          // التحقق إذا كان الحقل فارغًا
                          if (value == null || value.isEmpty) {
                            return 'Please enter the amount';
                          }
                          return null; // إذا لم يكن هناك خطأ
                        },
                        controller: cubit.amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'amount here',
                          hintText: 'amount here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                         validator: (value) {
                          // التحقق إذا كان الحقل فارغًا
                          if (value == null || value.isEmpty) {
                            return 'Please enter the year';
                          }
                          return null; // إذا لم يكن هناك خطأ
                        },
                        controller: cubit.yearController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'year here',
                          labelText: 'year here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                         validator: (value) {
                          // التحقق إذا كان الحقل فارغًا
                          if (value == null || value.isEmpty) {
                            return 'Please enter the percent';
                          }
                          return null; // إذا لم يكن هناك خطأ
                        },
                        controller: cubit.percentController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'percent here',
                          labelText: 'percent here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                          cubit.addBank(context);
                          
                          }
                        },
                        child: const Text('Add Account'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        cubit.result,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
