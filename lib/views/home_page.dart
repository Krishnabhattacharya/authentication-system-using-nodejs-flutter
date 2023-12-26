import 'package:flutter/material.dart';
import 'package:login_signup_node_js/controller/Sharedservices.dart';
import 'package:login_signup_node_js/views/login_page.dart';
import 'package:login_signup_node_js/widget/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = SharedServices.getLoginDetails();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Home page',
          ),
          backgroundColor: const Color.fromARGB(255, 111, 53, 165),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'welcome',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                data!.user!.name.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              Button(
                  text: 'LOGOUT',
                  screen: () {
                    SharedServices.logout(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  })
            ],
          ),
        ));
  }
}
