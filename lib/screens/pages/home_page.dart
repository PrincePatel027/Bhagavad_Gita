import 'dart:convert';
import 'package:bhagavat_gita_departure/provider/language_provider.dart';
import 'package:bhagavat_gita_departure/provider/like_provider.dart';
import 'package:bhagavat_gita_departure/provider/theme_provider.dart';
import 'package:bhagavat_gita_departure/screens/componenets/custom_list_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String>? jsonData;

  loadData() {
    jsonData = rootBundle.loadString("assets/json/bhagavad_gita.json");
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<String> languages = [
    "English",
    "Hindi",
    "Gujrati",
  ];

  List<String> themeList = [
    "Light",
    "Dark",
    "System",
  ];

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF5A5A5A)
            : const Color(0xff85C1E9),
        centerTitle: false,
        title: const Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              margin: EdgeInsetsDirectional.all(0),
              padding: EdgeInsetsDirectional.all(0),
              decoration: BoxDecoration(
                  //
                  ),
              child: UserAccountsDrawerHeader(
                otherAccountsPictures: [
                  CircleAvatar(),
                ],
                accountName: Text("Prince Patel"),
                accountEmail: Text("prince027@gmail.com"),
              ),
            ),
            SizedBox(height: height / 36),
            Center(
              child: Text(
                "Settings",
                style: TextStyle(fontSize: width / 24),
              ),
            ),
            SizedBox(height: height / 36),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Languages",
                style: TextStyle(fontSize: width / 24),
              ),
            ),
            SizedBox(height: height / 70),
            Column(
              children: [
                ...List.generate(
                  languages.length,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      height: height / 18,
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(languages[index]),
                          Radio(
                            value: languages[index],
                            groupValue:
                                Provider.of<LanguageProvider>(context).language,
                            onChanged: (value) {
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
                                  .changeLanguage(lnga: value as String);
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Change Theme",
                style: TextStyle(fontSize: width / 24),
              ),
            ),
            SizedBox(height: height / 70),
            Row(
              children: themeList.map(
                (e) {
                  return RadioMenuButton(
                    value: e,
                    groupValue:
                        Provider.of<ThemeProvider>(context).currentTheme,
                    onChanged: (value) {
                      //
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme(theme: e);
                    },
                    child: Text(e),
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    const Color(0xFF5A5A5A),
                    const Color.fromARGB(255, 101, 101, 102)
                  ] // Dark theme colors
                : [
                    const Color(0xff85C1E9),
                    const Color(0xff005280),
                  ],
          ),
        ),
        child: FutureBuilder(
          future: jsonData,
          builder: (_, asyncSS) {
            if (asyncSS.hasError) {
              return Center(
                child: Text("ERROR: ${asyncSS.error}"),
              );
            } else if (asyncSS.hasData) {
              List decodedData = jsonDecode(asyncSS.data!);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height / 70),
                    // Carousel Slider
                    CarouselSlider(
                      carouselController: carouselController,
                      items: decodedData.map(
                        (e) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(
                                  e['image'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        animateToClosest: true,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2 / 1,
                      ),
                    ),
                    SizedBox(height: height / 70),
                    (Provider.of<LikeProvider>(context).likedList.isEmpty)
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Liked Chapters",
                                  style: TextStyle(fontSize: width / 18),
                                ),
                              ),
                              // SizedBox(height: height / 70),
                              Consumer<LikeProvider>(
                                builder: (context, likeProvider, child) {
                                  return Column(
                                    children: [
                                      ...likeProvider.likedList.map(
                                        (e) {
                                          bool isLiked =
                                              likeProvider.isLiked(e);
                                          return CustomListTile(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                'detailPage',
                                                arguments: e,
                                              );
                                            },
                                            trailing: IconButton(
                                              onPressed: () {
                                                likeProvider.toggleLike(e: e);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: (isLiked)
                                                    ? Colors.red
                                                    : Colors.blueGrey,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage:
                                                  AssetImage(e['image']),
                                            ),
                                            title:
                                                "${e['title'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                                            subtitle:
                                                "${e['description'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                    SizedBox(height: height / 70),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Chapters",
                        style: TextStyle(fontSize: width / 18),
                      ),
                    ),
                    SizedBox(height: height / 70),
                    Column(
                      children: [
                        ...decodedData.map(
                          (e) {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    'detailPage',
                                    arguments: e,
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black26
                                          : Colors.greenAccent.withOpacity(0.4),
                                      alignment: Alignment.center,
                                      padding: EdgeInsetsDirectional.all(
                                          height / 70),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            "Ch: ${e['chapter_number']} | ${e['title'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 26,
                                            ),
                                          ),
                                          Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            "${e['description'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                                            style: TextStyle(
                                              fontSize: width / 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer<LikeProvider>(
                                      builder: (context, likeProvider, child) {
                                        final isLiked = likeProvider.isLiked(e);
                                        return IconButton(
                                          onPressed: () {
                                            likeProvider.toggleLike(e: e);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 20,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.blueGrey,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          // Flexible(
          //   flex: 2,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: 2,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: const CircleAvatar(),
          //         title: const Text("Liked Chapter Name"),
          //         subtitle: const Text("description"),
          //         trailing: IconButton.outlined(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.more_horiz,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // SizedBox(height: height / 70),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Text(
          //     "Chapters",
          //     style: TextStyle(fontSize: width / 18),
          //   ),
          // ),
          // SizedBox(height: height / 70),
          // Flexible(
          //   flex: 4,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10),
          //     child: Flexible(
          //       child: GridView.builder(
          //         shrinkWrap: true,
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //         ),
          //         itemCount: 4,
          //         itemBuilder: (_, index) {
          //           return Container(
          //             margin: const EdgeInsets.only(bottom: 10, right: 10),
          //             color: Colors.black12,
          //             alignment: Alignment.center,
          //             child: const Text("Grid Item"),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          //       ],
          //     ),
          //   ),
        ),
      ),
    );
  }
}
