import 'package:flutter/material.dart';
import 'package:hni_project/view/widgets/characters_list.dart';
import 'package:hni_project/view_model/character_vm.dart';
import 'package:provider/provider.dart';
import 'package:simple_logger/simple_logger.dart';
import '../../model/character.dart';

class ListCharacters extends StatefulWidget {
  final CharacterCategory house;

  const ListCharacters({super.key, required this.house});

  @override
  State<ListCharacters> createState() => _ListCharactersState();
}

class _ListCharactersState extends State<ListCharacters> {
  bool isSearchButtonClicked = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  List<Character> filteredCharacters = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final characterViewModel =
          Provider.of<CharacterViewModel>(context, listen: false);
      characterViewModel.fetchCharacters(category: widget.house);
    });
  }

  void updateSearchResults(String query) {
    final characterViewModel =
        Provider.of<CharacterViewModel>(context, listen: false);
    setState(() {
      this.query = query;
      filteredCharacters = characterViewModel.character
          .where((character) =>
              character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff2A291E),
            foregroundColor: Colors.white,
            title: isSearchButtonClicked
                ? Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      focusNode: _searchFocus,
                      controller: _searchController,
                      onChanged: updateSearchResults,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          border: InputBorder.none,
                          hintText: "Search Characters..."),
                    ),
                  )
                : Text(
                    "${widget.house.toString().split('.').last[0].toUpperCase()}${widget.house.toString().split('.').last.substring(1)} Characters",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_arrow_left_rounded),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isSearchButtonClicked = !isSearchButtonClicked;
                        if (isSearchButtonClicked) {
                          FocusScope.of(context).requestFocus(_searchFocus);
                        } else {
                          _searchController.clear();
                          updateSearchResults('');
                          FocusScope.of(context).unfocus();
                        }
                      },
                    );
                  },
                  icon:
                      Icon(isSearchButtonClicked ? Icons.close : Icons.search),
                ),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "All",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Students",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Staffs",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
              ],
            )),
        body: SafeArea(
          child: TabBarView(
            children: [
              CharactersGrid(query: query, filteredCharacters: filteredCharacters),
              CharactersGrid(query: query, filteredCharacters: filteredCharacters, showStudents: true,),
              CharactersGrid(query: query, filteredCharacters: filteredCharacters, showStaff: true,),
            ],
          ),
        ),
      ),
    );
  }
}
