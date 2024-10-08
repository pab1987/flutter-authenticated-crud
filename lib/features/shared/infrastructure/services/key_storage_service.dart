
abstract class KeyValueStorageService {
  //! El tipo de dato T es un tipo de dato genérico y me permite tratar el dato como el tipo de dato que se envía.
  //! si le paso a la función un entero por ejemplo, T se comportará como tipo de dato entero
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
}