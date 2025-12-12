import 'package:flutter/material.dart';

class AgmScaffold extends StatelessWidget {
  const AgmScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.onTap,
    this.scaffoldKey,
    this.floatingActionButton,
    super.key,
  });

  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;
  final Widget? drawer;
  final VoidCallback? onTap;
  final Widget? floatingActionButton;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? FocusScope.of(context).unfocus,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor ?? Colors.grey.shade100,
        appBar: appBar,
        endDrawer: drawer,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
