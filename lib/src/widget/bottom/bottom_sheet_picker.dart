import 'package:quran_app_cloud/src/data/library/library.dart';

class PickerOption {
  final String label;
  final String emoji;
  final VoidCallback onTap;

  const PickerOption({
    required this.label,
    required this.emoji,
    required this.onTap,
  });
}

class BottomSheetPicker {
  static void show({
    required BuildContext context,
    required String title,
    required List<PickerOption> options,
    String cancelText = 'Bekor qilish',
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: MyText(
          title,
          style: TextStyle(
            fontSize: 13,
            color: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .color
                ?.withOpacity(0.6),
          ),
        ),
        actions: options.map((option) {
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              option.onTap();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText('${option.emoji}  ${option.label}'),
              ],
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDestructiveAction: true,
          child: MyText(cancelText),
        ),
      ),
    );
  }
}