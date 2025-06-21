import 'package:flutter/material.dart';
import '../../../theme.dart';
import 'more_menu.dart';

/// A reusable AniSphère [AppBar] with default styling.
class AniSphereAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const AniSphereAppBar({super.key, this.title, this.actions, this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    return AppBar(
      title: title != null ? Text(title!) : null,
      backgroundColor: appBarTheme.backgroundColor ?? backgroundGray,
      actions: [
        if (actions != null) ...actions!,
        const MoreMenuButton(),
      ],
      bottom: bottom,
    );
  }
}
