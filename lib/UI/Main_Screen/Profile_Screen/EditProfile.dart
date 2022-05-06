import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  String email = '';
  String address = '';
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? addressController;
  String? imagePath;
  String? imageName;
  bool isLoading = false;
  bool isPicked = false;
  final ImagePicker imagePicker = ImagePicker();
  String downloadUrl = "";
  FocusNode labelColor = FocusNode();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;

  Future pickImage(ImageSource source) async {
    try {
      Navigator.pop(context);
      // final image = await ImagePicker().pickImage(source: source);
      // if (image == null) return;
      // final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
      final XFile? pickImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickImage != null) {
        setState(() {
          imagePath = pickImage.path;
          imageName = pickImage.name;
          isPicked = true;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      final result =
          await storageRef.ref("UserProfilePic/$fileName").putFile(file);
      downloadURL(result);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String?> downloadURL(TaskSnapshot value) async {
    // downloadUrl = await storageRef.ref("UserProfilePic/$imageName").getDownloadURL();
    downloadUrl = await value.ref.getDownloadURL();
    updateDataWithImage(downloadUrl);
    print(downloadUrl);
    return downloadUrl;
  }

  updateDataWithImage(downloadUrl) {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "FullName": nameController!.text,
      "Email": emailController!.text,
      "PhoneNumber": phoneController!.text,
      "Address": addressController!.text,
      "ImageUrl": downloadUrl,
    });
  }

  updateDataWithoutImage() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "FullName": nameController!.text,
      "Email": emailController!.text,
      "PhoneNumber": phoneController!.text,
      "Address": addressController!.text,
    });
  }

  setDataToTextFormField(data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 170.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.r)),
                    child: (imagePath == null)
                        ? DefaultImage(data: data)
                        : PickedImage(imagePath),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3.w,
                            color: Colors.white,
                          ),
                          color: kMainColor,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Form(
              key: formKey,
              child: Column(
                children: [
                  buildNameField(data),
                  buildEmailField(data),
                  buildNumberField(data),
                  buildAddressField(data),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 2.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        formKey.currentState!.save();
                        if (isPicked) {
                          uploadImage(imagePath!, imageName!);
                        } else {
                          updateDataWithoutImage();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile successfully updated")));
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 2.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kMainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Color(0xff072A6C),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kBackGroundColor,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(color: kMainColor)
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("UserData")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var data = snapshot.data;
                      if (data == null) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Colors.lightBlue));
                      }
                      return setDataToTextFormField(data);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.w,
      ),
      child: Column(
        children: [
          Text(
            "Choose a Profile Picture",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: kMainColor,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: Icon(
                    Icons.camera_alt,
                    color: kMainColor,
                    size: 25,
                  ),
                  label: Text(
                    "Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: kMainColor,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: Icon(
                    Icons.image,
                    color: kMainColor,
                    size: 25,
                  ),
                  label: Text(
                    "Gallery",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: kMainColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildNameField(data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        focusNode: labelColor,
        controller: nameController =
            TextEditingController(text: data["FullName"]),
        onSaved: (value) {
          setState(() {
            fullName = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Full Name",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "Please enter your Full Name";
          } else
            return null;
        },
      ),
    );
  }

  Widget buildEmailField(data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: emailController =
            TextEditingController(text: data["Email"]),
        onSaved: (value) {
          setState(() {
            email = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Email",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        validator: (value) {
          final pattern =
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return "Please enter your Email";
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildNumberField(data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: phoneController =
            TextEditingController(text: data["PhoneNumber"]), //autofocus: true,
        onSaved: (value) {
          setState(() {
            phone = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Phone Number",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        validator: (value) {
          final pattern = r'(^[0-9]{11}$)';
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Please enter your Phone Number';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid phone number';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildAddressField(data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: addressController =
            TextEditingController(text: data["Address"]), //autofocus: true,
        onSaved: (value) {
          setState(() {
            address = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Address",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Address";
          } else
            return null;
        },
      ),
    );
  }
}

Widget DefaultImage({required var data}) {
  return Container(
    width: 170.w,
    height: 170.h,
    decoration: BoxDecoration(
      border: Border.all(width: 4.w, color: Colors.white),
      boxShadow: [
        BoxShadow(
            spreadRadius: 2.r,
            blurRadius: 10.r,
            color: Colors.black.withOpacity(0.1))
      ],
      image: DecorationImage(
        image: NetworkImage(data["ImageUrl"]),
        fit: BoxFit.fill,
      ),
      shape: BoxShape.circle,
    ),
    // child: Image.network(
    //   data["ImageUrl"],
    //   fit: BoxFit.cover,
    // ),
  );
}
Widget PickedImage(String? imagePath) {
  return Container(
    width: 170.w,
    height: 170.h,
    decoration: BoxDecoration(
      border: Border.all(width: 4.w, color: Colors.white),
      boxShadow: [
        BoxShadow(
            spreadRadius: 2.r,
            blurRadius: 10.r,
            color: Colors.black.withOpacity(0.1))
      ],
      image: DecorationImage(
        image: FileImage(File(imagePath!)),
        fit: BoxFit.fill,
      ),
      shape: BoxShape.circle,
    ),
    // child: Image.network(
    //   data["ImageUrl"],
    //   fit: BoxFit.cover,
    // ),
  );
}
