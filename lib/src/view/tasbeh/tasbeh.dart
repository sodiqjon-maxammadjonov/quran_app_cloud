import '../../data/library/library.dart';

class Tasbeh extends StatelessWidget {
  const Tasbeh({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: t!.tasbeh,
      ),
      child: Center(
        child: MyText("Tasbeh"),
      ),
    );
  }
}
