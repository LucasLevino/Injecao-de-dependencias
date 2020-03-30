import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_c/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageShare implements ILocalStorage{
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

 _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }
  
  LocalStorageShare(){
    _init();
  }

  @override
  Future delete(String key) async {
    var shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future<List<String>> get(String key) async {
    var box = await _instance.future;
    return box.getStringList(key);
  }

  @override
  Future<List<String>> put(String key, List<String> value) async {
    var box = await _instance.future;
    box.setStringList(key, value);
  }

}