import 'package:flutter/material.dart';
import 'package:search/Controllers/APIControllers.dart';

import '../Models/FirstCategory.dart';

class EpisodeScreen extends StatefulWidget {
  String content;

  EpisodeScreen({required this.content});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  FirstCat? data;

  @override
  void initState() {
    print('content : '+ widget.content);
    print('hello from there');
    APIControllers.apiControllers.getAllEpisodes(widget.content,1).then((value) {
      setState(() {
        data = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
        : Container(
          child: GridView.builder(
          itemCount: data?.data?.length??0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            Data model = data!.data![index];
            return InkWell(
      onTap: () async {
          // widget.onIdSelected(
          //   allEpisoedData?[index].id,
          //   allEpisoedData?[index].img,
          // );
      },
      child:  Container(
                    margin: const EdgeInsets.all(5),
                    height: 15,
                    width: 50,
                    child: Column(
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(8)),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        model.img ?? '',
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          bottom: 10,
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.black.withOpacity(0.9),
                                                spreadRadius: 15,
                                                blurRadius: 25,
                                                offset: const Offset(0, 15),
                                              ),
                                            ]),
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    model.programName ?? '',
                                                    // '${widget.programInfoEntity?.data?.presenterProgram}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 5,
                            right: 10,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              model.name ?? '',
                              // '${allEpisoedData?[index].name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ,
    );
      }),
        );
  }
}
