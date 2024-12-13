import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onSubmitted,
    required this.onChanged,
  });
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: fieldBorder(Colors.grey.withOpacity(0.5), 0.5),
        enabledBorder: fieldBorder(Colors.grey.withOpacity(0.5), 1),
        focusedBorder: fieldBorder(Colors.blue, 2),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.grey),
        isDense: true,
        suffixIcon: Icon(
          Icons.search,
          color: Colors.grey.withOpacity(0.5),
          size: 24,
        ),
      ),
    );
  }

  OutlineInputBorder fieldBorder(Color borderColor, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: borderColor, width: width),
    );
  }
}
