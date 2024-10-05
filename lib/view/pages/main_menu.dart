import 'package:flutter/material.dart';
import 'package:hni_project/view/pages/choose_house.dart';
import 'package:hni_project/view/pages/spells_list_page.dart';
import 'package:hni_project/view/widgets/big_button.dart';
import 'package:provider/provider.dart';
import '../../view_model/character_vm.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigButton(
                icon: Icons.person,
                text: "CHARACTERS",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ChooseHouse()));
                },
              ),
              const SizedBox(height: 30),
              BigButton(
                icon: Icons.shield_moon,
                text: "SPELLS",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ListSpells()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
