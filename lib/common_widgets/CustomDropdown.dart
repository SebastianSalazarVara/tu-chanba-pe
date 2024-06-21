// lib/common_widgets/custom_dropdown.dart

import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator, required Text hint,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;
  bool _isValid = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  void _onChanged(String? newValue) {
    setState(() {
      _selectedValue = newValue;
      _errorText = widget.validator?.call(_selectedValue);
      _isValid = _errorText == null;
      widget.onChanged(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            labelText: widget.labelText,
            errorText: null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              isDense: true,
              onChanged: _onChanged,
              items: widget.items,
            ),
          ),
        ),
        if (!_isValid)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorText ?? '',
              style: TextStyle(color: Colors.red.shade700, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}

