class ChatModelStatusCreateGroup {
  String name;
  // String icon;
  // bool isGroup;
  // String time;
  // String currentMessage;
  String status;
  bool select;

  ChatModelStatusCreateGroup({
    required this.name,
    // required this.icon,
    // required this.isGroup,
    // required this.time,
    // required this.currentMessage,
    required this.status,
    this.select = false,
  });
}
