import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';
import '../constant/small_text.dart';

class LoadingIndicatorWithWords extends StatelessWidget {
  const LoadingIndicatorWithWords({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children:[LinearProgressIndicator(
          color: AppColor.maincolor,
        ),
          SmallText(txt: 'Processing please wait'),
        ]);;
  }
}


class LoadingIndicatorOnly1 extends StatelessWidget {
  const LoadingIndicatorOnly1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children:[LinearProgressIndicator(
          minHeight: 3,
          color: AppColor.maincolor,

        ),

        ]);;
  }
}


/// Flutter code sample for [LinearProgressIndicator].




class LoadingIndicatorOnly extends StatefulWidget {
  const LoadingIndicatorOnly({super.key});

  @override
  State<LoadingIndicatorOnly> createState() =>
      _LoadingIndicatorOnlyState();
}

class _LoadingIndicatorOnlyState extends State<LoadingIndicatorOnly>
    with TickerProviderStateMixin {
  late AnimationController controller;


  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'Processing please wait',
              style: TextStyle(fontSize: 20,color: AppColor.maincolor),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              color: AppColor.activeColor,
              value: controller.value,
              semanticsLabel: 'Progress bar',
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}

class SmallLoadingIcon extends StatelessWidget {
  const SmallLoadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[


    LinearProgressIndicator(
    color: AppColor.maincolor,
    semanticsLabel: 'Progress bar',
    ),
    const SizedBox(height: 7),

    ],
    );
  }
}


