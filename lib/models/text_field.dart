import 'package:flutter/material.dart';

TextField kTextField(
    String label, TextEditingController controller, TextInputType type) {
  return TextField(
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFF212121),
          width: 3,
        ),
      ),
    ),
  );
}
