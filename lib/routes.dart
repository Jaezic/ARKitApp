import 'package:ar_application_22/pages/main/view/main_view_page.dart';
import 'package:get/get.dart';

class CustomRouter {
  static final routes = [
    GetPage(
      name: MainViewPage.url,
      page: () => const MainViewPage(),
    ),
  ];
}
