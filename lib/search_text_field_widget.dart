import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projects/connection_between_widgets.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projects/data.dart';

import 'building_page_widget.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<StatefulWidget> createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  var textFieldController = TextEditingController();
  //String? errorMessage;

  @override
  Widget build(BuildContext context) {
    textFieldController.text =
    Provider.of<AppData>(context, listen: false).searchAndErrorText[0]!;
    return Padding(
      padding: const EdgeInsets.all(16),
        child: TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 220, 225, 231),
            error: Provider.of<AppData>(context, listen: false).searchAndErrorText[1] != null ?
            Text(
                Provider.of<AppData>(context, listen: false).searchAndErrorText[1]!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5
              ),
              maxLines: 2
            ) : null,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  Provider.of<AppData>(context, listen: false).changeSearchText(newSearchText: '');
                  Provider.of<AppData>(context, listen: false).changeErrorText(newErrorText: null);
                });
              },
            ),
            hintText: 'Поиск',
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  width: 10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            ),
            contentPadding: const EdgeInsets.all(0),
          ),
          onSubmitted: (String searchText) {
            Provider.of<AppData>(context, listen: false).changeSearchText(newSearchText: searchText);
            bool found = false;
            if (searchText.isNotEmpty) {
              searching(List<BuildingItem> bList, String searchText) {
                for(int i = 0; i < bList.length; i++) {
                  if (bList[i].similarWords.contains(searchText.toLowerCase())) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BuildingPage(building: bList.firstWhere(
                                    (element) => element.id == i)
                            )
                    ));
                    return true;
                  }
                }
              }
              List<BuildingItem> bufStudy = Provider.of<AppData>(context, listen: false).studyBuildings;
              List<BuildingItem> bufSport = Provider.of<AppData>(context, listen: false).sportBuildings;
              found = searching(bufStudy, searchText) ?? false;
              if (found) {
                setState(() {
                  Provider.of<AppData>(context, listen: false).changeErrorText(newErrorText: null);
                  Provider.of<AppData>(context, listen: false).changeSearchText(newSearchText: '');
                });
                return;
              }
              found = searching(bufSport, searchText) ?? false;
              if (found) {
                setState(() {
                  Provider.of<AppData>(context, listen: false).changeErrorText(newErrorText: null);
                  Provider.of<AppData>(context, listen: false).changeSearchText(newSearchText: '');
                });
                return;
              }
              setState(() {
                Provider.of<AppData>(context, listen: false).changeErrorText(
                    newErrorText: 'Такого строения нет в списках. Попробуйте ввести по другому.');
              });
            }
          },
        ),
    );
  }
}
