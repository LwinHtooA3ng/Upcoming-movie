import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upcoming_movie/components/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isVisible = true;

  final _formKey = GlobalKey<FormState>();

  bool _submitted = false;

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        alignment: Alignment.center,
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
                      Text(
                        "Register",
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
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email can\'t be empty';
                            // } else if (text.length < 3) {
                            //   return 'Username too short';
                          } else {
                            return null;
                          }
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.blueAccent,
                        style: const TextStyle(color: Colors.white),
                        obscureText: isVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password can't be empty";
                          } else if (value.length < 6) {
                            return "Password need 6 character";
                          } else {
                            return null;
                          }
                        },
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
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            "Already have an account? Log In",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent[400]),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();

                                setState(() => _submitted = true);

                                final registerValid =
                                    _formKey.currentState!.validate();

                                if (registerValid) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    final _auth = FirebaseAuth.instance;

                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text);
                                    // print(newUser);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(context,"Register successful !",3,Colors.green);

                                    Navigator.pushReplacementNamed(context, '/login');
                                    emailController.clear();
                                    passwordController.clear();
                                    setState(() => _submitted = false);
                                  } on FirebaseAuthException catch (e) {
                                    // print(e);
                                    // print(e.code);

                                    String errorMessage = "";
                                    String code = e.code;

                                    if (code == "invalid-email") {
                                      errorMessage = "Invalid email.";
                                    } else if (code == "email-already-in-use") {
                                      errorMessage =
                                          "Email was already in use.";
                                    } else if (code == "too-many-requests") {
                                      errorMessage =
                                          "Too many request try again later.";
                                    } else if (code ==
                                        "network-request-failed") {
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

                                  // Navigator.pushReplacementNamed(
                                  //     context, '/login');
                                  // emailController.clear();
                                  // passwordController.clear();
                                  // setState(() => _submitted = false);
                                }
                              },
                              child: (isLoading)
                                  ? const SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text("Register"))),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
