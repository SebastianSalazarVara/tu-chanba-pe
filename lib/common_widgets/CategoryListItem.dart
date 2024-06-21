import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String name;
  final String? imagePath;
  final VoidCallback onTap;
  final VoidCallback onMorePressed;

  const CategoryListItem({
    Key? key,
    required this.name,
    this.imagePath,
    required this.onTap,
    required this.onMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (imagePath != null)
              CircleAvatar(
                backgroundImage: AssetImage(imagePath!),
                radius: 30,
              ),
            if (imagePath != null) SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'Mont-Bold',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              onPressed: onMorePressed,
            ),
          ],
        ),
      ),
    );
  }
}