import 'package:quran_app_cloud/src/data/library/library.dart';

class Providers {
  static final List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => NavBarBloc()),
    BlocProvider(create: (context) => SettingsBloc()),
  ];
}
