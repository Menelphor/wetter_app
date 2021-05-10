import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformDialog {
  static void showPlatformDialog({
    required BuildContext context,
    required Widget dialogWidget,
    bool barrierDismissible = false,
    Color? backgroundColor,
    double? elevation,
    Duration insetAnimationDuration = const Duration(milliseconds: 100),
    Curve insetAnimationCurve = Curves.decelerate,
    ShapeBorder? shape,
    VoidCallback? onDismiss,
    bool useRootNavigator = false,
    String? routeName,
  }) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        routeSettings: RouteSettings(name: routeName),
        builder: (context) => Dialog(
          child: dialogWidget,
          backgroundColor: backgroundColor,
          elevation: elevation,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
          shape: shape,
        ),
      ).then((_) {
        if (onDismiss != null) {
          onDismiss();
        }
      });
    } else {
      showCupertinoDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        routeSettings: RouteSettings(name: routeName),
        builder: (context) => Dialog(
          child: dialogWidget,
          backgroundColor: backgroundColor,
          elevation: elevation,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
          shape: shape,
        ),
      ).then((_) {
        if (onDismiss != null) {
          onDismiss();
        }
      });
    }
  }

  static Future<void> showPlatformAlertDialog({
    required BuildContext context,
    required Widget content,
    required List<Widget> actions,
    String? title,
    Widget? titleWidget,
    Function? onDismiss,
    bool barrierDismissible = false,
  }) async {
    assert(title != null || titleWidget != null);
    if (Platform.isAndroid) {
      await showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: titleWidget ??
              Text(
                title ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
          content: content,
          actions: actions,
        ),
      ).then((_) {
        if (onDismiss != null) {
          onDismiss();
        }
      });
    } else {
      await showCupertinoDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) => CupertinoAlertDialog(
          title: titleWidget ??
              Text(
                title ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
          content: content,
          actions: actions,
        ),
      ).then((_) {
        if (onDismiss != null) {
          onDismiss();
        }
      });
    }
  }
}

/// If you want to pass actions to a [PlatformAlertDialog], do so with this
/// widget.
class PlatformAlertButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const PlatformAlertButton({
    required this.buttonText,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Container(
        padding: padding,
        child: TextButton(
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      );
    } else if (Platform.isIOS) {
      return CupertinoButton(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        onPressed: onPressed,
      );
    } else {
      return Container();
    }
  }
}
