// import 'package:fzbill/core/error_handling/failure.dart';
// import 'package:sqflite/sqflite.dart';
//
// class HandleErrors {
//   static Failure handleError({required Object e}) {
//     if (e is DatabaseException) {
//       if (e.isUniqueConstraintError()) {
//         return Failure(errMsg: "Unique constraint error: ${e.result}");
//       } else if (e.isSyntaxError()) {
//         return Failure(errMsg: "Syntax error: ${e.result}");
//       } else if (e.isOpenFailedError()) {
//         return Failure(errMsg: "Failed to open database: ${e.result}");
//       } else {
//         return Failure(errMsg: "Database error: ${e.result}");
//       }
//     } else {
//       return Failure(errMsg: "An unexpected error occurred: ${e.toString()}");
//     }
//   }
// }
