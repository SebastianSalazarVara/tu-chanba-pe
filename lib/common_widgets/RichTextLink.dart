// lib/common_widgets/rich_text_link.dart

import 'package:flutter/material.dart';

class RichTextLink extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onLinkTap;

  const RichTextLink({
    Key? key,
    required this.normalText,
    required this.linkText,
    required this.onLinkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(normalText),
        GestureDetector(
          onTap: onLinkTap,
          child: Text(
            linkText,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
