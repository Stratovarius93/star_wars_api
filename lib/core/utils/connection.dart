import 'package:connectivity_plus/connectivity_plus.dart';

class HasConnection {
  HasConnection();
  Future<bool> call() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult[0] == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
