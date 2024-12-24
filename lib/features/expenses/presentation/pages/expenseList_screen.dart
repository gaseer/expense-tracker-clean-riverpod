import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/customDateSwitchButton.dart';
import '../state/expense_providers.dart';
import '../state/progressBar_provider.dart';
import '../widgets/amount_progressBar.dart';
import '../widgets/expense_list_tile.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  ConsumerState<ExpenseListScreen> createState() => _HomeScreenTrackizerState();
}

class _HomeScreenTrackizerState extends ConsumerState<ExpenseListScreen> {
  bool isSubscription = true;

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(filteredExpenseListProvider);
    final selectedIndex = ref.watch(selectedContainerProvider);
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final arcValues = ref.watch(arcValuesProvider);
    final totalAmount = ref.watch(totalAmountProvider);

    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: h * .075),
              padding: EdgeInsets.only(bottom: h * .03),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/home_bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: w * 0.5,
                        height: w * 0.3,
                        child: CustomPaint(
                          painter: AmountProgressBar(
                            drwArcs: arcValues,
                            end: 50,
                            width: 13,
                            bgWidth: 8,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "₹$totalAmount",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * .065,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Total expense amount",
                            style: TextStyle(
                              color: gray30,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(height: h * .08),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * .07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDateSwitchButton(
                          w: w,
                          label: 'Week',
                          index: 0,
                          isSelected: selectedIndex == 0,
                        ),
                        CustomDateSwitchButton(
                          w: w,
                          label: 'Month',
                          index: 1,
                          isSelected: selectedIndex == 1,
                        ),
                        CustomDateSwitchButton(
                          w: w,
                          label: 'Year',
                          index: 2,
                          isSelected: selectedIndex == 2,
                        ),
                        Container(
                          width: w * .15,
                          height: w * .12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ref.watch(selectedContainerProvider) == 3
                                ? gray60
                                : gray,
                            border: Border.all(
                              color: Colors.white30,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.calendar_today),
                            onPressed: () async {
                              ref
                                  .read(selectedContainerProvider.notifier)
                                  .state = 3;
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );

                              if (selectedDate != null) {
                                ref.read(selectedDateProvider.notifier).state =
                                    selectedDate;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * .01),
            RefreshIndicator(
              backgroundColor: Colors.redAccent,
              color: Colors.white,
              onRefresh: () =>
                  ref.refresh(expenseListProvider.notifier).loadExpenses(),
              child: SizedBox(
                height: h * .4,
                child: expenses.isEmpty
                    ? const Center(child: Text('No expenses to display.'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[expenses.length - index - 1];
                          return ExpenseListTile(expense: expense);
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
