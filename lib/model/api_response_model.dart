class ApiResponse {
  final bool? status;
  final String? message;
  final dynamic response;

  ApiResponse({
    this.status,
    this.message,
    this.response,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'response': response,
    };
  }
}
