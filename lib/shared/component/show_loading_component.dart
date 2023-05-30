import 'package:flutter/material.dart';

ShowLoading(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 8,
            ),
            Text(text),
          ],
        ),
      ),
    ),
  );
}

HideLoading(BuildContext context) {
  Navigator.pop(context);
}

ShowMessage(
    BuildContext context, String message, VoidCallback posAction, String posBtn,
    {VoidCallback? negAction, String? negBtn}) {
  List<Widget> Actions = [
    TextButton(onPressed: posAction, child: Text(posBtn)),
  ];
  if (negBtn != null) {
    Actions.add(
      TextButton(onPressed: negAction, child: Text(negBtn)),
    );
  }
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(message), actions: Actions);
      });
}
