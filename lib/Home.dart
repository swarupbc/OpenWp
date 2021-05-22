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
        title: Text(
          'OpenWp',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: 0.25,
                    title: 'Country Code',
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
              ElevatedButton(
                onPressed: () {
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
                child: Text('Open Chat'),
              ),
            ],
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
            color: Colors.orange[900],
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
