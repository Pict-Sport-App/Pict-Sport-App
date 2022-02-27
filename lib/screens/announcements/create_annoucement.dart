import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CreateAnnoucement extends StatefulWidget {
  const CreateAnnoucement({Key? key}) : super(key: key);

  @override
  State<CreateAnnoucement> createState() => _CreateAnnoucementState();
}

class _CreateAnnoucementState extends State<CreateAnnoucement> {
  final _formKey = GlobalKey<FormState>();
  DateTime? dateTime = DateTime.now();

  bool inputLink = false;
  bool getImage = false;
  bool isImageAdded = false;

  String link = '';
  String title = '';
  String description = '';
  String venue = '';
  String number = '';
  File? _imageFile;
  String? _uploadedFileURL;

  Future getImageFromStorage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 800);
    if (pickedFile == null) return;
    setState(() {
      isImageAdded = true;
      _imageFile = File(pickedFile.path);
    });
    return pickedFile;
  }

  Future _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print(title);
      print(description);
      print(venue);
      print(number);
      print(link);
      print(dateTime);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('annoucements')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(_imageFile!);
      _uploadedFileURL = await storageRef.getDownloadURL();

      print(_uploadedFileURL);
      await FirebaseFirestore.instance.collection('Announcement').add({
        'title': title,
        'description': description,
        'venue': venue,
        'number': number,
        'link': link,
        'dateTime': dateTime,
        'imageURL': _uploadedFileURL,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an annoucement'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the title';
                    }
                    title = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  minLines: 5,
                  maxLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some description';
                    }
                    description = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Venue',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a venue';
                    }
                    venue = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DateTimeField(
                  decoration: const InputDecoration(
                    labelText: 'Date & Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  initialValue: DateTime.now(),
                  format: DateFormat('dd/MM/yyyy HH:mm'),
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now(),
                        ),
                      );
                      dateTime = DateTimeField.combine(date, time);
                      return DateTimeField.combine(date, time);
                    } else {
                      dateTime = currentValue;
                      return currentValue;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Add a regisration link'),
                    Switch(
                      value: inputLink,
                      onChanged: (value) {
                        setState(() {
                          inputLink = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (inputLink)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Link',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a link';
                      }
                      return null;
                    },
                  ),
                Row(
                  children: [
                    const Text('Add an image'),
                    Switch(
                      value: getImage,
                      onChanged: (value) {
                        setState(() {
                          getImage = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (getImage)
                  TextButton(
                    onPressed: getImageFromStorage,
                    child: Row(
                      children: const [
                        Expanded(
                          child: SizedBox(),
                        ),
                        Icon(Icons.upload_rounded),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Uplaod an Image'),
                      ],
                    ),
                  ),
                getImage
                    ? isImageAdded
                        ? Image.file(_imageFile!)
                        : Image.network(
                            'https://source.unsplash.com/user/c_v_r/1900x800') //TODO add default image link
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    hintText: 'Phone number to contact for queries',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.length != 10 && value.isNotEmpty) {
                      return 'Please enter a valid phone number';
                    }
                    number = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
