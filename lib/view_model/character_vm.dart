import 'package:hni_project/model/character.dart';
import 'package:hni_project/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';

enum CharacterCategory {
  all,
  gryffindor,
  slytherin,
  ravenclaw,
}

class CharacterViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Character> _character = [];
  List<Character> get character => _character;

  CharacterCategory currentCategory = CharacterCategory.all;

  final SimpleLogger _log = SimpleLogger();

  Future<void> fetchCharacters(
      {CharacterCategory category = CharacterCategory.all}) async {
    try {
      _isLoading = true;
      notifyListeners();
      List<Character> fetchedCharacters;
      switch (category) {
        case CharacterCategory.all:
          fetchedCharacters = await apiService.fetchAllCharacters();
          break;
        case CharacterCategory.gryffindor:
          fetchedCharacters =
          await apiService.fetchCharactersByHouse('gryffindor');
          break;
        case CharacterCategory.slytherin:
          fetchedCharacters =
          await apiService.fetchCharactersByHouse('slytherin');
          break;
        case CharacterCategory.ravenclaw:
          fetchedCharacters =
          await apiService.fetchCharactersByHouse('ravenclaw');
          break;
      }
      await Future.delayed(Duration(seconds: 1));
      _character = fetchedCharacters;
      _character.sort((a,b) => a.name.compareTo(b.name));
      currentCategory = category;
    } catch (e) {
      _log.warning(e);
      _character = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void setCategory(CharacterCategory category) {
    fetchCharacters(category: category);
  }
}
