import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/wp.png',
              height: 35.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'OpenWp',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
        leadingWidth: 40.0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: '',
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        'https://github.com/swarupbhanjachowdhury/OpenWp');
                  },
                  child: Text('Source Code'),
                ),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Enter Prefix (Country Coode, Ex: 91 for India or 1 for US) & WhatsApp number, then press the button to chat, message is an optional field',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Text(
                      '+',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    CustomTextField(
                      width: 0.20,
                      title: 'Prefix',
                      hint: 'Ex: 91',
                      controller: codeController,
                      keyboard: TextInputType.number,
                    ),
                    Spacer(),
                    CustomTextField(
                      controller: numberController,
                      width: 0.6,
                      title: 'WhatsApp Number',
                      hint: 'Ex: 7865900000',
                      keyboard: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomTextField(
                  controller: messageController,
                  width: 0.7,
                  title: 'Message',
                  hint: 'Ex: Hey, how are you?',
                  line: 3,
                  keyboard: TextInputType.text,
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (codeController.text == '') {
                      showSnackbar(
                          error: 'Enter Country Code, Ex: 91 for india',
                          context: context);
                    } else if (numberController.text == '') {
                      showSnackbar(
                          error: 'Enter Country Code, Ex: 91 for india',
                          context: context);
                    } else {
                      var message = Uri.parse(messageController.text);
                      print(message);
                      _launchURL(
                          'https://wa.me/${codeController.text.trim()}${numberController.text.trim()}/?text=$message');
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            const Color(0xFF3366FF),
                            const Color(0xFF00CCFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Open Chat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250.0,
                ),
                Text(
                  'The WhatsApp name and logos are trademarks of WhatsApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.width = 0.5,
    this.title = 'Title',
    this.hint = 'Hint',
    this.keyboard = TextInputType.name,
    this.line = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final double width;
  final String title;
  final String hint;
  final TextInputType keyboard;
  final int line;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      child: TextField(
        controller: controller,
        maxLines: line,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          hintText: hint,
        ),
        keyboardType: keyboard,
      ),
    );
  }
}
