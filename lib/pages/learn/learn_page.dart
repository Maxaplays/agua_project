import 'package:agua_project/models/learn_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  List<LearItem> itemsToShow = [
    LearItem(
      title: "First Item",
      img:
          "https://cdn.shopify.com/s/files/1/1375/4603/articles/unnamed-1.png?v=1592969046",
      infoLink:
          "https://en.wikipedia.org/wiki/Daily_consumption_of_drinking_water",
    ),
    LearItem(
      title: "Second Item",
      img:
          "https://cdn.shopify.com/s/files/1/1375/4603/articles/unnamed-1.png?v=1592969046",
      infoLink:
          "https://en.wikipedia.org/wiki/Daily_consumption_of_drinking_water",
    ),
    LearItem(
      title: "Third Item",
      img:
          "https://cdn.shopify.com/s/files/1/1375/4603/articles/unnamed-1.png?v=1592969046",
      infoLink:
          "https://en.wikipedia.org/wiki/Daily_consumption_of_drinking_water",
    ),
    LearItem(
      title: "Fourth  Item",
      img:
          "https://cdn.shopify.com/s/files/1/1375/4603/articles/unnamed-1.png?v=1592969046",
      infoLink:
          "https://en.wikipedia.org/wiki/Daily_consumption_of_drinking_water",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return itemsToShow.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Center(
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight: 200,
                                    maxHeight: 250,
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  child: Image.network(
                                    itemsToShow[position].img,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (
                                          BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? Container(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.5),
                                                  child: Center(
                                                    child: CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(
                                                            Theme.of(
                                                              context,
                                                            ).primaryColor,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        },
                                  ),
                                ),
                              ),
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
                                        itemsToShow[position].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _launchUrl(
                                            itemsToShow[position].infoLink,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Learn More",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
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
                    itemCount: itemsToShow.length,
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
