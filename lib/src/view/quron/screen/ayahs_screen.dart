import 'package:quran_app_cloud/src/data/library/library.dart';

class AyahsScreen extends StatefulWidget {
  final int surahId;
  final String surahName;

  const AyahsScreen({
    super.key,
    required this.surahId,
    required this.surahName,
  });

  @override
  State<AyahsScreen> createState() => _AyahsScreenState();
}

class _AyahsScreenState extends State<AyahsScreen> {

  @override
  void initState() {
    super.initState();

    final editions = AyahEditions.getAll();

    context.read<AyahBloc>().add(
      LoadAyahs(widget.surahId, editions),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(
        title: widget.surahName,
      ),

      child: SafeArea(
        child: BlocBuilder<AyahBloc, AyahState>(
          builder: (context, state) {

            // --- LOADING HOLATI ---
            if (state is AyahLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            // --- ERROR HOLATI ---
            if (state is AyahError) {
              return Center(
                child: Text(
                  state.message,
                  style: theme.textTheme.textStyle,
                ),
              );
            }

            // --- SUCCESS HOLATI ---
            if (state is AyahLoadedState) {
              final data = state.ayah;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: data.entries.map((entry) {
                  final edition = entry.key;
                  final ayahs = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edition,
                        style: theme.textTheme.navTitleTextStyle,
                      ),
                      const SizedBox(height: 8),

                      ...ayahs.map((a) => Text(a.numberInSurah.toString())).toList(),

                      const SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
