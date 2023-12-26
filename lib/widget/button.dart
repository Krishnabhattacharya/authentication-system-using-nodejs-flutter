import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback screen;
  const Button({super.key, required this.text, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: Color.fromARGB(255, 111, 53, 165)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(
                  255, 111, 53, 165)), // Set the background color to purple
        ),
        onPressed: () {
          screen();
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
