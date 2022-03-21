import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psa/widget/constants.dart';

class CreateAnnoucement extends StatefulWidget {
  const CreateAnnoucement({Key? key}) : super(key: key);

  @override
  State<CreateAnnoucement> createState() => _CreateAnnoucementState();
}

class _CreateAnnoucementState extends State<CreateAnnoucement> {
  final _formKey = GlobalKey<FormState>();
  Timestamp? dateTime = Timestamp.now();

  bool inputLink = false;
  // bool getImage = false;
  bool isImageAdded = false;
  bool isLoading = false;

  String link = '';
  String title = '';
  String description = '';
  String venue = '';
  String number1 = '';
  String number2 = '';
  File? _imageFile;
  final _defaultFileUrl = const AssetImage('assets/logo.png');
  String? _uploadedFileURL;
  String _contactName1 = '';
  String _contactName2 = '';

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

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('annoucements')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(_imageFile!);
      _uploadedFileURL = await storageRef.getDownloadURL();
      print(_uploadedFileURL);
      print('kkk');
      print(_defaultFileUrl);
     /* await FirebaseFirestore.instance.collection('Announcement').add({
        'title': title,
        'description': description,
        'venue': venue,
        'number1': number1,
        'number2': number2,
        'contact1': _contactName1,
        'contact2': _contactName2,
        'link': link,
        'dateTime': dateTime,
        'imageURL': _uploadedFileURL ?? _defaultFileUrl,
      });
      setState(() {
        isLoading = false;
      });

      Navigator.pop(context);*/
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading=false;
    isImageAdded=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an announcement'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
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
                      if (value!.isEmpty || value.length<10) {
                        return 'Please enter description of min 10 words';
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
                        dateTime =
                        DateTimeField.combine(date, time) as Timestamp?;
                        return DateTimeField.combine(date, time);
                      } else {
                        dateTime = currentValue as Timestamp?;
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
                      const Text('Add a registration link'),
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
                  const Text('Add an image'),
                  const SizedBox(
                    height: 10,
                  ),
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
                        Text('Upload an Image'),
                      ],
                    ),
                  ),
                  isImageAdded
                      ? Image.file(_imageFile!)
                      : Image.asset('assets/logo.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contact Name 1',
                      hintText: 'Name of Contact to contact for queries',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {


                      _contactName1 = value!;
                      return null;
                    },
                  ),
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
                      if (value!.isNotEmpty){
                        if (value.length!=10){
                          return 'Please enter number of length 10';
                        }
                      }
                      number1 = value;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contact Name 2',
                      hintText: 'Name of Contact to contact for queries',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {

                      _contactName2 = value!;
                      return null;
                    },
                  ),
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
                      if (value!.isNotEmpty){
                        if (value.length!=10){
                          return 'Please enter number of length 10';
                        }
                      }
                      number2 = value;
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
                        onPressed: (){_submit();},
                        child: const Text('Submit'),
                       /* onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          _submit();
                        },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Submit'),*/
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
      ),
    );
  }
}