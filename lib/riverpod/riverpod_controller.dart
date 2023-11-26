import 'package:flutter/material.dart';
import 'package:riverpod_app/model/user_model.dart';
import 'package:riverpod_app/service/service.dart';

class Controller extends ChangeNotifier {
  PageController pageController = PageController();
  bool? isLoading;
  List<Data?> userData = [];
  List<Data?> saveUser = [];
  void getData() {
    Service.fetchGames().then((value) {
      if (value != null) {
        userData = value.data!;

        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void addUser(Data data) async {
    saveUser.add(data);
    userData.remove(data);
    notifyListeners();
  }

  void incramentUser(Data data) async {
    userData.add(data);
    saveUser.remove(data);

    notifyListeners();
  }
}
