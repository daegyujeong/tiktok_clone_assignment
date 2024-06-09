import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/authentication/password_screen.dart';
import 'package:tiktok_clone_assignment/features/authentication/widgets/code_input.dart';
import 'package:tiktok_clone_assignment/features/authentication/widgets/form_button.dart';

const int digitCounts = 6;
final List<GlobalKey<CodeInputState>> _codeInputKeys =
    List<GlobalKey<CodeInputState>>.generate(
  digitCounts,
  (index) => GlobalKey<CodeInputState>(),
);

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _areAllFilled = false;
  bool _illegalAccess = false;
  bool _isLoading = false;
  final List<FocusNode> _focusNodes =
      List<FocusNode>.generate(digitCounts, (index) => FocusNode());

  void _onTapInput() {
    _areAllFieldsFilled();
    setState(() {
      print("Changed");
    });
  }

  bool _areAllFieldsFilled() {
    for (var key in _codeInputKeys) {
      if (key.currentState?.isEmpty() ?? true) {
        print("false");
        _areAllFilled = false;
        setState(() {});
        return false;
      }
    }
    print("true");
    _illegalAccess = false;
    _areAllFilled = true;
    return true;
  }

  void _onNextTap(BuildContext context) {
    if (!_areAllFieldsFilled()) {
      setState(() {
        _illegalAccess = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a delay to show the loading animation
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PasswordScreen(),
        ),
      );
    });
  }

  void _onFieldChanged(String value, int index) {
    if (value.isNotEmpty && index < digitCounts - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    _areAllFieldsFilled();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      // onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.blue,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v40,
                      const Text(
                        "We sent you a code",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Gaps.v14,
                      const Text(
                        "Enter it below to verify",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.black54,
                        ),
                      ),
                      const Text(
                        "xxx@xxx.com",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.black54,
                        ),
                      ),
                      Gaps.v16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List<Widget>.generate(
                          digitCounts,
                          (index) => CodeInput(
                            key: _codeInputKeys[index],
                            focusNode: _focusNodes[index],
                            onChanged: (value) => _onFieldChanged(value, index),
                            onTap: _onTapInput,
                          ),
                        ),
                      ),
                      Gaps.v10,
                      Row(
                        children: _illegalAccess
                            ? [
                                const FaIcon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: Sizes.size20,
                                  color: Colors.red,
                                ),
                                Gaps.h10,
                                const Text(
                                  "Fill 6 Digit",
                                  style: TextStyle(color: Colors.red),
                                )
                              ]
                            : [],
                      ),
                      Gaps.v10,
                      Visibility(
                        visible: _areAllFilled,
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.circleCheck,
                            size: Sizes.size40,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Spacer(), // This will push the content to the top and leave the space for bottom content
                      Visibility(
                        visible: !_isLoading,
                        child: GestureDetector(
                          // onTap: () => _onSignUpTap(context),
                          child: Text(
                            "Didn't receive email?",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v20,
                      GestureDetector(
                        onTap: () => _onNextTap(context),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : FormButton(disabled: !_areAllFilled),
                      ),
                      Gaps.v72, // Add extra padding to ensure the button is above the keyboard
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
