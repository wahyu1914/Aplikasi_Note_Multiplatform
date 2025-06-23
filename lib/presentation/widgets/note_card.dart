import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/presentation/controllers/new_note_controller.dart';
import 'package:project_note/presentation/controllers/notes_provider.dart';
import 'package:project_note/core/dialog/dialog.dart';
import 'package:project_note/core/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';

import '../../domain/entities/note.dart';

import '../pages/new_or_edit_note_page.dart';
import 'note_tag.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, required this.isInGrid, super.key});

  final Note note;
  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NewNoteController()..note = note,
              child: const NewOrEditNotePage(isNewNote: false),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.5),
              offset: const Offset(4, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ...[
              Text(
                note.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: gray900,
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    note.tags!.length,
                    (index) => NoteTag(label: note.tags![index]),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (note.content != null)
              isInGrid
                  ? Expanded(
                      child: Text(
                        note.content!,
                        style: const TextStyle(color: gray700),
                      ),
                    )
                  : Text(
                      note.content!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: gray700),
                    ),
            if (isInGrid) Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete =
                        await showConfirmationDialog(
                          context: context,
                          title: 'Do you want to delete this note?',
                        ) ??
                        false;

                    if (shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: gray500,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
