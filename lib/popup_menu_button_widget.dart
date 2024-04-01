import 'package:flutter/material.dart';
import 'package:flutter_projects/connection_between_widgets.dart';
import 'package:provider/provider.dart';

class PopupMenuButtonMoreActions extends StatelessWidget {
  const PopupMenuButtonMoreActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65), shape: BoxShape.circle),
        child: PopupMenuButton(
          padding: const EdgeInsets.all(0),
            icon: Icon(Icons.more_vert_rounded,
                size: 32, color: Theme.of(context).primaryColor),
            onSelected: (int pageIndex) =>
                Provider.of<AppData>(context, listen: false)
                    .changeCurrentPage(newPageIndex: pageIndex),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  const PopupMenuItem(
                      value: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.settings),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Настройки')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider()
                        ],
                      )),
                  const PopupMenuItem(
                      value: 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.delete_outline),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Скрытое')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider()
                        ],
                      )),
                  const PopupMenuItem(
                    //padding: EdgeInsets.all(0),
                    value: 5,
                    child: Column(children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(
                            width: 8,
                          ),
                          Text('О приложении')
                        ],
                      ),
                      //Divider(color: Colors.transparent,)
                    ]),
                  ),
                ]));
  }
}
