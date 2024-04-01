import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'guest_book_message.dart';
import '../entity/allEvent.dart';
import '../entity/users.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];

  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  List<AllEvent> _allEvent = [];
  List<AllEvent> get allEvent => _allEvent;

  List<Users> _users = [];
  List<Users> get users => _users;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseFirestore.instance
        .collection('allEvents')
        .snapshots()
        .listen((snapshot) {
      _allEvent = [];
      for (final document in snapshot.docs) {
        _allEvent.add(
          AllEvent(
            eventName: document.data()['eventName'] as String,
            eventDesc: document.data()['eventDesc'] as String,
            eventDate: document.data()['eventDate'] as String,
            eventTime: document.data()['eventTime'] as String,
          ),
        );
      }
      notifyListeners();
    });

    //获取登陆用户信息
    FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      _users = [];
      for (final document in snapshot.docs) {
        _users.add(
          Users(
            nickname: document.data()['nickname'] as String,
            lookingTo: document.data()['lookingTo'],
            interests: document.data()['interests'],
            memberOf: document.data()['memberOf'],
            organizerOf: document.data()['organizerOf'],
            userId: document.data()['userId'] as String,
            background: document.data()['background'] as String,
          ),
        );
      }
      print(
          'Failed to update likes for document! ${_users}');

      notifyListeners();
    });

    //获取登陆用户信息
    FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      _users = [];
      for (final document in snapshot.docs) {
        _users.add(
          Users(
            nickname: document.data()['nickname'] as String,
            lookingTo: document.data()['lookingTo'],
            interests: document.data()['interests'],
            memberOf: document.data()['memberOf'],
            organizerOf: document.data()['organizerOf'],
            userId: document.data()['userId'] as String,
            background: document.data()['background'] as String,
          ),
        );
      }
      print(
          'Failed to update likes for document! ${_users}');

      notifyListeners();
    });

    //获取已报名信息
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('eventMessages')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // Add from here...
  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      Fluttertoast.showToast(
          msg: "Must be logged in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('eventMessages')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
