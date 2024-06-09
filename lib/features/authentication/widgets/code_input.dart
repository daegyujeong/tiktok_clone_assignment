import 'package:flutter/material.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({
    super.key,
    this.onTap,
    required this.focusNode,
    required this.onChanged,
  });

  final VoidCallback? onTap;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  State<CodeInput> createState() => CodeInputState();
}

class CodeInputState extends State<CodeInput> {
  final TextEditingController _controller = TextEditingController();
  bool isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      isTextEmpty = _controller.text.isEmpty;
    });
    widget.onChanged(_controller.text);
  }

  bool isEmpty() {
    return _controller.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 40,
          child: TextField(
            onChanged: (value) {
              widget.onTap?.call();
            },
            controller: _controller,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isTextEmpty ? Colors.grey : Colors.blue, width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
