import 'package:flutter/material.dart';
import 'package:login_signup_node_js/controller/ApiServices.dart';
import 'package:login_signup_node_js/views/home_page.dart';
import 'package:login_signup_node_js/views/reg_page.dart';
import 'package:login_signup_node_js/widget/button.dart';

import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

  TextEditingController lemail = TextEditingController();
  TextEditingController lpass = TextEditingController();

  @override
  void dispose() {
    lemail.dispose();
    lpass.dispose();
    super.dispose();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset('assets/Secure_login2.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.44,
                right: MediaQuery.of(context).size.width * 0.38,
                top: MediaQuery.of(context).size.height * 0.1),
            child: const Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: TextField(
                        controller: lemail,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          // isDense: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color.fromARGB(255, 245, 223, 249),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: TextField(
                        controller: lpass,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          fillColor: const Color.fromARGB(255, 245, 223, 249),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                                color: const Color.fromARGB(255, 111, 53, 165),
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Button(
                        text: 'LOGIN',
                        screen: () async {
                          Apiservices.LoginUser(
                                  email: lemail.text, pass: lpass.text)
                              .then((value) {
                            if (value) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                            }
                          });
                        }),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegScreen()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 111, 53, 165),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                          },
                          child: const Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 111, 53, 165),
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
        ],
      ),
    );
  }
}
