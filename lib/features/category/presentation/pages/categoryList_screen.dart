import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error_handling/error_text.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/loader.dart';
import '../../../expenses/presentation/state/progressBar_provider.dart';
import '../../../expenses/presentation/widgets/amount_progressBar.dart';
import '../state/category_provider.dart';
import '../widgets/addCategory_bottom_sheet.dart';
import '../widgets/category_list_tile.dart';

class CategoryListScreen extends ConsumerStatefulWidget {
  const CategoryListScreen({super.key});

  @override
  ConsumerState<CategoryListScreen> createState() => _SpendingAndBudgetsState();
}

class _SpendingAndBudgetsState extends ConsumerState<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    final categoriesAsync = ref.watch(categoriesProvider);
    final arcValues = ref.watch(arcValuesProvider);
    final totalAmount = ref.watch(totalAmountProvider);

    return Scaffold(
      backgroundColor: gray,
      body: Column(
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
                SizedBox(height: h * .075),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(bottom: 2),
                  child: InkWell(
                    splashColor: secondary,
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const AddCategoryBottomSheet(),
                      );
                    },
                    child: DottedBorder(
                      dashPattern: [5, 5],
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      color: border.withOpacity(0.2),
                      child: Container(
                        height: size.width * .12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add new category",
                              style: TextStyle(
                                color: gray30,
                                fontSize: w * .042,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              "assets/img/add.png",
                              width: 15,
                              height: 15,
                              color: gray30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RefreshIndicator(
            backgroundColor: Colors.redAccent,
            color: Colors.white,
            onRefresh: () => ref.refresh(categoriesProvider.future),
            child: SizedBox(
              height: size.height * .41,
              child: categoriesAsync.when(
                data: (categories) => categories.isEmpty
                    ? const Center(child: Text('No categories available.'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final reverse = categories.length - 1 - index;
                          final category = categories[reverse];
                          return CategoryItem(
                            category: category,
                          );
                        },
                      ),
                error: (error, stackTrace) =>
                    ErrorText(errorText: error.toString()),
                loading: () => const Loader(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
