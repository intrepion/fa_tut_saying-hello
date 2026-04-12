class GreetingResponse {
  final String message;

  const GreetingResponse({required this.message});

  factory GreetingResponse.fromJson(Map<String, dynamic> json) {
    return GreetingResponse(message: json['message'] as String);
  }
}
