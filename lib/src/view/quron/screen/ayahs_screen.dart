import 'package:flutter/material.dart';
import '../../../data/library/library.dart';

class AyahsScreen extends StatefulWidget {
  final int surahId;
  final String surahName;

  const AyahsScreen({
    required this.surahId,
    required this.surahName,
  });

  @override
  State<AyahsScreen> createState() => _AyahsScreenState();
}

class _AyahsScreenState extends State<AyahsScreen> {
  String selectedLanguage = 'uz'; // Default til

  @override
  void initState() {
    super.initState();
    // Surani ochmada oyatlarni yuklash
    context.read<AyahBloc>().add(LoadAyahsBySurah(widget.surahId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.surahName} (${widget.surahId})'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Til tanlash
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: ['uz', 'ru', 'en'].map((lang) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => selectedLanguage = lang);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLanguage == lang
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                      child: Text(
                        lang.toUpperCase(),
                        style: TextStyle(
                          color:
                          selectedLanguage == lang ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Oyatlar ro'yxati
          Expanded(
            child: BlocBuilder<AyahBloc, AyahState>(
              builder: (context, state) {
                if (state is AyahLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is AyahsLoaded) {
                  final ayahs = state.ayahs;
                  return ListView.builder(
                    itemCount: ayahs.length,
                    itemBuilder: (context, index) {
                      final ayah = ayahs[index];
                      final translation = ayah.getTranslation(selectedLanguage);

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Oyat raqami va metadata
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Oyat ${ayah.ayahNumber}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Chip(
                                    label: Text('Juz ${ayah.juzNumber}'),
                                    avatar: Icon(Icons.bookmark, size: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Arab matn
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.amber[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  ayah.textArabic,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arabic',
                                    height: 2,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Tarjima
                              if (translation != null)
                                Text(
                                  translation,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                                )
                              else
                                Text(
                                  'Tarjima mavjud emas',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              SizedBox(height: 12),
                              // Audio tugmasi
                              if (ayah.audioUrl != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Audio ijro qilish
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Audio: ${ayah.audioUrl}'),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.play_circle),
                                    label: Text('Tinglash'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state is AyahEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 48, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(state.message),
                      ],
                    ),
                  );
                }

                if (state is AyahError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 48, color: Colors.red),
                        SizedBox(height: 12),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AyahBloc>()
                                .add(LoadAyahsBySurah(widget.surahId));
                          },
                          child: Text('Qayta yuklash'),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============== MAIN DA ISHLATISH ==============
// 1. BlocProvider qo'shish:
/*
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SurahBloc()),
        BlocProvider(create: (_) => AyahBloc()),
      ],
      child: MyApp(),
    ),
  );
}
*/

// 2. Surah ro'yxatidan chapga bosish:
/*
onTap: (surah) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AyahsScreen(
        surahId: surah.id,
        surahName: surah.nameSimple,
      ),
    ),
  );
}
*/