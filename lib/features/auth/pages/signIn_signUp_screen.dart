// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SignInScreen extends ConsumerStatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   ConsumerState<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends ConsumerState<SignInScreen> {
//   TextEditingController phoneNumController = TextEditingController();
//   final isRegisterScreenProvider = StateProvider<bool>((ref) => false);
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkInternetConnection(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isLoading = ref.watch(authControllerProvider);
//     final isRegisterScreen = ref.watch(isRegisterScreenProvider);
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
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(height: h * .03),
//                 SvgPicture.asset(
//                   AppConstants.shopLoginImg,
//                   height: h * .33,
//                 ),
//                 isRegisterScreen
//                     ? buildSignUpContent(h, w, isLoading, context)
//                     : buildSIgnInContent(h, w, isLoading, context),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Column buildSIgnInContent(
//       double h, double w, bool isLoading, BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: h * .02),
//         Text(
//           'Sign in',
//           style: AppTheme.commonFontStyle(size: h * .03),
//         ),
//         Text(
//           'Enter your registered mobile',
//           style: AppTheme.commonFontStyle(
//             size: h * .02,
//             weight: FontWeight.w300,
//             color: AppTheme.secondaryTextColor,
//           ),
//         ),
//         SizedBox(height: h * .02),
//         SizedBox(
//           height: h * .12,
//           child: Row(
//             children: [
//               Container(
//                 color: const Color(0xff242629),
//                 width: w * .2,
//                 height: 50,
//                 margin: EdgeInsets.only(right: w * .03),
//                 child: const Center(child: Text('+91')),
//               ),
//               Container(
//                 width: w * .62,
//                 color: const Color(0xff242629),
//                 padding: EdgeInsets.only(left: w * .03),
//                 child: TextFormField(
//                   controller: phoneNumController,
//                   readOnly: isLoading,
//                   cursorColor: Colors.grey,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(10),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       fillColor: const Color(0xff242629),
//                       hintText: 'Enter Your Number',
//                       hintStyle: AppTheme.formTextStyle),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: h * .01),
//         Consumer(builder: (context, ref, child) {
//           return Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(right: h * .008, left: h * .001),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   String phoneNumber = phoneNumController.text.trim();
//                   ref.read(userPhoneNumberProvider.notifier).state =
//                       phoneNumber;
//
//                   if (validatePhoneNumber(phoneNumber)) {
//                     await ref
//                         .read(authControllerProvider.notifier)
//                         .verifyMobileNum(
//                           context: context,
//                           phoneNo: '+91$phoneNumber',
//                         );
//                   } else {
//                     showSnackBar(
//                         content: 'Please enter a valid number.',
//                         context: context,
//                         color: AppTheme.errorColor);
//                   }
//                 },
//                 style: AppTheme.commonButtonStyle,
//                 child: isLoading
//                     ? const LinearLoader()
//                     : Text(
//                         'Continue',
//                         style: AppTheme.commonFontStyle(
//                             color: Colors.white, size: w * .035),
//                       ),
//               ));
//         }),
//         SizedBox(height: h * .03),
//         GestureDetector(
//           onTap: () => ref.read(isRegisterScreenProvider.notifier).state = true,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Don’t have account? ',
//                 style: AppTheme.commonFontStyle(
//                         color: AppTheme.secondaryTextColor, size: w * .035)
//                     .copyWith(fontWeight: FontWeight.w400),
//               ),
//               Text(
//                 'Register',
//                 style: AppTheme.commonFontStyle(
//                     color: AppTheme.commonColor, size: w * .035),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Column buildSignUpContent(
//       double h, double w, bool isLoading, BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: h * .02),
//         Text(
//           'Create Account',
//           style: AppTheme.commonFontStyle(size: h * .03),
//         ),
//         Text(
//           'Enter your mobile',
//           style: AppTheme.commonFontStyle(
//               size: h * .02,
//               weight: FontWeight.w300,
//               color: AppTheme.secondaryTextColor),
//         ),
//         SizedBox(height: h * .02),
//         SizedBox(
//           height: h * .12,
//           child: Row(
//             children: [
//               Container(
//                 color: const Color(0xff242629),
//                 width: w * .2,
//                 height: w * .13,
//                 margin: EdgeInsets.only(right: w * .03),
//                 child: const Center(child: Text('+91')),
//               ),
//               Container(
//                 width: w * .62,
//                 color: const Color(0xff242629),
//                 padding: EdgeInsets.only(left: w * .03),
//                 child: TextFormField(
//                   controller: phoneNumController,
//                   cursorColor: Colors.grey,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(10),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     fillColor: const Color(0xff242629),
//                     hintStyle: AppTheme.formTextStyle,
//                     hintText: 'Enter Your Number',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: h * .01),
//         Consumer(
//           builder: (context, ref, child) {
//             return Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(right: h * .008, left: h * .001),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   String phoneNumber = phoneNumController.text.trim();
//                   ref.read(userPhoneNumberProvider.notifier).state =
//                       phoneNumber;
//                   if (validatePhoneNumber(phoneNumber)) {
//                     await ref
//                         .read(authControllerProvider.notifier)
//                         .verifyMobileNum(
//                           context: context,
//                           phoneNo: '+91$phoneNumber',
//                           verifyRegisterSection: true,
//                         );
//                   } else {
//                     showSnackBar(
//                       content: 'Please enter a valid number.',
//                       context: context,
//                       color: AppTheme.orangeee,
//                     );
//                   }
//                 },
//                 style: AppTheme.commonButtonStyle,
//                 child: isLoading
//                     ? const LinearLoader()
//                     : Text(
//                         'Get Code',
//                         style: AppTheme.commonFontStyle(
//                             color: Colors.white, size: w * .035),
//                       ),
//               ),
//             );
//           },
//         ),
//         SizedBox(height: h * .03),
//         GestureDetector(
//           onTap: () =>
//               ref.read(isRegisterScreenProvider.notifier).state = false,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Already have an account? ',
//                 style: AppTheme.commonFontStyle(
//                         color: AppTheme.secondaryTextColor, size: w * .035)
//                     .copyWith(fontWeight: FontWeight.w400),
//               ),
//               Text(
//                 'Sign In',
//                 style: AppTheme.commonFontStyle(
//                   color: AppTheme.commonColor,
//                   size: w * .035,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
