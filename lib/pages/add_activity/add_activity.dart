import 'package:agua_project/models/activity.dart';
import 'package:agua_project/models/new_item.dart';
import 'package:agua_project/models/water_item.dart';
import 'package:agua_project/pages/add_type_activity/add_type_activity.dart';
import 'package:agua_project/services/water_items_service.dart';
import 'package:agua_project/ui/ui_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddActivity extends StatefulWidget {
  static const routeName = '/add-activity';
  final WaterItemsService service;
  const AddActivity({required this.service, super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final formKey = GlobalKey<FormState>();
  TextStyle textoInputs = TextStyle(color: Colors.black);
  TextEditingController time = TextEditingController();

  String? selectedItem;
  List<Activity> items = [
    Activity(name: 'Take a shower', consumption: 5),
    Activity(name: 'Wash the dishes', consumption: 3),
    Activity(name: 'Bathe the dog', consumption: 7),
    Activity(name: 'Brush your teeth', consumption: 1),
  ];
  Activity? itemSelected;
  IconData? iconSelected;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter data in the field";
    }
    if (value.contains(" ")) {
      return "Spaces are not allowed.";
    }
    return null;
  }

  InputDecoration inputsStyle(String text) {
    return InputDecoration(
      labelText: text,
      hintText: text,
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      counterStyle: TextStyle(color: Theme.of(context).primaryColor),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      errorStyle: TextStyle(color: Colors.red),
    );
  }

  _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.allMaterial],
      ),
    );
    setState(() {
      if (icon != null) {
        iconSelected = icon.data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Add Item"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<Activity>(
                            decoration: inputsStyle("Activity"),
                            initialValue: itemSelected,
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (valor) {
                              setState(() {
                                itemSelected = valor;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Select an item";
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddTypeActivity(updateList: addNewActivity),
                              ),
                            ),
                          },
                          icon: Icon(Icons.add_circle_outline_sharp),
                        ),
                      ],
                    ),

                    TextFormField(
                      controller: time,
                      cursorColor: Theme.of(context).primaryColor,
                      style: textoInputs,
                      decoration: inputsStyle("Minutes"),
                      maxLength: 5,
                      validator: validateInput,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    GestureDetector(
                      onTap: () => {_pickIcon()},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Icon",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Center(
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: iconSelected != null
                                  ? Icon(iconSelected)
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => {
                    if (formKey.currentState!.validate() &&
                        iconSelected != null)
                      {
                        print("Item selected: $itemSelected"),
                        print("time: " + time.text),
                        modifyList(
                          NewItem(
                            activity: itemSelected!,
                            time: int.parse(time.text),
                            icon: iconSelected!,
                          ),
                        ),
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => UI()),
                              ),
                      },
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewActivity(Activity newActivity) {
    setState(() {
      items.add(newActivity);
    });
  }

  void modifyList(NewItem item) {
    List<WaterItem> tempList = List<WaterItem>.from(widget.service.getState());
    print(tempList);
    List<WaterItem> findItem = tempList
        .where((i) => i.name == item.activity.name)
        .toList();
    if (findItem.isEmpty) {
      tempList.add(
        WaterItem(
          name: item.activity.name,
          count: 1,
          icon: item.icon,
          value: (item.activity.consumption * (item.time / 60)).toInt(),
        ),
      );
    } else {
      int index = tempList.indexWhere((p) => p.name == findItem[0].name);
      WaterItem aux = tempList[index];
      aux.count = aux.count + 1;
      aux.value =
          aux.value + (item.activity.consumption * (item.time / 60)).toInt();
      tempList[index] = aux;
    }
    widget.service.setState(tempList);
    print(widget.service.getState());
  }
}
