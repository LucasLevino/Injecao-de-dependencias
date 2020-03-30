abstract class ILocalStorage {
  Future<List<String>> get(String key);
  Future<List<String>> put(String key, List<String> value);
  Future delete(String key);
}