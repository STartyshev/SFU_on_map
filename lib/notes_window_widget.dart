import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/connection_between_widgets.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:provider/provider.dart';

class NotesWindow extends StatefulWidget {
  const NotesWindow({super.key, required this.building});

  final BuildingItem building;

  @override
  State<StatefulWidget> createState() => NotesWindowState();
}

class NotesWindowState extends State<NotesWindow> {
  var textController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  bool editingText = false;
  String currentEditingDate = '';
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appData, child) {
      return GestureDetector(
        child: Column(
          children: [
            SizedBox(
              height: 224,
              child:
              ListView(
                reverse: true,
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  for (int i = widget.building.notes.keys.length - 1; i >= 0; i--)
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.black45,
                            builder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(24),
                              height: 200,
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      textFieldFocus.requestFocus();
                                      textController.text =
                                      widget.building.notes[widget
                                          .building.notes.keys
                                          .toList()[i]]!;
                                      editingText = true;
                                      currentEditingDate = widget
                                          .building.notes.keys
                                          .toList()[i];
                                      Navigator.of(context).pop();
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text('Редактировать',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: widget.building
                                          .notes[widget.building.notes.keys.toList()[i]]!));
                                      Navigator.of(context).pop();
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text('Копировать',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        Provider.of<AppData>(context,
                                            listen: false)
                                            .updateNotes(
                                            widget.building,
                                            widget.building.notes.keys
                                                .toList()[i],
                                            '');
                                      });
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.delete_forever_outlined,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text('Удалить',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Container(
                        margin:
                        i == 0 ?
                        const EdgeInsets.all(0) :
                        const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                            color:
                            Theme.of(context).primaryColor.withOpacity(0.3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.building
                                  .notes[widget.building.notes.keys.toList()[i]]!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  widget.building.notes.keys.toList()[i],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.3)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              focusNode: textFieldFocus,
              controller: textController,
              decoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 50),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                prefixIcon: const Icon(Icons.edit_note_outlined),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (editingText) {
                        Provider.of<AppData>(context, listen: false)
                            .updateNotes(widget.building, currentEditingDate,
                            textController.text);
                        currentEditingDate = '';
                        editingText = false;
                      } else {
                        DateTime t = DateTime.now();
                        Provider.of<AppData>(context, listen: false).updateNotes(
                            widget.building,
                            '${t.hour}:'
                                '${() {
                              int minute = t.minute;
                              return minute < 10 ? '0$minute' : minute;}.call()}:'
                                '${() {
                              int seconds = t.second;
                              return seconds < 10 ? '0$seconds' : seconds;}.call()} '
                                '${t.day}.'
                                '${() {
                              int month = t.month;
                              return month < 10 ? '0$month' : month;}.call()}.'
                                '${t.year}',
                            textController.text);
                      }
                      textController.clear();
                      textFieldFocus.unfocus();
                    });
                  },
                  icon: const Icon(Icons.send_outlined),
                ),
                contentPadding: const EdgeInsets.only(top:0),
                hintText: 'Оставить заметку',
                filled: true,
              ),
              onSubmitted: (text) {
                setState(() {
                  if (editingText) {
                    Provider.of<AppData>(context, listen: false).updateNotes(
                        widget.building,
                        currentEditingDate,
                        textController.text);
                    currentEditingDate = '';
                    editingText = false;
                  } else {
                    DateTime t = DateTime.now();
                    Provider.of<AppData>(context, listen: false).updateNotes(
                        widget.building,
                        '${t.hour}:'
                            '${() {
                          int minute = t.minute;
                          return minute < 10 ? '0$minute' : minute;}.call()}:'
                            '${() {
                          int seconds = t.second;
                          return seconds < 10 ? '0$seconds' : seconds;}.call()} '
                            '${t.day}.'
                            '${() {
                          int month = t.month;
                          return month < 10 ? '0$month' : month;}.call()}.'
                            '${t.year}',
                        textController.text);
                  }
                  textController.clear();
                  textFieldFocus.unfocus();
                });
              },
            ),],
        ),
        onTap: () {},
      );
    });
  }
}
