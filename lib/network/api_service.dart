import 'package:dio/dio.dart';
import 'package:hni_project/model/character.dart';
import 'package:hni_project/model/spells.dart';
import 'package:simple_logger/simple_logger.dart';

class ApiService {
  final Dio _dio = Dio();
  final SimpleLogger _log = SimpleLogger();
  final String baseUrl = "https://hp-api.onrender.com/api";

  Future<List<Character>> fetchAllCharacters() async {
    try {
      final response = await _dio.get("$baseUrl/characters");
      if (response.statusCode == 200) {
        _log.info("Fetch data succeed");
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load all characters");
      }
    } catch (e) {
      _log.warning("Error fetch characters $e");
      throw Exception("Failed to load all characters");
    }
  }

  Future<List<Character>> fetchCharactersByCategory(String category) async {
    try {
      final response = await _dio.get("$baseUrl/characters/$category");
      if (response.statusCode == 200) {
        _log.info("Fetch data by category succeed");
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load all characters");
      }
    } catch (e) {
      _log.warning("Error fetch characters by category $e");
      throw Exception("Failed to load all characters");
    }
  }

  Future<List<Character>> fetchCharactersByHouse(String house) async {
    return fetchCharactersByCategory("house/$house");
  }

  Future<List<Character>> fetchCharactersStudents() async {
    return fetchCharactersByCategory("students");
  }

  Future<List<Character>> fetchCharactersStaff() async {
    return fetchCharactersByCategory("staff");
  }

  Future<List<Spell>> fetchAllSpells() async {
    try {
      final response = await _dio.get("$baseUrl/spells");
      if (response.statusCode == 200) {
        _log.info("Fetch data spells succeed");
        final List<dynamic> data = response.data;
        return data.map((json) => Spell.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load all characters");
      }
    } catch (e) {
      _log.warning("Error fetch characters by category $e");
      throw Exception("Failed to load all characters");
    }
  }
}