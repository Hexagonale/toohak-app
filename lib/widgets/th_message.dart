import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThMessage {
  ThMessage._();

  static void showError(String message) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 56.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        message,
                        style: ThTextStyles.paragraphP2Regular.copyWith(
                          color: ThColors.highlightColorLightGreyGreenShade,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSuccess(String message) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 56.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        message,
                        style: ThTextStyles.headlineH1Regular.copyWith(
                          color: const Color(0xff8EE111),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xff8EE111),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showInfo(String message) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 56.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        message,
                        style: ThTextStyles.headlineH1Regular.copyWith(
                          color: ThColors.statusColorWarning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.info,
                      color: Color(0xff39c0ed),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
