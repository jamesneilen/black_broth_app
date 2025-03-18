import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/views/home/home_screen.dart';
import 'package:black_broth/widgets/mybotton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();

  bool isLogin = true;
  bool _isObscureSignup = true;
  bool _isObscureLogin = true;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmailController.text.trim(),
          password: _loginPasswordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        showError(e);
      }
    }
  }

  void signupUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _signupEmailController.text.trim(),
          password: _signupPasswordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        showError(e);
      }
    }
  }

  void showError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password. Try again.';
        break;
      case 'email-already-in-use':
        message = 'This email is already registered.';
        break;
      case 'weak-password':
        message = 'Password should be at least 6 characters.';
        break;
      default:
        message = 'Authentication failed. Please try again.';
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: isLogin ? buildLoginForm() : buildSignupForm(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset(
              'assets/icons/broth_logo.png',
              width: 100,
              height: 100,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab('Login', true),
              const SizedBox(width: 60),
              _buildTab('Sign-up', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isLoginTab) {
    return GestureDetector(
      onTap: () => setState(() => isLogin = isLoginTab),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (isLogin == isLoginTab)
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 80,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField('Email', _loginEmailController, false),
        _buildInputField(
          'Password',
          _loginPasswordController,
          true,
          _isObscureLogin,
          () {
            setState(() => _isObscureLogin = !_isObscureLogin);
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot passcode?',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        _buildActionButton('Login', loginUser),
      ],
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    bool isPassword, [
    bool? isObscure,
    VoidCallback? toggleVisibility,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? (isObscure ?? false) : false,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isObscure! ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: toggleVisibility,
                  )
                  : null,
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return '$label cannot be empty';
        //   }
        //   if (label == 'Email' &&
        //       !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$").hasMatch(value)) {
        //     return 'Enter a valid email';
        //   }
        //   if (label == 'Password' && value.length < 6) {
        //     return 'Password must be at least 6 characters';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Widget buildSignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField('Full Name', _nameController, false),
        _buildInputField('Email', _signupEmailController, false),
        _buildInputField(
          'Password',
          _signupPasswordController,
          true,
          _isObscureSignup,
          () {
            setState(() => _isObscureSignup = !_isObscureSignup);
          },
        ),
        _buildActionButton('Sign-up', signupUser),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(onTap: onTap, child: MyBotton(text: label)),
    );
  }
}

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _loginEmailController = TextEditingController();
//   final TextEditingController _loginPasswordController =
//       TextEditingController();
//   final TextEditingController _signupEmailController = TextEditingController();
//   final TextEditingController _signupPasswordController =
//       TextEditingController();
//   bool isLogin = true;
//   bool _isObscureLogin = true;
//   bool _isObscureSignup = true;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       }
//     });
//   }

//   void loginUser() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _loginEmailController.text.trim(),
//           password: _loginPasswordController.text.trim(),
//         );
//       } on FirebaseAuthException catch (e) {
//         showError(e);
//       }
//     }
//   }

//   void signupUser() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _signupEmailController.text.trim(),
//           password: _signupPasswordController.text.trim(),
//         );
//       } on FirebaseAuthException catch (e) {
//         showError(e);
//       }
//     }
//   }

//   void showError(FirebaseAuthException e) {
//     String message;
//     switch (e.code) {
//       case 'user-not-found':
//         message = 'No user found for that email.';
//         break;
//       case 'wrong-password':
//         message = 'Wrong password. Try again.';
//         break;
//       case 'email-already-in-use':
//         message = 'This email is already registered.';
//         break;
//       case 'weak-password':
//         message = 'Password should be at least 6 characters.';
//         break;
//       default:
//         message = 'Authentication failed. Please try again.';
//     }
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Form(
//                     key: _formKey,
//                     child: isLogin ? buildLoginForm() : buildSignupForm(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       height: 250,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 30),
//             child: Image.asset(
//               'assets/icons/broth_logo.png',
//               width: 100,
//               height: 100,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildTab('Login', true),
//               const SizedBox(width: 60),
//               _buildTab('Sign-up', false),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTab(String title, bool isLoginTab) {
//     return GestureDetector(
//       onTap: () => setState(() => isLogin = isLoginTab),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           if (isLogin == isLoginTab)
//             Container(
//               margin: const EdgeInsets.only(top: 5),
//               height: 2,
//               width: 80,
//               color: AppColors.primary,
//             ),
//         ],
//       ),
//     );
//   }
