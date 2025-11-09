import '/src/data/library/library.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.currentTheme;
    final t = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: t!.greeting,
      ),
      child: Center(
        child: MyText(
          t.greeting
        ),
      ),
    );
  }
}
