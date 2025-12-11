import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesCard extends StatefulWidget {
  final Map note;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const NotesCard({super.key, required this.note, this.onDelete, this.onEdit});

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.note['judul'],
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  height: 1.5,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onDelete,
                    child: const Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: widget.onEdit,
                    child: const Icon(Icons.edit, size: 18, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.note['isi'],
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.5,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 8),
              Text(
                widget.note['tanggal'].toString().substring(0, 16),
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
