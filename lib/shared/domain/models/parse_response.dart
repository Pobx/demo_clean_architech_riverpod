class ParseResponse<T> {
  final bool success;
  final String? status;
  final String? message;
  final T? data;

  ParseResponse({this.success = false, this.status, this.message, this.data});

  factory ParseResponse.fromMap(dynamic json,
      {required T Function(dynamic) modifier}) {
    return ParseResponse<T>(
        success: json['status'] == 'success',
        status: json['status'],
        message: json['message'],
        data: modifier(json));
  }
}
