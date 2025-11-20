import 'src/data/library/library.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initServices() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(SurahModelAdapter());
  Hive.registerAdapter(TranslatedNameAdapter());
  // Hive.registerAdapter(AyahModelAdapter());


  await Hive.openBox<SurahModel>('surahs');
  // await Hive.openBox<AyahModel>('ayahs');

  await SurahDb().init();
  // await AyahDb().init();
}



void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await initServices();

    runApp(const MyApp());
  }, (error, stack) {
    print('Caught Dart error: $error');
  });
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _settingsBloc = SettingsBloc();
    Future.microtask(() {
      _settingsBloc.add(LoadSettings(themeMode: ThemeMode.system));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _settingsBloc.close();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    print('🔔 Platform brightness changed');
    _settingsBloc.add(SystemBrightnessChanged());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _settingsBloc),
        ...Providers.providers,
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) {
          return current is SettingsThemeState;
        },
        builder: (context, state) {
          CupertinoThemeData theme = AppTheme.currentTheme;

          if (state is SettingsThemeState) {
            theme = state.theme;
            print('🎨 Theme updated: ${state.themeMode}');
          }

          return CupertinoApp.router(
            title: ConstValues.appName,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: theme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}