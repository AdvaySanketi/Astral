import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Astral/theme/colors.dart';
import 'package:Astral/pages/home_page.dart';
import 'dart:io';

void decrypt(String ciphertext) async {
  final filename = r'Astral\lib\cryptography\encrypted.txt';
  var file = await File(filename).writeAsString(ciphertext);
}

// ignore: non_constant_identifier_names
String get_decrypted() {
  File('cryptography/encrypted.txt').readAsString().then((String contents) {
    return contents;
  });
  return r"hacktivists";
}

class DecryptionPage extends StatefulWidget {
  const DecryptionPage({super.key});

  @override
  State<DecryptionPage> createState() => _DecryptionPageState();
}

class _DecryptionPageState extends State<DecryptionPage> {
  TextEditingController _ciphertext = TextEditingController(text: "");
  TextEditingController _key = TextEditingController(text: "");
  TextEditingController _decrypted = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/logo.jpg'),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Encrypted Text",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    TextField(
                      controller: _ciphertext,
                      cursorColor: black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.send_outlined),
                          prefixIconColor: black,
                          hintText: "",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Key",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    TextField(
                      controller: _key,
                      cursorColor: black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.send_outlined),
                          prefixIconColor: black,
                          hintText: "",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              var data = _ciphertext.text;
              decrypt(data);
              var decrypted = get_decrypted();
              _decrypted.text = decrypted;
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: buttoncolor, borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  "Decrypt",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Decrypted Text",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d)),
                    ),
                    TextField(
                      controller: _decrypted,
                      cursorColor: black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_open_outlined),
                          prefixIconColor: black,
                          hintText: "",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: Icon(Icons.lock_outline),
              backgroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightElevation: 0,
              hoverElevation: 0,
              elevation: 0,
              foregroundColor: Colors.white,
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeEncryptionPage()),
                    ),
                  }),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: Icon(Icons.arrow_downward_outlined),
              backgroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightElevation: 0,
              hoverElevation: 0,
              elevation: 0,
              foregroundColor: Colors.white,
              onPressed: () => {
                    sleep(Duration(seconds: 3)),
                    _decrypted.text = "Data Recieved Successfully",
                    sleep(Duration(seconds: 5)),
                    _key.text = "",
                    _ciphertext.text =
                        r"[b'B\xdd\xf2\xc3\xff\x81\xba\xc9f\xc4!W2\xad`(D', b'@\xb8\xd4\x95\x06\xa9\x9c\xdd\xac\t4\x901\xc3\x0c\n', 82221549866318507585551682154782236415496038424669244208261949631519784816309]"
                  }),
        ],
      ),
    ));
  }
}
