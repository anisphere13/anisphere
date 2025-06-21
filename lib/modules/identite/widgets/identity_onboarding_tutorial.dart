import 'package:flutter/material.dart';

/// Simple onboarding tutorial for the identity module.
class IdentityOnboardingTutorial extends StatefulWidget {
  final VoidCallback onFinish;
  const IdentityOnboardingTutorial({super.key, required this.onFinish});

  @override
  State<IdentityOnboardingTutorial> createState() => _IdentityOnboardingTutorialState();
}

class _IdentityOnboardingTutorialState extends State<IdentityOnboardingTutorial> {
  int _index = 0;
  final List<String> _steps = const [
    'Add a clear photo',
    'Fill microchip and status',
    'Review and confirm',
  ];

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _steps.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _steps[_index],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (isLast) {
                    widget.onFinish();
                  } else {
                    setState(() => _index++);
                  }
                },
                child: Text(isLast ? 'Done' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
