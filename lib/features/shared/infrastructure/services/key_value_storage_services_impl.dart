
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_storage_service.dart';

//! En esta clase manejamos la intancia de SharedPreferences para guardar el token en nuestro dispositivo
class KeyValueStorageServiceImpl extends KeyValueStorageService {

  //! Esta es el método de inicialización de SharedPreferences
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }


  //! Obtenemos el token guardado teniendo en cuenta que el tipo de dato puede variar dependiendo el 
  //! paquete que estemos usando.
  @override
  Future<T?> getValue<T>(String key) async {

    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
        

      case String:
        return prefs.getString(key) as T?;
        

      default:
        throw UnimplementedError('GET not implemented for type: ${T.runtimeType}');
    }
  }

  //! Removemos el token guardado en el dispositivo
  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  //! Guardamos el token en el dispositivo teniendo en cuenta que el tipo de dato puede variar
  //! Se hace de esta forma para poder cambiar a futuro el paquete de ser necesario
  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;

      case String:
        prefs.setString(key, value as String);
        break;

      default:
        throw UnimplementedError('Set not implemented for type: ${T.runtimeType}');
    }
  }

}