import 'package:get/get.dart';

class HomeController extends GetxController {
  final isSearch = true.obs;

  void changeStatus(bool issearch) {
    isSearch(issearch);
    update();
  }
}
