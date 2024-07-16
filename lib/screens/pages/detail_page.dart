import 'package:bhagavat_gita_departure/provider/like_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF5A5A5A)
            : const Color(0xff85C1E9),
        title: const Text("Detail Page"),
        actions: [
          Consumer<LikeProvider>(
            builder: (context, likeProvider, child) {
              bool isLiked = likeProvider.isLiked(data);
              return Padding(
                padding: EdgeInsets.all(width / 28),
                child: IconButton(
                  onPressed: () {
                    likeProvider.toggleLike(e: data);
                  },
                  icon: const Icon(Icons.favorite),
                  color: (isLiked) ? Colors.red : Colors.blueGrey,
                ),
              );
            },
          ),
        ],
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
                : [const Color(0xff85C1E9), const Color(0xff005280)],
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height,
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: height / 18),
                height: height / 2.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "${data['image']}",
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(height / 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ch No: ${data['title'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width / 24,
                        ),
                      ),
                      Text(
                        "Ch No: ${data['chapter_number']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: height / 2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          const Color(0xFF5A5A5A),
                          const Color.fromARGB(255, 101, 101, 102)
                        ] // Dark theme colors
                      : [const Color(0xff85C1E9), const Color(0xff005280)],
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: height / 160,
                    width: width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(height: height / 80),
                  Center(
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width / 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.justify,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      "${data['description'][Provider.of<LanguageProvider>(context).language.toLowerCase()]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width / 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
