import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/pages/new_or_edit_note_page.dart';
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';

import '../widgets/note_fab.dart';
import '../widgets/note_grid.dart';
import '../widgets/notes_list.dart';
import '../widgets/search_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> dropdownOptions = ['Date modified', 'Date created'];

  late String dropdownValue = dropdownOptions.first;

  bool isDescending = true;

  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Notes'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewOrEditNotePage()),
          );
        },
      ),
      body: Column(
        children: [
          const SearchField(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                NoteIconButton(
                  icon: isDescending
                      ? FontAwesomeIcons.arrowDown
                      : FontAwesomeIcons.arrowUp,
                      size: 18,
                  onPressed: () {
                    setState(() {
                      isDescending = !isDescending;
                    });
                  },
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: FaIcon(
                      FontAwesomeIcons.arrowDownWideShort,
                      size: 18,
                      color: gray700,
                    ),
                  ),
                  underline: const SizedBox.shrink(),
                  borderRadius: BorderRadius.circular(16),
                  isDense: true,
                  items: dropdownOptions
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Text(e),
                              if (e == dropdownValue) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.check),
                              ],
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  selectedItemBuilder: (context) =>
                      dropdownOptions.map((e) => Text(e)).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
                const Spacer(),
                NoteIconButton(
                  icon: isGrid
                      ? FontAwesomeIcons.tableCellsLarge
                      : FontAwesomeIcons.bars,
                      size: 18,
                  onPressed: () {
                    setState(() {
                      isGrid = !isGrid;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(child: isGrid ? const NotesGrid() : const NotesList()),
        ],
      ),
    );
  }
}
