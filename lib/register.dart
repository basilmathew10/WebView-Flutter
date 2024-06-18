import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
 // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
    // Navigate to login screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create New Account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        isDense: true,
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter your Email Id';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                          return 'Please Enter a valid Email Id';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        isDense: true,
                      ),
                      obscureText: true,
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter your Password';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform registration logic with the entered data
                        _registerUser();
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
