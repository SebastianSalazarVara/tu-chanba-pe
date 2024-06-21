import 'package:flutter/material.dart';

class AvailabilityOption extends StatefulWidget {
  final String availableText;
  final String unavailableText;
  final bool initialAvailability;

  const AvailabilityOption({
    Key? key,
    required this.availableText,
    required this.unavailableText,
    this.initialAvailability = true,
  }) : super(key: key);

  @override
  _AvailabilityOptionState createState() => _AvailabilityOptionState();
}

class _AvailabilityOptionState extends State<AvailabilityOption> {
  late bool _isAvailable;

  @override
  void initState() {
    super.initState();
    _isAvailable = widget.initialAvailability;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAvailable ? widget.availableText : widget.unavailableText,
                  style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
                ),
                Text(
                  _isAvailable ? 'Estás en línea' : 'No estás en línea',
                  style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: _isAvailable,
            onChanged: (value) {
              setState(() {
                _isAvailable = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
