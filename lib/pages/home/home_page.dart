import 'package:flutter/material.dart';
import 'package:agua_project/theme/colors.dart';
import 'package:agua_project/models/water_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<WaterItem> waterItems = [
    WaterItem(
      name: "Shower",
      icon: Icons.shower,
      value: 150,
      color: Colors.lightBlue,
    ),
    WaterItem(
      name: "Clean Hands",
      icon: Icons.clean_hands_rounded,
      value: 50,
      color: Colors.blue.shade400,
    ),
    WaterItem(
      name: "Drink Water",
      icon: Icons.local_drink_rounded,
      value: 60,
      color: Colors.blue.shade700,
    ),
    WaterItem(
      name: "Wash Dishes",
      icon: Icons.waves_sharp,
      value: 200,
      color: Colors.blue.shade300,
    ),
    WaterItem(
      name: "Bathroom",
      icon: Icons.wc_sharp,
      value: 110,
      color: Colors.blue.shade200,
    ),
    WaterItem(
      name: "Wash Clothes",
      icon: Icons.local_laundry_service_rounded,
      value: 300,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      double percent = 0.2; // Value for gradient

                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryGrey,
                          AppColors.primaryGrey,
                          AppColors.primaryMain,
                          AppColors.primaryMain,
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
                    "150 L",
                    style: TextStyle(
                      color: AppColors.primaryMain,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(50),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: waterItems.length,
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
                                                color: waterItems[position]
                                                    .color
                                                    .withAlpha(50),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                waterItems[position].icon,
                                                color: AppColors.textPrimary,
                                                size: 30,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  waterItems[position].name,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.textPrimary,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "${waterItems[position].value} L",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.textPrimary,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            print(waterItems[position].name);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_outline_outlined,
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryMain,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.20,
                ),
                child: Center(
                  child: Text(
                    "Total consumed: 600L",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
