import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isVisible = true;

  bool _submitted = false;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/movie_bg.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: DefaultTextStyle(
              style: TextStyle(color: Colors.grey[100]),
              child: Form(
                key: _formKey,
                autovalidateMode: _submitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.blueAccent[400]),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.blueAccent,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "email required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            "email",
                            style: TextStyle(fontSize: 13),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelStyle: TextStyle(color: Colors.grey[100]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.blueAccent,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password required";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "password",
                            style: TextStyle(fontSize: 13),
                          ),
                          labelStyle: TextStyle(color: Colors.grey[100]),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: (isVisible)
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                          child: const Text(
                            "Don't have an account? Register Here",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      SizedBox(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent[400]),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              setState(() => _submitted = true);

                              final loginValidate =
                                  _formKey.currentState!.validate();

                              if (loginValidate) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  final _auth = FirebaseAuth.instance;

                                  UserCredential currentUser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text);
                                  setState(() => _submitted = false);
                                  // print(currentUser);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showSnackbar(context, "Login successful !", 3,Colors.green);
                                  Navigator.pushNamedAndRemoveUntil(context, "/movies", (route) => false);
                                  emailController.clear();
                                  passwordController.clear();
                                } on FirebaseAuthException catch (e) {
                                  // print(e);
                                  // print(e.code);

                                  String errorMessage = "";
                                  String code = e.code;

                                  if (code == "invalid-email") {
                                    errorMessage = "Invalid email.";
                                  } else if (code == "user-not-found") {
                                    errorMessage = "User not found.";
                                  } else if (code == "wrong-password") {
                                    errorMessage = "Invalid password.";
                                  } else if (code == "too-many-requests") {
                                    errorMessage =
                                        "Too many request try again later";
                                  } else if (code == "network-request-failed") {
                                    errorMessage =
                                        "Your are currently offline.";
                                  } else {
                                    errorMessage =
                                        "Something went wrong please try again.";
                                  }

                                  showSnackbar(
                                      context, errorMessage, 1, Colors.red);

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: (isLoading)
                                ? const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ))
                                : const Text("Login")),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
