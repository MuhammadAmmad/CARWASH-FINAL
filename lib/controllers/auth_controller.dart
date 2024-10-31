import 'dart:core';
import 'dart:io';

import 'package:car_wash_light/view/screens/launch/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var userId = ''.obs;
  var userName = ''.obs;
  var imageUrl = ''.obs;
  var emailText = ''.obs;
  var message = 'Please complete all fields!'.obs;
  var colorController = true.obs;
  var loginMessage = ''.obs;
  var loginColor = true.obs;
  var isLoading = false.obs;
  var regLoading = false.obs;
  var regMessage = ''.obs;
  var hiveUserId = ''.obs;
  var imageLoading = false.obs;

  // FOR USING HIVE
  late Box<String> dataBox;

  // OPEN HIVE BOX
  Future<void> openBox() async {
    dataBox = await Hive.openBox<String>('dataBox');
  }

  // SAVE DATA
  void saveData(String data) {
    dataBox.put('userId', data);
  }

  // RETRIEVE DATA
  String? retrieveData() {
    return dataBox.get('userId');
  }

  // DELETE DATA
  void deleteData() {
    dataBox.delete('userId');
  }

  @override
  void onInit() {
    super.onInit();
    openBox().then((_) {
      userId.value = retrieveData() ?? '';
      getUsernameAndImage();
    });
  }

  void changeIsLoading(bool value) {
    isLoading.value = value;
  }

  void changeRegLoading(bool value) {
    regLoading.value = value;
  }

  void changeImageLoading(bool value) {
    imageLoading.value = value;
  }

  Rx<User?> firebaseUser = Rx<User?>(null);

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Adding instances of Firebase services
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // LOGIN METHOD
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      userId.value = userCredential.user!.uid;
      hiveUserId.value = userId.value;
      saveData(hiveUserId.value);
      getUsernameAndImage();
      emailText.value = email;

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      loginMessage.value = e.message.toString();
      loginColor.value = false;
      print('Error: $e');
      return null;
    }
  }

  // SIGNUP METHOD
  Future<User?> signUpWithEmailPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;
        userId.value = uid;

        // Add user data to Firestore
        await firestore.collection('users').doc(uid).set({
          'username': username,
          'email': email,
          'uid': uid,
          'imageurl': '',
        });

        print('User added successfully!');
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      message.value = e.message.toString();
      colorController.value = false;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // RESET PASSWORD METHOD
  Future<String> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent! Check your inbox.';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // PICK AND UPLOAD IMAGE
  Future<void> pickFileAndUpload() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      print("Successfully picked file!");

      // UPLOAD IMAGE TO FIREBASE STORAGE
      UploadTask uploadTask = storage
          .ref('users/${userId}/profilePic/profile.jpg')
          .putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl.value = downloadUrl;
      DocumentReference usersDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId.value);
      await usersDocRef.update({'imageurl': downloadUrl});
    }
  }

  // RETRIEVE USERNAME, IMAGE AND EMAIL
  Future<void> getUsernameAndImage() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .get();

      if (documentSnapshot.exists) {
        String? username = documentSnapshot['username'];
        String? image = documentSnapshot['imageurl'];
        String? email = documentSnapshot['email'];
        userName.value = username!;
        imageUrl.value = image!;
        emailText.value = email!;
        print('Username: $username');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error retrieving document: $e');
    }
  }

  // SIGN-OUT METHOD
  Future<String?> signOut() async {
    try {
      await auth.signOut();
      deleteData();
      Get.offAll(() => SplashScreen());
      return "${userName} signed out successfully";
    } catch (e) {
      return null;
    }
  }
}
