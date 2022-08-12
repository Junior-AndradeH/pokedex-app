// import
import 'apis_model.dart';

// main class
class UrlsModel {
  // static
  static String get pokemonsGet => "${APIsModel.apiGet}/pokemon";
  static String get speciesGet => "${APIsModel.apiGet}/pokemon-species";
  static String get movesGet => "${APIsModel.apiGet}/move";
}