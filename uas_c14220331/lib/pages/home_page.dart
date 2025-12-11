import 'package:flutter/material.dart';
import 'package:uas_c14220331/models/note_model.dart';
import 'package:uas_c14220331/services/notes_service.dart';
import 'package:uas_c14220331/widgets/add_notes.dart';
import 'package:uas_c14220331/widgets/edit_notes.dart';
import 'package:uas_c14220331/widgets/notes_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notes = [];
  final NotesService _notesService = NotesService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedNotes = await _notesService.getNotes();
      setState(() {
        notes = fetchedNotes.map((e) => e.toJson()).toList().reversed.toList();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UAS AMBW: Notes App'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              if (context.mounted) {
                Navigator.pushNamed(context, '/settings');
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : notes.isEmpty
          ? const Center(
              child: Text(
                'No Notes',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 80),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NotesCard(
                  note: notes[index],
                  onDelete: () async {
                    final actualIndex = notes.length - 1 - index;
                    await _notesService.deleteNote(actualIndex);
                    _loadNotes();
                  },
                  onEdit: () async {
                    final actualIndex = notes.length - 1 - index;
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return EditNotes(
                          index: actualIndex,
                          note: Note.fromJson(notes[index]),
                        );
                      },
                    );

                    if (result == true) {
                      _loadNotes();
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return const AddNotes();
            },
          );

          if (result == true) {
            _loadNotes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
