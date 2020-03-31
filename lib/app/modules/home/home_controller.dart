import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:project_c/app/shared/auth/auth_controller.dart';
import 'package:project_c/app/shared/repositories/localstorage/local_storage_hive.dart';
import 'package:project_c/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  final ILocalStorage _storage = Modular.get();

  @observable
  String text = '';

  @action
  setText(String value) => text = value;

  @observable
  ObservableList<String> list = <String>[].asObservable();

  _HomeControllerBase(){
    init();
  }

  @action
  init() async{
    List<String> listLocal = await _storage.get('list');
    if(listLocal == null){
      list = <String>[].asObservable();
    } else {
      list = listLocal.asObservable();
    }
  }  

  @action
  void save() {
    list.add(text);
    _storage.put('list', list);
  }
 
 
  @action
  void remove(int index) {
    list.removeAt(index);
    _storage.put('list', list);
  }

  logoff() async {
    await Modular.get<AuthController>().logOut();
    Modular.to.pushReplacementNamed('/login');
  }
}
