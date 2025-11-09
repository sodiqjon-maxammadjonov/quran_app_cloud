import '/src/data/library/library.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText(
      this.text, {
        super.key,
        this.style,
        this.color,
        this.textAlign,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final defaultStyle = theme.textTheme.textStyle;

    return Text(
      text,
      style: (style ?? defaultStyle).copyWith(
        color: color ?? theme.textTheme.textStyle.color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
