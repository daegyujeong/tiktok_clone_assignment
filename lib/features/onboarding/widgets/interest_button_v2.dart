import 'package:flutter/material.dart';
import '../../../../constants/sizes.dart';

class InterestButtonV2 extends StatefulWidget {
  const InterestButtonV2({
    super.key,
    required this.interest,
    required this.isSelected,
    required this.onTap,
  });

  final String interest;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<InterestButtonV2> createState() => _InterestButtonV2State();
}

class _InterestButtonV2State extends State<InterestButtonV2> {
  // bool _isSelected = false;

  // void _onTap() {
  //   setState(() {
  //     _isSelected = !_isSelected;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color:
              widget.isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isSelected ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
