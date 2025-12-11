import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_c14220331/models/note_model.dart';
import 'package:uas_c14220331/services/notes_service.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({required this.index, required this.note, super.key});

  final int index;
  final Note note;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late final TextEditingController judulController;
  late final TextEditingController isiController;
  final NotesService _notesService = NotesService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.note.judul);
    isiController = TextEditingController(text: widget.note.isi);
  }

  Future<void> _editNote() async {
    setState(() {
      _isLoading = true;
    });

    final note = Note(
      judul: judulController.text,
      isi: isiController.text,
      tanggal: DateTime.now().toString(),
    );

    await _notesService.editNote(widget.index, note);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    judulController.dispose();
    isiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit Note',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: judulController,
            decoration: InputDecoration(
              labelText: 'Judul',
              hintText: 'Masukkan Judul',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: isiController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Isi',
              hintText: 'Masukkan Isi',
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _editNote,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Save',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
