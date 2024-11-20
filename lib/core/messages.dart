import 'package:flutter/material.dart';
import 'package:test_konsi/global/widgets/rounded_button.dart';

void scaffoldMensegerError(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red[400], content: Text(message)));
}

void scaffoldMensegerSuccess(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green[400], content: Text(message)));
}

void dialogConfirmAction(
    String message, Function action, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(title: "Continuar", action: action),
                RoundedButton(
                    title: "Cancelar",
                    action: () {
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        );
      });
}
