import 'package:flutter/material.dart';
class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(

        ),
      ),
    );
  }
}
