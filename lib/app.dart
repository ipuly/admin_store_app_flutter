import 'package:app_admin_toko/core/models/quantity_model.dart';
import 'package:app_admin_toko/routes/route_manager.dart';
import 'package:app_admin_toko/core/view_models/product_view_model.dart';
import 'package:app_admin_toko/core/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductViewModel(),
        ),
        // ChangeNotifierProvider(
        //   create: (BuildContext context) => CRUDModel(),
        // ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Quantity(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.onGeneratedRoute,
        initialRoute: RouteManager.loadingPage,
        title: 'Toko ABC',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
