// import 'package:flutter/material.dart';

// class SignupSignin extends StatefulWidget {
//   const SignupSignin({super.key});

//   @override
//   State<SignupSignin> createState() => _SignupSigninState();
// }

// class _SignupSigninState extends State<SignupSignin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           MyTextField(
//             initialValue: '',
//             obscureText: false,
//             labelText: 'Email Address',
//             keyboardType: TextInputType.emailAddress,
//           ),
//           SizedBox(height: 30),
//           MyTextField(
//             initialValue: '',
//             obscureText: true,
//             labelText: "Password",
//             keyboardType: TextInputType.visiblePassword,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyTextField extends StatelessWidget {
//   final String initialValue;
//   final String labelText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   const MyTextField({
//     super.key,
//     required this.labelText,
//     required this.keyboardType,
//     required this.obscureText,
//     required this.initialValue,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: TextFormField(
//         initialValue: initialValue,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: labelText,
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
// }
