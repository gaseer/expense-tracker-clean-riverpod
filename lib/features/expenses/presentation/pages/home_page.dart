import 'package:expense_tracker/core/utils/colors.dart';
import 'package:expense_tracker/core/widgets/customDateSwitchButton.dart';
import 'package:expense_tracker/features/expenses/presentation/pages/expenseList_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../category/presentation/pages/categoryList_screen.dart';
import '../../../category/presentation/widgets/addCategory_bottom_sheet.dart';
import '../state/expense_providers.dart';
import '../widgets/add_expense_bottom_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final selectedScreenIndexProvider = StateProvider<int>((ref) => 0);
  final PageController _pageController = PageController();

  final List<Widget> _tabs = [
    const ExpenseListScreen(),
    const CategoryListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        backgroundColor: gray,
        title: Text(
          'Expense Tracker',
          style: AppTheme.formTextStyle.copyWith(fontSize: w * .055),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                ref.read(selectedDateProvider.notifier).state = selectedDate;
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(expenseListProvider.notifier).loadExpenses(),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              ref.read(selectedScreenIndexProvider.notifier).state = index;
            },
            children: _tabs,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * .01, vertical: h * .025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    builldTabIcon(
                      iconPath: "assets/img/home.png",
                      index: 0,
                    ),
                    builldTabIcon(
                      iconPath: "assets/img/budgets.png",
                      index: 1,
                    ),
                  ],
                )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: w * .16,
        height: h * .072,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [secondary50, Colors.redAccent.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 18,
              offset: Offset(5, 4), // Shadow position
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            ref.read(selectedContainerProvider.notifier).state = 5;
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => ref.watch(selectedScreenIndexProvider) == 0
                  ? const AddExpenseBottomSheet()
                  : const AddCategoryBottomSheet(),
            );
          },
          backgroundColor: Colors.transparent,
          child: Icon(
            CupertinoIcons.arrow_down_doc,
            color: Colors.white,
            size: w * .075, // Icon size
          ),
        ),
      ),
    );
  }

  void _showSortDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sort Expenses'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Ascending Date'),
                leading: Radio<String>(
                  value: 'ascending',
                  groupValue:
                      ref.read(expenseListProvider.notifier).currentSortOrder,
                  onChanged: (value) {
                    ref
                        .read(expenseListProvider.notifier)
                        .sortByDate(ascending: true);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: const Text('Descending Date'),
                leading: Radio<String>(
                  value: 'descending',
                  groupValue:
                      ref.read(expenseListProvider.notifier).currentSortOrder,
                  onChanged: (value) {
                    ref
                        .read(expenseListProvider.notifier)
                        .sortByDate(ascending: false);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container builldTabIcon({required String iconPath, required int index}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(7, 129, 234, 0.3686274509803922),
              blurRadius: 55,
              offset: Offset(2, 12),
              spreadRadius: 5,
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            _pageController.jumpToPage(index);
            ref.read(selectedScreenIndexProvider.notifier).state = index;
          },
          icon: Image.asset(
            iconPath,
            width: 30,
            height: ref.watch(selectedScreenIndexProvider) == index ? 55 : 22,
            color: ref.watch(selectedScreenIndexProvider) == index
                ? Colors.white
                : gray30,
          ),
        ),
      );
}
