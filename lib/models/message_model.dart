class MessageModel {
  final String name;
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.name,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      name: json['name'],
      message: json['message'],
      timestamp: json['timestamp'].toDate(),
    );
  }
}
