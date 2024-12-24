import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/custom_alertBox.dart';
import '../../data/models/expense_model.dart';
import '../state/expense_providers.dart';
import 'add_expense_bottom_sheet.dart';

class ExpenseListTile extends ConsumerStatefulWidget {
  final Expense expense;

  const ExpenseListTile({
    super.key,
    required this.expense,
  });

  @override
  ConsumerState<ExpenseListTile> createState() => _ExpenseListTileState();
}

class _ExpenseListTileState extends ConsumerState<ExpenseListTile> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; // Use MediaQuery everywhere
    final h = MediaQuery.sizeOf(context).height;

    return Dismissible(
      key: Key(widget.expense.id.toString()),
      direction: DismissDirection.horizontal,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red.shade800,
        alignment: Alignment.centerRight,
        child: Icon(
          CupertinoIcons.delete,
          color: Colors.white,
          size: w * .07,
        ),
      ),
      confirmDismiss: (direction) async {
        final result = await showCustomAlertDialog(
          context: context,
          title: 'Confirm to delete?',
          actionText: 'Delete',
          icon: Icon(
            CupertinoIcons.delete_simple,
            size: h * .1,
            color: AppTheme.whiteSnack,
          ),
        );
        return result == true;
      },
      onDismissed: (direction) => ref
          .read(expenseListProvider.notifier)
          .deleteExpense(widget.expense, context),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            color: gray70.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              minVerticalPadding: h * .02,
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) =>
                    AddExpenseBottomSheet(expense: widget.expense),
              ),
              trailing: SizedBox(
                width: w * .3,
                child: Text(
                  '₹ ${widget.expense.amount.toStringAsFixed(2)}', // Add rupee symbol
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: h * .018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                widget.expense.title ?? "No title",
                style: AppTheme.commonFontStyle(size: w * .05),
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd, hh:mm a')
                    .format(widget.expense.date.toLocal()),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: -12,
            right: 5,
            child: IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) =>
                    AddExpenseBottomSheet(expense: widget.expense),
              ),
              icon: Icon(
                CupertinoIcons.pencil_outline,
                size: w * .07,
              ),
            ),
          )
        ],
      ),
    );
  }
}
