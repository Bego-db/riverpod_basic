import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool? isLoad;
  final Widget child;
  const LoadingWidget({super.key, this.isLoad, required this.child});

  @override
  Widget build(BuildContext context) {
    if (isLoad == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (isLoad == false) {
      return Center(child: Text("Sorun Oluştu"),);
    }
    else {
      return child;
    }
  }
}
