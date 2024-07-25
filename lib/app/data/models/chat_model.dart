class ChatModel {
  String? chatId;
  String? userId;
  String? feeling;
  int? percentage;
  String? reason;
  DateTime? createdAt;

  ChatModel({
    this.chatId,
    this.userId,
    this.feeling,
    this.percentage,
    this.reason,
    this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatId: json["chat_id"],
        userId: json["user_id"],
        feeling: json["feeling"],
        percentage: json["percentage"],
        reason: json["reason"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "user_id": userId,
        "feeling": feeling,
        "percentage": percentage,
        "reason": reason,
        "created_at": createdAt?.toIso8601String(),
      };
}
