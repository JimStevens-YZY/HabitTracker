import 'package:event_gather/pages/entity/allGroups.dart';
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
import '../entity/signedEvent.dart';
import '../entity/categories.dart';
import '../entity/users.dart';
import '../entity/allGroups.dart';
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

  List<SignedEvent> _signedEvent = [];

  List<SignedEvent> get signedEvent => _signedEvent;

  List<Categories> _categories = [];

  List<Categories> get categories => _categories;

  List<AllGroups> _allGroups = [];

  List<AllGroups> get allGroups => _allGroups;

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
            eventId: document.id,
            eventName: document.data()['eventName'] as String,
            eventDesc: document.data()['eventDesc'] as String,
            eventDate: document.data()['eventDate'] as String,
            eventTime: document.data()['eventTime'] as String,
            eventLocation: document.data()['eventLocation'] as String,
            eventBg: document.data()['eventBg'] as String,
          ),
        );
      }
      notifyListeners();
    });

    //获取报名的Event信息
    FirebaseFirestore.instance
        .collection('signedEvent')
        .snapshots()
        .listen((snapshot) {
      _signedEvent = [];
      for (final document in snapshot.docs) {
        _signedEvent.add(
          SignedEvent(
            signedEventDate: document.data()['signedEventDate'] as String,
            signedEventDesc: document.data()['signedEventDesc'] as String,
            signedEventName: document.data()['signedEventName'] as String,
            signedEventTime: document.data()['signedEventTime'] as String,
            userId: document.data()['userId'] as String,
          ),
        );
      }
      notifyListeners();
    });

    //获取groups
    FirebaseFirestore.instance
        .collection('groups')
        .snapshots()
        .listen((snapshot) {
      _allGroups = [];
      for (final document in snapshot.docs) {
        _allGroups.add(
          AllGroups(
            groupBg: document.data()['groupBg'] as String,
            groupDesc: document.data()['groupDesc'] as String,
            groupLocation: document.data()['groupLocation'] as String,
            groupName: document.data()['groupName'] as String,
            groupOrganizers: document.data()['groupOrganizers'],
            groupType: document.data()['groupType'] as int,
          ),
        );
      }
      notifyListeners();
    });

    //获取分类
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
      _categories = [];
      for (final document in snapshot.docs) {
        _categories.add(
          Categories(
            categoryBg: document.data()['categoryBg'] as String,
            categoryName: document.data()['categoryName'] as String,
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
      print('Failed to update likes for document! ${_users}');

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
      print('Failed to update likes for document! ${_users}');

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
