class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  Response(
      {required this.statusCode, this.statusMessage, this.data = const {}});

  @override
  String toString() {
    return 'statusCode:$statusCode \n statusMessage:$statusMessage \n data=$data';
  }
}
