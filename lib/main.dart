import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan_us/pages/edit_pendaftaran.dart';
import 'package:latihan_us/pages/formulir_pendaftaran.dart';
import 'package:latihan_us/pages/index.dart';
import 'package:latihan_us/pages/list_pendaftaran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => IndexPage(),
        '/formulir': (_) => Formulir(),
        '/pendaftar': (_) => ListPendaftaran(),
        '/edit': (_) => EditFormulir(),
      },
    );
  }
}
