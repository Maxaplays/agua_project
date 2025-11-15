import 'package:agua_project/ui/ui_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddActivity extends StatefulWidget {
  static const routeName = '/add-activity';
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final formKey = GlobalKey<FormState>();
  TextStyle textoInputs = TextStyle(color: Colors.black);
  TextEditingController time = TextEditingController();
  String? selectedItem;
  List<String> items = [
    'Take a shower',
    'Wash the dishes',
    'Bathe the dog',
    'Brush your teeth',
  ];
  String? itemSelected;

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
                    DropdownButtonFormField<String>(
                      decoration: inputsStyle("Activity"),
                      initialValue: itemSelected,
                      items: items.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
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
                  ],
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Theme.of(context).primaryColor,
                    disabledForegroundColor: Colors.red,
                  ),
                  onPressed: () => {
                    if (formKey.currentState!.validate())
                      {
                        print("Item selected: $itemSelected"),
                        print("time: " + time.text),
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
}
