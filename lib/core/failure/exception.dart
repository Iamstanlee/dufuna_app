class ServerException implements Exception {
  final String? msg;
  ServerException([this.msg = '']);
}
