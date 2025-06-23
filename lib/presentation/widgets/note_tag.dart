import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    required this.label, 
    this.onClosed, 
    this.onTap,
    super.key});

  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: gray100,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        margin: EdgeInsets.only(right: 4),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: onClosed != null ? 14 : 12,
                color: gray700,
              ),
            ),
      
            if (onClosed != null) ...[
              SizedBox(width: 4),
              GestureDetector(
                onTap: onClosed,
                child: Icon(Icons.close, size: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
