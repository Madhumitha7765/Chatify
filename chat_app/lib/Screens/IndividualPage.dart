// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_field, prefer_final_fields, avoid_unnecessary_containers, prefer_is_empty, unused_import, import_of_legacy_library_into_null_safe, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:chat_app/CustomUI/OwnFileCard.dart';
import 'package:chat_app/CustomUI/OwnMessage.dart';
import 'package:chat_app/CustomUI/ReplyCard.dart';
import 'package:chat_app/CustomUI/ReplyFileCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Model/MessageModel.dart';
import 'package:chat_app/Screens/CameraScreen.dart';
import 'package:chat_app/Screens/CameraView.dart';
import 'package:chat_app/constants.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

TextEditingController _controller = TextEditingController();
ImagePicker _picker = ImagePicker();
XFile? file;

class IndividualPage extends StatefulWidget {
  IndividualPage({required this.chatModel, required this.sourceChat});
  final ChatModel sourceChat;
  final ChatModel chatModel;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool isShowSticker = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  int popTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isShowSticker = false;
        });
      } else {}
    });
  }

  void connect() {
    socket = IO.io("http://192.168.228.200:7000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect(
      (data) {
        print("Connected to Socket");
        socket.on(
          "message",
          (msg) {
            print(msg);
            setMessage(
              "destination",
              msg["message"],
              msg["path"],
            );
          },
        );
      },
    );
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
      path: path,
    );
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  void onImageSend(String path, String message) async {
    print("Hey there Working!! $message");
    for (var i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.228.200:7000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data["path"]);
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat.id,
      "targetId": widget.chatModel.id,
      "path": data["path"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Image.asset(
            "assets/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              // Individual Page App Bar
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Go Back To Home Page
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    // DP
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 30,
                        width: 29,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Name
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Last seen
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Gradient Finish in AppBar
              flexibleSpace:
                  Container(decoration: kIndividualGradientDecoration),
              actions: [
                // Video Button
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {},
                ),
                // Call Button
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                ),
                // Pop Up Button
                PopupMenuButton<String>(
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links and docs"),
                        value: "Media, links and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WillPopScope(
                child: Stack(
                  children: [
                    // Scrolling text and chats
                    Container(
                      height: MediaQuery.of(context).size.height - 140,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                      

                          if (index == messages.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            if (messages[index].path.length > 0) {
                              return OwnFileCard(
                                path: messages[index].path,
                                message: messages[index].message,
                                time: messages[index].time,
                              );
                            } else {
                              return OwnMessageCard(
                                message: messages[index].message,
                              );
                            }
                          } else {
                            if (messages[index].path.length > 0) {
                              return ReplyFileCard(
                                message: messages[index].message,
                                path: messages[index].path,
                                time: messages[index].time,
                              );
                            } else {
                              return ReplyCard(
                                message: messages[index].message,
                              );
                            }
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(2, 0, 2, 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  // Typing Message Input
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.emoji_emotions,
                                            color: Colors.blueGrey,
                                          ),
                                          onPressed: () {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              isShowSticker = true;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Attach Files Button
                                            IconButton(
                                              icon: Icon(
                                                Icons.attach_file,
                                                color: Colors.blueGrey,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) {
                                                    return bottomSheet(
                                                        context); //Calling Bottom sheet function
                                                  },
                                                );
                                              },
                                            ),
                                            // Camera Button
                                            IconButton(
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Colors.blueGrey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  popTime = 2;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (builder) {
                                                      return CameraScreen(
                                                        onImageSend:
                                                            onImageSend,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                              // Mic Recording Button / Msg Sending Button
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, right: 2, left: 2),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFff6699),
                                  radius: 25,
                                  child: Container(
                                    decoration: kGradientDecoration,
                                    child: IconButton(
                                      icon: Icon(
                                        sendButton
                                            ? Icons.send_sharp
                                            : Icons.mic,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (sendButton) {
                                          sendMessage(
                                              _controller.text,
                                              widget.sourceChat.id,
                                              widget.chatModel.id,
                                              "");
                                          _controller.clear();
                                        } else {
                                          print("Message not sent");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isShowSticker ? emojiSelect() : Container(),
                        ],
                      ),
                    )
                  ],
                ),
                // Emoji drop and go back to homepage
                onWillPop: () {
                  if (isShowSticker) {
                    setState(() {
                      isShowSticker = false;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  return Future.value(false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //File Attachment Pop Up Function Custom Widget
  Widget bottomSheet([BuildContext? context]) {
    return Container(
      height: 278,
      width: MediaQuery.of(context!).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    icon: Icons.insert_drive_file,
                    color: Colors.indigo,
                    text: "Document",
                    onTapFn: () {},
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    icon: Icons.camera_alt,
                    color: Colors.pink,
                    text: "Camera",
                    onTapFn: () {
                      setState(() {
                        popTime = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) {
                            return CameraScreen(
                              onImageSend: onImageSend,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    icon: Icons.insert_photo,
                    color: Colors.purple,
                    text: "Gallery",
                    onTapFn: () async {
                      setState(() {
                        popTime = 2;
                      });

                      file =
                          await _picker.pickImage(source: ImageSource.gallery);
                      // print(image.toString());
                      print(file!.path);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) {
                            return CameraViewPage(
                              path: file!.path,
                              onImageSend: onImageSend,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    icon: Icons.headset,
                    color: Colors.orange,
                    text: "Audio",
                    onTapFn: () {},
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    icon: Icons.location_pin,
                    color: Colors.teal,
                    text: "Location",
                    onTapFn: () {},
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    icon: Icons.person,
                    color: Colors.blue,
                    text: "Contact",
                    onTapFn: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Emoji Popup function
  Widget emojiSelect() {
    return EmojiPicker(
        columns: 7,
        rows: 4,
        onEmojiSelected: (emoji, category) {
          // print(emoji);
          _controller.text = _controller.text + emoji.emoji;
        });
  }

  Widget iconCreation({
    required IconData icon,
    required Color color,
    required String text,
    required Function()? onTapFn,
  }) {
    return InkWell(
      onTap: onTapFn,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
