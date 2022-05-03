import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:viz_it_app/pages/home_page.dart';
import 'package:viz_it_app/providers/image_search_provider.dart';
import 'package:viz_it_app/theme/theme_manager.dart';

class VizIt extends StatelessWidget {
  // This widget is the root of your application.

  loadLogo(context) async {
    // Image winawayLogo = Image.asset("assets/winawaylogo.png").image;
    await precacheImage(Image.asset("assets/logo.png").image, context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    loadLogo(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: ChangeNotifierProvider(
          create: (_) => ThemeManager(),
          builder: (context, _) {
            return Consumer<ThemeManager>(builder: (context, themeManager, _) {
              return MaterialApp(
                title: 'Viz-iT',
                debugShowCheckedModeBanner: false,
                theme: themeManager.themeData, //Consumes the theme
                // home: LoginProvider(child: PageLogin()),
                // home: MainPage(),
                home: ImageSearchProvider(child: HomePage()),
              );
            });
          }),
    );
  }
}
