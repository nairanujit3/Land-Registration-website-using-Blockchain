import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:land_registration/screens/user_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../providers/LandRegisterModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart';
import '../constant/utils.dart';
import '../providers/MetamaskProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late String name, age, city, adharNumber, panNumber, document, email;
  Uint8List? imageData;
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      setState(() {
        imageData = bytes;
      });
    }
  }

  double width = 590;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false, isAdded = false;
  String docuName = "";
  late PlatformFile documentFile;
  String cid = "", docUrl = "";

  List<MapBoxPlace> predictions = [];
  late PlacesSearch placesSearch;
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  TextEditingController addressController = TextEditingController();

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 540,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, 40 + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: List.generate(
                        predictions.length,
                        (index) => ListTile(
                              title:
                                  Text(predictions[index].placeName.toString()),
                              onTap: () {
                                addressController.text =
                                    predictions[index].placeName.toString();

                                setState(() {});
                                _overlayEntry.remove();
                                _overlayEntry.dispose();
                              },
                            )),
                  ),
                ),
              ),
            ));
  }

  Future<void> autocomplete(value) async {
    List<MapBoxPlace>? res = await placesSearch.getPlaces(value);
    if (res != null) predictions = res;
    setState(() {});
    print(res);
    print(res![0].placeName);
    print(res![0].geometry!.coordinates);
    print(res![0]);
  }

  @override
  void initState() {
    placesSearch = PlacesSearch(
      apiKey: mapBoxApiKey,
      limit: 10,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      docuName = result.files.single.name;
      documentFile = result.files.first;
    }
    setState(() {});
  }

  Future<bool> uploadDocument() async {
    String url = "https://api.nft.storage/upload";
    var header = {"Authorization": "Bearer $nftStorageApiKey"};

    if (docuName != "") {
      try {
        final response = await http.post(Uri.parse(url),
            headers: header, body: documentFile.bytes);
        var data = jsonDecode(response.body);
        //print(data);
        if (data['ok']) {
          cid = data["value"]["cid"];
          docUrl = "https://" + cid + ".ipfs.dweb.link";
          print(docUrl);
          return true;
        }
      } catch (e) {
        print(e);
        showToast("Something went wrong,while document uploading",
            context: context, backgroundColor: Colors.red);
      }
    } else {
      showToast("Choose Document",
          context: context, backgroundColor: Colors.red);
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LandRegisterModel>(context);
    var model2 = Provider.of<MetaMaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('User Registration'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/3.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Material(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(15),
                width: width,
                color: Color.fromARGB(255, 236, 199, 143),
                child: Column(
                  children: [
                    // Heading "User Registration"
                    const Text(
                      'User Registration',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          //     Container(
                          //       width: 150,
                          //       height: 150,
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Colors.black,
                          //           width: 2.0,
                          //         ),
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //       child: imageData != null
                          //           ? Image.memory(
                          //               imageData!,
                          //               width: 150,
                          //               height: 150,
                          //               fit: BoxFit.cover,
                          //             )
                          //           : Center(
                          //               child: Text(
                          //                 'No Image Selected',
                          //                 style: TextStyle(fontSize: 16),
                          //               ),
                          //             ),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         await pickImage();
                          //       },
                          //       child: Text('Select Image'),
                          //     ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                name = val;
                              },
                              decoration: const InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                hintText: 'Enter Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter age';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              onChanged: (val) {
                                age = val;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: const InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(),
                                labelText: 'Age',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                hintText: 'Enter Age',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CompositedTransformTarget(
                              link: this._layerLink,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 15,
                                ),

                                controller: addressController,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    autocomplete(value);
                                    _overlayEntry.remove();
                                    _overlayEntry = this._createOverlayEntry();
                                    Overlay.of(context)!.insert(_overlayEntry);
                                  } else {
                                    if (predictions.length > 0 && mounted) {
                                      setState(() {
                                        predictions = [];
                                      });
                                    }
                                  }
                                },
                                focusNode: this._focusNode,
                                // obscureText: true,
                                decoration: const InputDecoration(
                                  isDense: true, // Added this
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(),
                                  labelText: 'Address',
                                  labelStyle:
                                      const TextStyle(color: Colors.green),
                                  hintText: 'Enter Address',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Adhar number';
                                } else if (value.length != 12)
                                  return 'Please enter Valid Adhar number';
                                return null;
                              },
                              //maxLength: 12,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (val) {
                                adharNumber = val;
                              },
                              //obscureText: true,
                              decoration: const InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(),
                                labelText: 'Adhar',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                hintText: 'Enter Adhar Number',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Pan Number';
                                } else if (value.length != 10)
                                  return 'Please enter Valid Pan number';
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              //maxLength: 10,

                              onChanged: (val) {
                                panNumber = val;
                              },
                              //obscureText: true,
                              decoration: const InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(),
                                labelText: 'Pan',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                hintText: 'Enter Pan Number',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MaterialButton(
                                      color: const Color.fromARGB(
                                          255, 221, 219, 219),
                                      onPressed: pickDocument,
                                      child: const Text('Upload Document'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: 5), // Add a small vertical space
                                Text(
                                  docuName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 1, 76, 89)),
                                ),
                                const Text(
                                  'What to upload:  Adhar card\n'
                                  'Allowed formats: JPG, PDF\n'
                                  'Size: 50KB to 200KB',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 199, 13, 13)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?)*$");
                                if (!regex.hasMatch(value!) || value == null)
                                  return 'Enter a valid email address';
                                else
                                  return null;
                              },
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              onChanged: (val) {
                                email = val;
                              },
                              //obscureText: true,
                              decoration: const InputDecoration(
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                hintText: 'Enter Email',
                              ),
                            ),
                          ),
                          isAdded
                              ? CustomButton('Contine to Login', () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserDashBoard()));
                                  Navigator.of(context).pushNamed(
                                    '/user',
                                  );
                                })
                              : CustomButton(
                                  'Add',
                                  isLoading
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            try {
                                              SmartDialog.showLoading(
                                                  msg: "Uploading Document");
                                              bool isFileupload =
                                                  await uploadDocument();
                                              SmartDialog.dismiss();
                                              if (isFileupload) {
                                                if (connectedWithMetamask)
                                                  await model2.registerUser(
                                                      name,
                                                      age,
                                                      addressController.text,
                                                      adharNumber,
                                                      panNumber,
                                                      docUrl,
                                                      email);
                                                else
                                                  await model.registerUser(
                                                      name,
                                                      age,
                                                      addressController.text,
                                                      adharNumber,
                                                      panNumber,
                                                      docUrl,
                                                      email);
                                                showToast(
                                                    "Successfully Registered",
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.green);
                                                isAdded = true;
                                              }
                                            } catch (e) {
                                              print(e);
                                              showToast("Something Went Wrong",
                                                  context: context,
                                                  backgroundColor: Colors.red);
                                            }

                                            setState(() {
                                              isLoading = false;
                                            });
                                          }

                                          //model.makePaymentTestFun();
                                        }),
                          isLoading
                              ? const CircularProgressIndicator()
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
