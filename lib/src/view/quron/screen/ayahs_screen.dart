import 'package:quran_app_cloud/src/data/library/library.dart';

class AyahsScreen extends StatefulWidget {
  final int surahId;
  final String surahName;
  const AyahsScreen({super.key, required this.surahId, required this.surahName});


  @override
  State<AyahsScreen> createState() => _AyahsScreenState();
}

class _AyahsScreenState extends State<AyahsScreen> {

  @override
  void initState() {
    ApiService().fetchAyahsRaw(widget.surahId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBarWidget(title: 't!.quranFull'),
      child: Center(
        child: Text('data'),
      ),
    );
  }
}
