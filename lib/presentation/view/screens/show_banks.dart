import 'dart:async';

import 'package:bank/presentation/view/screens/add_bank_screen.dart';
import 'package:bank/presentation/view/widgets/Item_list-accounts-bank.dart';
import 'package:bank/presentation/view_model/cubit/bank_cubit.dart';
import 'package:bank/presentation/view_model/cubit/bank_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowBankAccounts extends StatelessWidget {
  const ShowBankAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BankCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Accounts'),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddBankScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.add_rounded)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.black),
              color: Colors.blue.withOpacity(0.4),
            ),
            child: BlocConsumer<BankCubit, BankState>(
              listener: (context, state) {},
              builder: (context, state) {
                final cubit = context.read<BankCubit>();
                if (state is loadingBankState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (context.read<BankCubit>().bankList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.separated(
                        addAutomaticKeepAlives: true,
                        itemCount: cubit.bankList.length,
                        itemBuilder: (context, index) {
                          Timer(Duration(seconds: 1), () {
                            final bank = cubit.bankList;
                            // استدعاء دالة التحديث بعد إنشاء الواجهة
                            cubit.calcFinalAmount(
                                bank[index].createAt!, // وقت إنشاء الحساب
                                double.parse(
                                    bank[index].amount), // المبلغ الأصلي
                                double.parse(
                                    '${double.parse(bank[index].percent) / (365 * 24 * 60 *60)}'),
                                index,
                                bank[index],
                                context

                                // النسبة لكل ثانية
                                );
                          });

                          return itemListAccountsBank(
                              context: context,
                              index: index,
                              model: cubit.bankList[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No accounts found.',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddBankScreen()),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.add_box)),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
