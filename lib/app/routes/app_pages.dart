import 'package:get/get.dart';
import 'package:tebak_gambar_nusantara/app/modules/home/views/exercise_page.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/menu_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => MenuPage(),
      binding: HomeBinding(),
    ),
  ];
}
