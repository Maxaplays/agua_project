import 'dart:async';

import 'package:agua_project/models/water_item.dart';
import 'package:agua_project/services/water_items_service.dart';
import 'package:flutter/material.dart';
import 'package:agua_project/theme/colors.dart';

class Home extends StatefulWidget {
  final WaterItemsService service;
  const Home({required this.service, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double max = 150;
  double total = 0;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = widget.service.waterItems$.listen((value) {
      calculateAverage(value);
    });
  }

  void calculateAverage(List<WaterItem> items) {
    double aux = 0;
    items.forEach((item) => aux = aux + item.value);
    setState(() {
      total = aux;
      print("Avg=====>" + total.toString());
    });
  }

  void deleteItem(int index, List<WaterItem> items) {
    items.removeAt(index);
    widget.service.setState(items);
  }

  // String getStateText(){
  //   double per = total/max;
  //   switch (per) {
  //     case (per >1):

  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(minHeight: 250),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          double percent = total / max;
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              percent > 1 ? Colors.red : AppColors.primaryMain,
                              percent > 1 ? Colors.red : AppColors.primaryMain,
                              percent > 1 ? Colors.red : AppColors.primaryGrey,
                              percent > 1 ? Colors.red : AppColors.primaryGrey,
                            ],
                            stops: [0.0, percent, percent, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Icon(
                          Icons.water_drop_outlined,
                          size: 250,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        total.round().toString() + " L",
                        style: TextStyle(
                          color: (total / max) > 1
                              ? Colors.red
                              : AppColors.primaryMain,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "You exceeded your daily water intake >:v",
                      style: TextStyle(
                        color: (total / max) > 1
                            ? Colors.red
                            : AppColors.primaryMain,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(50),
              child: Card(
                child: StreamBuilder(
                  stream: widget.service.waterItems$,
                  builder: (context, stream) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: (stream.data ?? []).length,
                          itemBuilder: (context, position) => Column(
                            children: <Widget>[
                              Card(
                                elevation: 0,
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
                                            Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: stream
                                                        .data![position]
                                                        .color
                                                        .withAlpha(50),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    (stream.data ??
                                                            [])[position]
                                                        .icon,
                                                    color:
                                                        AppColors.textPrimary,
                                                    size: 30,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      stream
                                                          .data![position]
                                                          .name,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .textPrimary,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${(stream.data ?? [])[position].value} L",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .textPrimary,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                deleteItem(
                                                  position,
                                                  stream.data ?? [],
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    color:
                                                        AppColors.textPrimary,
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
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
