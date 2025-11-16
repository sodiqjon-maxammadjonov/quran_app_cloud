
import '../../data/library/library.dart';

class Quron extends StatefulWidget {
  const Quron({super.key});

  @override
  State<Quron> createState() => _QuronState();
}

class _QuronState extends State<Quron> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SurahBloc>().add(const LoadAllSurahs());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final t = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(title: t!.quranFull),
      child: SafeArea(
        child: BlocBuilder<SurahBloc, SurahState>(
          builder: (context, state) {
            if (state is SurahLoading) {
              return Center(
                child: CupertinoActivityIndicator(radius: w * 0.04),
              );
            }

            if (state is SurahError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_triangle,
                      size: w * 0.16,
                      color: CupertinoColors.systemRed,
                    ),
                    SizedBox(height: w * 0.04),
                    MyText(
                      state.message,
                      style: GoogleFonts.inter(fontSize: w * 0.0375),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: w * 0.04),
                    CupertinoButton(
                      onPressed: () {
                        context.read<SurahBloc>().add(const LoadAllSurahs());
                      },
                      child: MyText(
                        'Retry',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: w * 0.04),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is SurahsLoaded || state is SurahEmpty) {
              final surahs = state is SurahsLoaded ? state.surahs : <SurahModel>[];

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: w * 0.04)),
                  SliverToBoxAdapter(
                    child: CustomTextField(
                      controller: _searchController,
                      onChanged: (query) {
                        context.read<SurahBloc>().add(SearchSurahs(query));
                      },
                      hint: t.searchSurah,
                      trailingIcon: CupertinoIcons.line_horizontal_3_decrease,
                      onTrailingTap: () {
                        BottomSheetPicker.show(
                          context: context,
                          title: t.filtering,
                          options: [
                            PickerOption(
                              label: t.makkan,
                              emoji: "🕋",
                              onTap: () {
                                context.read<SurahBloc>().add(const FilterSurahs(
                                  revelationPlace: "makkah",
                                ));
                              },
                            ),
                            PickerOption(
                              label: t.medinan,
                              emoji: "🕌",
                              onTap: () {
                                context.read<SurahBloc>().add(const FilterSurahs(
                                  revelationPlace: "madinah",
                                ));
                              },
                            ),
                            PickerOption(
                              label: t.noFilters,
                              emoji: "📚",
                              onTap: () {
                                context.read<SurahBloc>().add(const LoadAllSurahs());
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: w * 0.02)),

                  if (surahs.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: MyText(
                          t.noResults,
                          style: GoogleFonts.inter(fontSize: w * 0.0375),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: w * 0.015),
                            child: SurahItemCard(
                              surah: surahs[index],
                              onTap: () => _navigateToDetail(context, surahs[index]),
                            ),
                          );
                        },
                        childCount: surahs.length,
                      ),
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: w * 0.04)),
                ],
              );
            }


            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, SurahModel surah) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => AyahsScreen(
              surahId: surah.id,
              surahName: surah.nameSimple,
            )
        )
    );
  }
}
