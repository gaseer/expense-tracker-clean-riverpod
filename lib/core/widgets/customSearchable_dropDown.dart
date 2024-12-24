import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/colors.dart';

class CustomSearchableDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String? selectedItem;
  final String? hintText;
  final String? searchHint;
  final void Function(String?)? onChanged;

  const CustomSearchableDropdown(
      {super.key,
      required this.items,
      this.selectedItem,
      this.hintText,
      this.onChanged,
      this.searchHint});

  @override
  CustomSearchableDropdownState createState() =>
      CustomSearchableDropdownState();
}

class CustomSearchableDropdownState extends State<CustomSearchableDropdown> {
  final TextEditingController _dropSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[700] ?? Colors.grey),
      ),
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          widget.hintText ?? "Select item",
          style: AppTheme.commonFontStyle(),
        ),
        items: widget.items,
        value: widget.selectedItem,
        style: AppTheme.commonFontStyle(color: Colors.white),
        underline: SizedBox(),
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            color: gray70.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: h * .063,
          width: w,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: h * .23,
          offset: Offset(0, h * .06),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: h * .04,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: _dropSearchController,
          searchInnerWidgetHeight: h * .1,
          searchInnerWidget: SizedBox(
            height: h * .065,
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: _dropSearchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.searchHint ?? 'Search for an item...',
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[700] ?? Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.errorColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.commonColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.errorColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[700] ?? Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            Text textWidget = item.child as Text;
            String extractedText = textWidget.data ?? "";

            final String itemText = extractedText.toString().toLowerCase();
            final String searchValueText = searchValue.toLowerCase();
            return itemText.contains(searchValueText);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            _dropSearchController.clear();
          }
        },
      ),
    );
  }
}
