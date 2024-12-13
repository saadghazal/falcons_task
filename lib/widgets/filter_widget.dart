
import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.label,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? []
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
