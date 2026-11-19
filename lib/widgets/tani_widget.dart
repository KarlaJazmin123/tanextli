// lib/widgets/tani_widget.dart
import 'package:flutter/material.dart';

class TaniWidget extends StatelessWidget {
  final double size;

  const TaniWidget({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: Colors.green.shade700, width: 2),
      ),
      child: const Icon(Icons.pets, size: 60, color: Colors.green),
    );
  }
}