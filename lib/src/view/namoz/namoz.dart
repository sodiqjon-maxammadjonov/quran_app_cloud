import 'package:quran_app_cloud/src/data/library/library.dart';

class Namoz extends StatelessWidget {
  const Namoz({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: t!.namozTimes,
      ),
      child: Center(
        child: MyText('Namoz'),
      ),
    );
  }
}
