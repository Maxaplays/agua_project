import 'package:agua_project/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class AddTypeActivity extends StatefulWidget {
  final Function(Activity) updateList;
  const AddTypeActivity({required this.updateList, super.key});

  @override
  State<AddTypeActivity> createState() => _AddTypeActivityState();
}

class _AddTypeActivityState extends State<AddTypeActivity> {
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeConsumption = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextStyle textoInputs = TextStyle(color: Colors.black);
  TextEditingController name = TextEditingController();
  TextEditingController consumption = TextEditingController();
  bool disableConsumption = true;
  bool loading = false;

  Random random = Random();

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
  void initState() {
    super.initState();
    focusNodeName.addListener(onFocusChange);
  }

  @override
  void dispose() {
    focusNodeName.removeListener(onFocusChange);
    focusNodeName.dispose();
    focusNodeConsumption.dispose();
    super.dispose();
  }

  Future<void> getConsumption() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      consumption.text = random.nextInt(11).toString();
      loading = false;
    });
  }

  void onFocusChange() {
    if (!focusNodeName.hasFocus) {
      setState(() {
        loading = true;
        getConsumption();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Add Activity"),
      ),
      body: Stack(
        children: [
          SafeArea(
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
                        TextFormField(
                          focusNode: focusNodeName,
                          textInputAction: TextInputAction.next,
                          controller: name,
                          cursorColor: Theme.of(context).primaryColor,
                          style: textoInputs,
                          decoration: inputsStyle("Activity Name"),
                          maxLength: 20,
                          validator: validateInput,
                          keyboardType: TextInputType.text,
                          onChanged: (a) => {
                            setState(() {
                              disableConsumption = true;
                            }),
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                focusNode: focusNodeConsumption,
                                controller: consumption,
                                cursorColor: Theme.of(context).primaryColor,
                                style: textoInputs,
                                decoration: inputsStyle("Consumption per hour"),
                                maxLength: 5,
                                validator: validateInput,
                                keyboardType: TextInputType.number,
                                enabled: !disableConsumption,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () async => {
                                setState(() {
                                  disableConsumption = false;
                                }),
                                await Future.delayed(
                                  const Duration(milliseconds: 50),
                                ),
                                focusNodeConsumption.requestFocus(),
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => {
                        if (formKey.currentState!.validate())
                          {
                            widget.updateList(
                              Activity(
                                name: name.text,
                                consumption: int.parse(consumption.text),
                              ),
                            ),
                            Navigator.pop(context),
                          },
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          loading
              ? Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
