import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';

class InstuctionPage extends StatefulWidget {
  const InstuctionPage({super.key});

  @override
  State<InstuctionPage> createState() => _InstuctionPageState();
}

class _InstuctionPageState extends State<InstuctionPage> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  LanguageController languageController = Get.find();
  int selectedTile = -1;

  final List<Item> _data = generateItems(10);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCtrl>(
      init: ctrl,
      builder: (logic) {
        return Stack(
          children: [
            BackColor(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: BackArrow(),
              ),
              body: ListView.builder(
                key: Key(selectedTile.toString()),
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    key: Key(index.toString()),
                    initiallyExpanded: index == selectedTile,
                    title: Text(
                      _data[index].headerValue,
                      style: TextStyle(color: mainWhite),
                    ),
                    // subtitle: Text(
                    //   _data[index].subHeaderValue,
                    //   style: TextStyle(color: mainWhite),
                    // ),
                    leading: Icon(_data[index].iconData),
                    trailing: Icon(Icons.arrow_drop_down),
                    children:
                        _data[index].expandedValue.map<Widget>((String value) {
                      return ListTile(
                        title: Text(
                          value,
                          style: TextStyle(color: mainWhite),
                        ),
                      );
                    }).toList(),
                    onExpansionChanged: (bool expanded) {
                      if (expanded)
                        setState(() {
                          selectedTile = index;
                        });
                      else
                        setState(() {
                          selectedTile = -1;
                        });

                      // setState(() {
                      //   if (expanded) {
                      //     _expandedIndex = index;
                      //   } else if (_expandedIndex == index) {
                      //     _expandedIndex = -1;
                      //   }
                      // });
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  Item({
    required this.headerValue,
    required this.subHeaderValue,
    required this.iconData,
    required this.expandedValue,
  });

  String headerValue;
  String subHeaderValue;
  IconData iconData;
  List<String> expandedValue;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Tile $index',
      subHeaderValue: 'Subtitle $index',
      iconData: Icons.ac_unit,
      expandedValue:
          List<String>.generate(3, (int subIndex) => 'Item $subIndex'),
    );
  });
}
