import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hni_project/view/pages/characters_list_page.dart';
import 'package:hni_project/view_model/character_vm.dart';

class ChooseHouse extends StatelessWidget {
  const ChooseHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose House"),
        centerTitle: true,
        backgroundColor: Color(0xff2A291E),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_rounded),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CharactersListPage(house: CharacterCategory.ravenclaw));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/ravenclaw.png"),
                          SizedBox(height: 8),
                          Text(
                            "Ravenclaw",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CharactersListPage(house: CharacterCategory.gryffindor));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/gryffindor.png"),
                          SizedBox(height: 8),
                          Text(
                            "Gryffindor",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CharactersListPage(house: CharacterCategory.slytherin));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/slytherin.png"),
                          SizedBox(height: 8),
                          Text(
                            "Slytherin",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
