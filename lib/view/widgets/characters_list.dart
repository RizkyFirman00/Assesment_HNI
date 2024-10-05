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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Text(character.name),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (character.image != null &&
                                            character.image!.isNotEmpty)
                                          Center(
                                            child: Image.network(
                                              character.image!,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        const SizedBox(height: 10),
                                        _buildCharacterDetail(
                                            'Alternate Names',
                                            character.alternateNames
                                                ?.join(", ")),
                                        _buildCharacterDetail(
                                            'Species', character.species),
                                        _buildCharacterDetail(
                                            'Gender', character.gender),
                                        _buildCharacterDetail(
                                            'House', character.house),
                                        _buildCharacterDetail('Date of Birth',
                                            character.dateOfBirth),
                                        _buildCharacterDetail('Year of Birth',
                                            character.yearOfBirth?.toString()),
                                        _buildCharacterDetail(
                                            'Wizard',
                                            character.wizard == true
                                                ? 'Yes'
                                                : 'No'),
                                        _buildCharacterDetail(
                                            'Ancestry', character.ancestry),
                                        _buildCharacterDetail(
                                            'Eye Colour', character.eyeColour),
                                        _buildCharacterDetail('Hair Colour',
                                            character.hairColour),
                                        if (character.wand != null &&
                                            (character.wand!['wood']!
                                                    .isNotEmpty ||
                                                character.wand!['core']!
                                                    .isNotEmpty ||
                                                character.wand!['length'] !=
                                                    null))
                                          _buildCharacterDetail(
                                            'Wand',
                                            '${character.wand!['wood']?.isNotEmpty == true ? character.wand!['wood'] : 'Unknown wood'}, '
                                                '${character.wand!['core']?.isNotEmpty == true ? character.wand!['core'] : 'Unknown core'}, '
                                                '${character.wand!['length'] != null ? character.wand!['length'] : 'Unknown length'}',
                                          ),
                                        _buildCharacterDetail(
                                            'Patronus', character.patronus),
                                        _buildCharacterDetail(
                                            'Hogwarts Student',
                                            character.hogwartsStudent == true
                                                ? 'Yes'
                                                : 'No'),
                                        _buildCharacterDetail(
                                            'Hogwarts Staff',
                                            character.hogwartsStaff == true
                                                ? 'Yes'
                                                : 'No'),
                                        _buildCharacterDetail(
                                            'Actor', character.actors),
                                        _buildCharacterDetail(
                                            'Alternate Actors',
                                            character.alternateActors
                                                ?.join(", ")),
                                        _buildCharacterDetail(
                                            'Alive',
                                            character.alive == true
                                                ? 'Yes'
                                                : 'No'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      character.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _buildCharacterDetail(String title, String? value) {
    if (value == null || value.isEmpty) {
      return SizedBox(); // Tidak menampilkan apa-apa jika nilai null atau kosong
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
