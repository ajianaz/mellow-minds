class MessageModel {
  String? messageId;
  String? chatId;
  String? sender;
  String? message;
  DateTime? createdAt;

  MessageModel({
    this.messageId,
    this.chatId,
    this.sender,
    this.message,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json["message_id"],
        chatId: json["chat_id"],
        sender: json["sender"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "chat_id": chatId,
        "sender": sender,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
      };
}
