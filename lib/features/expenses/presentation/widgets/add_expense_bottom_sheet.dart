import 'package:expense_tracker/core/utils/custom_snackbar.dart';
import 'package:expense_tracker/core/widgets/custom_alertBox.dart';
import 'package:expense_tracker/features/category/data/models/category_model.dart';
import 'package:expense_tracker/features/category/presentation/state/category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error_handling/error_text.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/customSearchable_dropDown.dart';
import '../../../../core/widgets/loader.dart';
import '../../../category/presentation/widgets/addCategory_bottom_sheet.dart';
import '../../data/models/expense_model.dart';
import '../state/expense_providers.dart';

class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  final Expense? expense;

  const AddExpenseBottomSheet({Key? key, this.expense}) : super(key: key);

  @override
  ConsumerState<AddExpenseBottomSheet> createState() =>
      _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends ConsumerState<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final selectedCategory = StateProvider<Category?>((ref) => null);
  final _selectedDateProvider = StateProvider<DateTime?>((ref) => null);

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      final expense = widget.expense!;
      _amountController.text = expense.amount.toString();
      _titleController.text = expense.title ?? "";
      _descriptionController.text = expense.description ?? "";
      loadData();
    }
  }

  void loadData() {
    Future.delayed(Duration.zero, () {
      ref.read(_selectedDateProvider.notifier).state = widget.expense?.date;
    });
  }

  void _pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(_selectedDateProvider) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      ref.read(_selectedDateProvider.notifier).state = selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        gradient: LinearGradient(
          colors: [gray, Colors.indigo.shade400],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: w * .025),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: w * .05),
                    child: InkWell(
                      onTap: () => _pickDate(context),
                      child: Column(
                        children: [
                          Text(
                              ref.watch(_selectedDateProvider) != null
                                  ? ref
                                      .watch(_selectedDateProvider)!
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]
                                  : "Choose date",
                              style: AppTheme.commonFontStyle()),
                          Icon(
                            CupertinoIcons.calendar_badge_plus,
                            size: w * .08,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: TextFormField(
                    controller: _amountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: w * .025),
                Flexible(
                  flex: 4,
                  child: Consumer(builder: (context, ref, child) {
                    return ref.watch(categoriesProvider).when(
                          data: (categories) {
                            if (ref.watch(selectedCategory) == null) {
                              Future.delayed(
                                Duration.zero,
                                () {
                                  if (widget.expense?.categoryId != null) {
                                    ref.read(selectedCategory.notifier).state =
                                        categories.firstWhere(
                                      (cat) =>
                                          cat.id.toString() ==
                                          widget.expense?.categoryId,
                                    );
                                  }
                                },
                              );
                            }

                            return categories.isEmpty
                                ? FittedBox(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          backgroundColor: Colors.white54,
                                        ),
                                        onPressed: () => showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  const AddCategoryBottomSheet(),
                                            ),
                                        child: Text(
                                          'Add Category',
                                          style: AppTheme.commonFontStyle(),
                                        )),
                                  )
                                : CustomSearchableDropdown(
                                    selectedItem: ref
                                        .watch(selectedCategory)
                                        ?.id
                                        .toString(),
                                    searchHint: "Search",
                                    hintText: "Category",
                                    items: categories
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      final selectedCategoryModel =
                                          categories.firstWhere(
                                        (category) =>
                                            category.id.toString() == value,
                                      );

                                      ref
                                          .read(selectedCategory.notifier)
                                          .state = selectedCategoryModel;
                                    },
                                  );
                          },
                          error: (error, stackTrace) =>
                              ErrorText(errorText: error.toString()),
                          loading: () => const Loader(),
                        );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 5,
              minLines: 2,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: AppTheme.commonButtonStyle,
              onPressed: _saveExpense,
              child: Text(
                widget.expense == null
                    ? 'Save Expense'
                    : 'Update ${widget.expense?.title}',
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Future<void> _saveExpense() async {
    if (_formKey.currentState!.validate() &&
        ref.watch(selectedCategory) != null) {
      final amount = double.parse(_amountController.text);
      final title = _titleController.text;
      final description = _descriptionController.text;
      final date = ref.watch(_selectedDateProvider) ?? DateTime.now();

      final categoryId = ref.watch(selectedCategory)!.id.toString();

      final expense = Expense(
        id: widget.expense?.id,
        categoryId: categoryId,
        amount: amount,
        title: title,
        description: description,
        date: date,
      );

      if (widget.expense == null) {
        ref.read(expenseListProvider.notifier).addExpense(expense);
      } else {
        ref.read(expenseListProvider.notifier).updateExpense(expense);
      }
      showSnackBar(
        content: "${expense.title} ✅ successfully",
        context: context,
        color: Colors.redAccent.withOpacity(.6),
      );

      await ref
          .read(categoryRepositoryProvider)
          .updateCategory(categoryId, amount);
      Navigator.of(context).pop();

      ref.refresh(categoriesProvider.future);
    } else {
      showCustomAlertDialog(
        title: 'Fill field and add category',
        context: context,
        icon: Icon(
          Icons.error_outline_sharp,
          size: MediaQuery.of(context).size.width * .3,
        ),
        actionText: 'Check',
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
