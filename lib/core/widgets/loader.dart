import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: gray30,
      ),
    );
  }
}
