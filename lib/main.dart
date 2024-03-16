import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mr_hotel/pages/default_tab_bar_page.dart';
import 'package:mr_hotel/pages/sign_in_page.dart';
import 'package:mr_hotel/providers/auth_provider.dart';
import 'package:mr_hotel/providers/kamar_provider.dart';
import 'package:mr_hotel/providers/transaksi_provider.dart';
import 'package:mr_hotel/providers/user_provider.dart';
import 'package:provider/provider.dart';

AndroidOptions _getAndroidOptions() {
  return const AndroidOptions(
    encryptedSharedPreferences: true,
  );
}

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
String token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  token = await storage.read(
        key: "token",
        aOptions: _getAndroidOptions(),
      ) ??
      "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => KamarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransaksiProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mr. Hotel',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          home: token != "" ? const DefaultTabBarPage() : const SignInPage(),
        );
      }),
    );
  }
}
