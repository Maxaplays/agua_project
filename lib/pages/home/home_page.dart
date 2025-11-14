import 'package:flutter/material.dart';
import 'package:agua_project/style/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> items = [
    'Ducha',
    'Regar plantas',
    'Lavar platos',
    'Ducha',
    'Regar plantas',
    'Lavar platos',
    'Ducha',
    'Regar plantas',
    'Lavar platos',
    'Ducha',
    'Regar plantas',
    'Lavar platos',
    'Ducha',
    'Regar plantas',
    'Lavar platos',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: const Text("Yaku app")),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: const Color.fromARGB(255, 27, 43, 49),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(
                    value: 0.7,
                    strokeWidth: 5,
                    color: AppColors.primaryMain,
                    backgroundColor: Colors.blueGrey,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(50),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, position) => Column(
                      children: <Widget>[
                        Card(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10,
                            left: 5,
                            right: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        items[position] +
                                            " " +
                                            position.toString(),
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("Tap");
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Agregar",
                                              style: TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: AppColors.textPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    itemCount: items.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
