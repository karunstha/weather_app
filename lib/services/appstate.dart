import 'package:weatherapp/main.dart';
import 'package:weatherapp/network/dioclient.dart';

class AppState {
  late DioClient dioClient;

  AppState() {
    init();
  }

  void init() {
    dioClient = DioClient();
  }

  static AppState getState() => serviceLocator.get<AppState>();
}
