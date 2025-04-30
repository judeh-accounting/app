import 'package:get/get.dart';

mixin HasLoaderMixin on GetxController{
  bool loading = false;

  void startLoading() {
    loading = true;
    update();
  }

  void stopLoading() {
    loading = false;
    update();
  }
}