import '/src/data/library/library.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: t!.greeting,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.getCardGradient(true),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 150,
                  width: w - 40,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
