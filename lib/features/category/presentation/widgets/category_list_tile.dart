import 'package:expense_tracker/core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: gray70.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: border.withOpacity(0.05),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          height: h * .08,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w * .15,
                    height: h * .05,
                    child: CircleAvatar(
                      backgroundColor: Color(category.colorCode ?? 0xffFF7966),
                      child: Text(
                        category.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                            fontSize: w * .062,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   child: Image.asset(
                  //     'assets/img/entertainment.png',
                  //     height: h * .075,
                  //     color: gray40,
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.name,
                      style: AppTheme.commonFontStyle(size: w * .045),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "₹ ${category.amount}  ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: h * .019,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
