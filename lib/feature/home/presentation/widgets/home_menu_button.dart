import 'package:flutter/material.dart';



class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({
    required this.onTap,
    required this.title,
    required this.color,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
