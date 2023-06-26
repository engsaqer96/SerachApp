import 'package:flutter/material.dart';
import 'package:search/Controllers/APIControllers.dart';
import 'package:search/Models/SecondCat.dart';
class ProgrammesScreen extends StatefulWidget { 
  String content;
  ProgrammesScreen({required this.content});

  @override
  State<ProgrammesScreen> createState() => _ProgrammesScreenState();
}

class _ProgrammesScreenState extends State<ProgrammesScreen> {
  SecondCat? data;
  @override
  void initState() {
    // TODO: implement initState
    
    APIControllers.apiControllers.getProgrammes(widget.content,2).then((value){
      setState(() {
        data=value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return data==null?Container(
      child: Center(child: CircularProgressIndicator(),),
    ):Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ), itemCount: data?.data?.length??0,
        itemBuilder:
        (context, index) {
          Data model=data!.data![index];
      return Padding(
        padding: EdgeInsets.only(
          top: 5,
          right: 5,
          left: 5,
          bottom: 5,
        ),
        child: InkWell(
          onTap: () {
            //do something
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15.0,
                    spreadRadius: 0,
                    offset: const Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.network(
                model.img??"",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      );
    }
    ),);
  }
}
