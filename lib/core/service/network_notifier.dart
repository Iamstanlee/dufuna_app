import 'package:connectivity/connectivity.dart';

class NetworkNotifier {
  final Connectivity _connectivity;
  NetworkNotifier(Connectivity connectivity) : _connectivity = connectivity;

  Future<bool> hasNetwork() async {
    try {
      final netInfo = await _connectivity.checkConnectivity();
      return !(netInfo == ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }
}
