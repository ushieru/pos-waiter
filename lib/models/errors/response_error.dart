class ErrorResponse {
  ErrorResponse(
      {required this.error, required this.description, required this.details});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json['error'],
      description: json['description'],
      details: json['details'],
    );
  }

  final String error;
  final String description;
  final String details;

  Map<String, String> toJson() {
    return {
      'error': error,
      'description': description,
      'details': details,
    };
  }
}
