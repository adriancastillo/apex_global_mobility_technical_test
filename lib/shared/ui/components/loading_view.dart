import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget loadingScreen(bool isLoading) {
    return Stack(children: [this, if (isLoading) const AgmLoadingScreen()]);
  }
}

class AgmLoadingScreen extends StatefulWidget {
  const AgmLoadingScreen({
    super.key,
    this.child,
    this.backgroundColor,
    this.textColor,
  });
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;
  @override
  State<AgmLoadingScreen> createState() => _AgmLoadingScreenState();
}

class _AgmLoadingScreenState extends State<AgmLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child ?? const SizedBox.shrink(),
        Scaffold(
          backgroundColor: widget.backgroundColor ?? Colors.black12,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  'Cargando...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
