// import 'package:flutter/material.dart';
// import '../giver/home.dart';

// class done extends StatefulWidget {
//   final bool status;

//   const done({Key? key, required this.status}) : super(key: key);

//   @override
//   State<done> createState() => _doneState();
// }

// class _doneState extends State<done> {
//   fun() async {
//     await Future.delayed(const Duration(seconds: 2));
//     // ignore: use_build_context_synchronously
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const g_home()),
//       (route) => false,
//     );
//   }

//   @override
//   void initState() {
//     //fun();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: widget.status
//                 ? Column(
//                     children: [
//                       Image.asset(
//                         'assets/done.jpg',
//                         scale: 3,
//                       ),
//                       const Text("verifyed",
//                       )
//                     ],
//                   )
//                 : Image.asset(
//                     'assets/cancle.jpg',
//                     scale: 3,
//                   ),
//           ),
//           Image.asset(
//             'assets/cancle.jpg',
//             scale: 3,
//           ),
//         ],
//       ),
//     );
//   }
// }
