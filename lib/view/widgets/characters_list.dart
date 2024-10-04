import 'package:flutter/material.dart';
import 'package:hni_project/model/character.dart';
import 'package:hni_project/view_model/character_vm.dart';
import 'package:provider/provider.dart';

class CharactersGrid extends StatelessWidget {
  final String query;
  final List<Character> filteredCharacters;
  final bool showStudents;
  final bool showStaff;

  const CharactersGrid({
    super.key,
    required this.query,
    required this.filteredCharacters,
    this.showStudents = false,
    this.showStaff = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Consumer<CharacterViewModel>(
        builder: (context, characterViewModel, child) {
          if (characterViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final characters =
              query.isEmpty ? characterViewModel.character : filteredCharacters;

          List<Character> filteredList = characters;

          if (showStudents) {
            filteredList = characters
                .where((character) => character.hogwartsStudent == true)
                .toList();
          } else if (showStaff) {
            filteredList = characters
                .where((character) => character.hogwartsStaff == true)
                .toList();
          }

          return filteredList.isEmpty
              ? const Center(child: Text('No characters found'))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final character = filteredList[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            character.image!.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      image: DecorationImage(
                                        image: NetworkImage(character.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      color: Colors.grey[200],
                                    ),
                                    child: const Icon(Icons.person, size: 50),
                                  ),
                            const SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Center(
                                child: Text(
                                  character.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
