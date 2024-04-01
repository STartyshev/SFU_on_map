class BuildingData {
  BuildingData(
      {required this.name,
      required this.index,
      required this.image,
      required this.similarNames,
      required this.wtfKey});

  final String name;
  final int index;
  final String image;
  final List<String> similarNames;
  dynamic wtfKey;
  final Map<String, String> notes = {};

  void addNote({ required String newNote, required String date }) {
    notes[date] = newNote;
  }

  void deleteNote({ required String note }) {
    notes.remove(note);
  }
}
