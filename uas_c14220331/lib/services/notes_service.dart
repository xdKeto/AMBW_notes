import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class NotesService {
  static const String _notesKey = 'notes';

  Future<void> saveNote(Note note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_notesKey) ?? [];

    notes.add(jsonEncode(note.toJson()));

    await prefs.setStringList(_notesKey, notes);
  }

  Future<List<Note>> getNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_notesKey) ?? [];

    final List<Note> loadedNotes = [];
    for (String noteJson in notes) {
      try {
        final Map<String, dynamic> data = jsonDecode(noteJson);
        loadedNotes.add(Note.fromJson(data));
      } catch (e) {
        continue;
      }
    }
    return loadedNotes;
  }

  Future<void> deleteNote(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_notesKey) ?? [];

    notes.removeAt(index);

    await prefs.setStringList(_notesKey, notes);
  }

  Future<void> editNote(int index, Note note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_notesKey) ?? [];

    notes[index] = jsonEncode(note.toJson());

    await prefs.setStringList(_notesKey, notes);
  }
}
