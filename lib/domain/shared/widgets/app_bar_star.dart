import 'package:flutter/material.dart';

class AppBarStar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarStar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    );
  }
}
