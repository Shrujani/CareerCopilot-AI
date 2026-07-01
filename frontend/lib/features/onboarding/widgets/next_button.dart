import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLastPage;

  const NextButton({
    super.key,
    required this.onPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: isLastPage ? 'Get Started' : 'Next',
      onPressed: onPressed,
    );
  }
}
