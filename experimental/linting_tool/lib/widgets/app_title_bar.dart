import 'package:flutter/material.dart';
import 'package:linting_tool/native_window_utils/window_utils.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Optionally wrap the content in a Native title bar. This may be a no-op depending on platform.
    return IoUtils.instance.wrapNativeTitleBarIfRequired(
      IgnorePointer(
        ignoring: true,
        child: SizedBox(
          height: kToolbarHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              children: [
                if (Navigator.canPop(context))
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      label: const Text('Back'),
                    ),
                  ),
                const Spacer(),
                Text(
                  'Flutter Linting Tool',
                  style: textTheme.titleSmall!.copyWith(
                    color: textTheme.bodyLarge!.color,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdaptiveTitleBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static const Key _profileBtnKey = Key('rounded_profile_button');
}
