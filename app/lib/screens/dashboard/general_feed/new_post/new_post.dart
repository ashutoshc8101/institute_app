import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class NewPost extends StatefulWidget {
  VoidCallback successCallback;
  NewPost({
    Key? key,
    required this.successCallback,
  }) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final quill.QuillController _controller = quill.QuillController.basic();
  // Create secureStorage
  final secureStorage = const FlutterSecureStorage();
  String baseUrl = FlavorConfig.instance.variables['baseUrl'];
  List<PlatformFile> files = [];

  Future<bool> _submitPost(String richText) async {
    try {
      String? idToken = await secureStorage.read(key: 'idToken');
      final requestUrl = Uri.parse(baseUrl + '/feed/create/');

      var request = http.MultipartRequest('POST', requestUrl);
      final headers = {'Authorization': 'idToken ' + idToken!};
      request.headers.addAll(headers);
      request.fields['body'] = richText;
      for (var file in files) {
        request.files
            .add(await http.MultipartFile.fromPath(file.name, file.path!));
      }
      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('API Call Failed');
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          "Add Post",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: size.height -
                (MediaQuery.of(context).padding.top + kToolbarHeight),
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(0.0),
              ),
              color: Color(0xfff5f5f5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    quill.QuillToolbar.basic(
                      controller: _controller,
                      showFontFamily: false,
                      multiRowsDisplay: false,
                      toolbarSectionSpacing: 0,
                      showUndo: false,
                      showRedo: false,
                      showFontSize: false,
                      showColorButton: true,
                      showBackgroundColorButton: true,
                      showListBullets: false,
                      showListCheck: false,
                      showListNumbers: false,
                      showCodeBlock: false,
                      showInlineCode: false,
                      showAlignmentButtons: false,
                      showSearchButton: false,
                      showClearFormat: false,
                      showIndent: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: quill.QuillEditor.basic(
                          controller: _controller, readOnly: false),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);

                        if (result != null) {
                          setState(() {
                            for (var file in result.files) {
                              files.add(file);
                            }
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: const Text('Add attachments'),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(files[index].name),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      files.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          String richText = jsonEncode(
                              _controller.document.toDelta().toJson());

                          if (richText.isNotEmpty) {
                            bool response = await _submitPost(richText);

                            if (response) {
                              Navigator.pop(context);
                              widget.successCallback();
                            }
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
