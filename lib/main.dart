import 'package:devstream_app/pages/gallery/gallery_page.dart';
import 'package:devstream_app/pages/gallery/gallery_view_model.dart';
import 'package:devstream_app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GalleryViewModel>(create: (_) => GalleryViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashPage(),
          '/galery': (context) => GalleryPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
