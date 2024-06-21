  import 'package:flutter/material.dart';

  class TopBar extends StatelessWidget implements PreferredSizeWidget {
    final String title;
    final bool showBackButton;
    final VoidCallback? onAddPressed;

    const TopBar({
      Key? key,
      required this.title,
      this.showBackButton = false,
      this.onAddPressed,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Mont-Bold',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF3F60A0),
        leading: showBackButton
            ? IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        )
            : null,
        actions: [
          if (onAddPressed != null)
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: onAddPressed,
            ),
        ],
      );
    }

    @override
    Size get preferredSize => Size.fromHeight(kToolbarHeight);
  }
