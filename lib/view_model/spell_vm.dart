import 'package:hni_project/model/spells.dart';
import 'package:hni_project/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';

class SpellViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Spell> spell = [];

  bool isLoading = true;
  final SimpleLogger _log = SimpleLogger();

  Future<void> fetchSpells() async {
    try {
      isLoading = true;
      notifyListeners();
      List<Spell> fetchedSpells = await apiService.fetchAllSpells();
      _log.info(fetchedSpells);
      spell = fetchedSpells;
    } catch (e) {
      _log.warning(e);
      spell = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
