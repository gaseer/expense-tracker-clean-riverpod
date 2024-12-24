import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../data/models/category_model.dart';
import '../state/category_provider.dart';

class AddCategoryBottomSheet extends ConsumerStatefulWidget {
  const AddCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCategoryBottomSheet> createState() =>
      _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState
    extends ConsumerState<AddCategoryBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _amountController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Existing expense amount'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: AppTheme.commonButtonStyle,
              onPressed: () {
                final randomColor = generateRandomColor();

                if (_formKey.currentState!.validate()) {
                  final category = Category(
                    name: _nameController.text,
                    amount: double.tryParse(_amountController.text) ?? 0,
                    colorCode: randomColor,
                  );
                  ref.read(addCategoryUseCaseProvider).execute(category);
                  ref.refresh(categoriesProvider.future);
                  Navigator.of(context).pop();
                  showSnackBar(
                    content: "${_nameController.text} added ✅",
                    context: context,
                    color: Colors.redAccent.withOpacity(.6),
                  );
                }
              },
              child: const Text('Save Category'),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  int generateRandomColor() {
    final random = Random();
    return (0xFF << 24) |
        (random.nextInt(256) << 16) |
        (random.nextInt(256) << 8) |
        random.nextInt(256);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
