import '../../data/library/library.dart';

class Quron extends StatelessWidget {
  const Quron({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: t!.quranFull,
      ),
      child: Center(
        child: MyText("Settings"),
      ),
    );
  }
}
