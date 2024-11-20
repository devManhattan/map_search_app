import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.title, required this.action});
  final String title;
  final Function action;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
              (Set<WidgetState> states) {
            return const RoundedRectangleBorder();
          }),
          textStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (Set<WidgetState> states) {
              return const TextStyle(color: Colors.white);
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return Theme.of(context).primaryColor;
            },
          ),
        ),
        onPressed: () {
          action();
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
