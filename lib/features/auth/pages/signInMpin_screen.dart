// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:olopo_mpos/core/theme/theme.dart';
// import 'package:olopo_mpos/core/utilities/custom_snackBar.dart';
// import 'package:olopo_mpos/core/widgets/customAlertBox_widget.dart';
// import 'package:olopo_mpos/core/widgets/customNumberField.dart';
// import 'package:olopo_mpos/features/auth/controller/authController.dart';
//
// import '../../../../core/app_constants.dart';
// import '../../../../core/utilities/linear_loader.dart';
//
// class SignInMpinScreen extends ConsumerStatefulWidget {
//   final String phoneNo, userName;
//
//   SignInMpinScreen({super.key, required this.phoneNo, required this.userName});
//
//   @override
//   ConsumerState<SignInMpinScreen> createState() => _SignInMpinScreenState();
// }
//
// class _SignInMpinScreenState extends ConsumerState<SignInMpinScreen> {
//   final TextEditingController pinController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final isLoading = ref.watch(authControllerProvider);
//     return Scaffold(
//       body: SafeArea(
//         child: LayoutBuilder(builder: (context, constraints) {
//           final w = constraints.maxWidth;
//           final h = constraints.maxHeight;
//           return Container(
//             width: double.infinity,
//             padding:
//                 EdgeInsets.symmetric(vertical: h * .1, horizontal: w * .07),
//             decoration: AppTheme.commonGradientBackgroundDecoration,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: h * .07),
//                 SvgPicture.asset(
//                   AppConstants.appLogo,
//                   height: h * .1,
//                 ),
//                 SizedBox(height: h * .04),
//                 Text(
//                   'Welcome back ${widget.userName.toUpperCase()}',
//                   style: AppTheme.commonFontStyle(weight: FontWeight.w300),
//                 ),
//                 SizedBox(height: h * .04),
//
//                 const Text('Enter MPIN'),
//                 SizedBox(height: h * .045),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12, right: 12),
//                   child: CustomNumberField(
//                     length: 4,
//                     obscureText: true,
//                     controller: pinController,
//                     onCompleted: (value) {
//                       ref.read(authControllerProvider.notifier).userSignIn(
//                             phoneNo: widget.phoneNo,
//                             password: value,
//                             context: context,
//                           );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: h * .04),
//                 // TODO make this button a custom button
//                 Consumer(builder: (context, ref, child) {
//                   return Container(
//                     width: w * .8,
//                     margin: EdgeInsets.only(right: w * .008, left: w * .001),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         String password = pinController.text;
//                         if (password.length == 4) {
//                           ref.read(authControllerProvider.notifier).userSignIn(
//                                 phoneNo: widget.phoneNo,
//                                 password: password,
//                                 context: context,
//                               );
//                         } else {
//                           showSnackBar(
//                             content: 'Please enter all 4 digits',
//                             context: context,
//                             color: Colors.red,
//                           );
//                         }
//                       },
//                       style: AppTheme.commonButtonStyle,
//                       child: isLoading
//                           ? const LinearLoader()
//                           : Text(
//                               'Sign In',
//                               style: AppTheme.commonFontStyle(
//                                   color: Colors.white, size: w * .035),
//                             ),
//                     ),
//                   );
//                 }),
//                 GestureDetector(
//                   onTap: () => showCustomAlertDialog(
//                     context: context,
//                     title: 'Contact Admin',
//                     subTitle: 'You need to contact admin to reset MPIN',
//                     actionText: 'DONE',
//                   ),
//                   child: SizedBox(
//                       height: h * .1,
//                       width: w * .3,
//                       child: const Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Text('Forget MPIN'))),
//                 )
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
