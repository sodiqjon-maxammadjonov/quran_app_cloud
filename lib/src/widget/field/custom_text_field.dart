import '/src/data/library/library.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final int maxLines;
  final int maxLength;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.maxLength = 50,
    this.trailingIcon,
    this.onTrailingTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: theme.barBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.barBackgroundColor.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // TextField
              Expanded(
                child: CupertinoTextField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: controller,
                  placeholder: hint,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  onChanged: onChanged,
                  cursorColor: theme.primaryColor,
                  style: theme.textTheme.textStyle.copyWith(
                    fontSize: 16,
                  ),
                  placeholderStyle: theme.textTheme.textStyle.copyWith(
                    fontSize: 16,
                    color: theme.textTheme.textStyle.color?.withValues(alpha: 0.5),
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),

              if (trailingIcon != null && onTrailingTap != null)
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 12),
                  onPressed: onTrailingTap,
                  minimumSize: const Size(0, 0),
                  child: Icon(
                    trailingIcon,
                    color: theme.primaryColor,
                    size: 22,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}