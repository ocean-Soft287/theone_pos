import 'package:flutter/material.dart';

class EditableInvoiceScreen extends StatefulWidget {
  const EditableInvoiceScreen({super.key});

  @override
  _EditableInvoiceScreenState createState() => _EditableInvoiceScreenState();
}

class _EditableInvoiceScreenState extends State<EditableInvoiceScreen> {
  Offset position1 = const Offset(100, 100);
  Offset position2 = const Offset(200, 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل الفاتورة')),
      body: Stack(
        children: [
          Positioned(
            left: position1.dx,
            top: position1.dy,
            child: Draggable(
              feedback: _buildDraggableItem('نص قابل للسحب'),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  position1 = details.offset;
                });
              },
              child: _buildDraggableItem('نص قابل للسحب'),
            ),
          ),
          Positioned(
            left: position2.dx,
            top: position2.dy,
            child: Draggable(
              feedback: _buildDraggableItem('نص آخر قابل للسحب'),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  position2 = details.offset;
                });
              },
              child: _buildDraggableItem('نص آخر قابل للسحب'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(String text) {
    return Material(
      color: Colors.blue,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
