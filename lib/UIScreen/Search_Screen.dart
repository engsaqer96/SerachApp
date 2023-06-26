import 'package:flutter/material.dart';
import 'package:search/Others/EpisodeScreen.dart';
import 'package:search/Others/ProgrammesScreen.dart';
import 'package:search/Others/ReportsScreen.dart';

import '../Others/AppColors.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  var _search_itmes=['الحلقات','البرامج','تقارير ومقابلات'];
  var _selectedIndex, listIndex;
  var form_key = GlobalKey<FormState>();
  bool show_cancel=false,search_flag=false;

  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.easeInOut,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: form_key,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      onChanged:(value) {
                        if(show_cancel!=value.isNotEmpty)
                             setState(() {
                               show_cancel=!show_cancel;
                             });
                      },
                      maxLines: 1,
                      minLines: 1,
                      controller: userController = TextEditingController(),
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.mainColor,
                      textAlign: TextAlign.right,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return value!.trim().isEmpty
                            ? 'لا يمكنك ترك هذا الحقل فارغ !'
                            : null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10),
                        hintText:
                            'ابحث في الحلقات او البرامج او التقارير والمقابلات ',
                       hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                         color: Colors.grey,
                         fontSize: 10,
                       ),
                        fillColor: AppColors.colodBlue,
                        filled: true,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform search action
                           setState(() {
                             search_flag=true;
                           });
                          },
                        ),
                        suffixIcon:show_cancel? IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            // Clear the text field
                            userController.clear();
                            setState(() {
                              show_cancel=false;
                            });
                          },
                        ):null,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 70,
                    child: ListView.builder(
                      itemCount:_search_itmes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              listIndex = index;
                              _selectedIndex = listIndex;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: _selectedIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.colodBlue,
                            ),
                            child: Center(
                              child: Text(
                                '${_search_itmes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: _selectedIndex == index
                                          ? AppColors.whiteColor
                                          : AppColors.secondaryColor,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // if (_selectedIndex == listIndex)
              //   Expanded(
              //     child: SizedBox(
              //       width: double.infinity,
              //       height: 100,
              //     ),
              //   ),
              search_flag?Expanded(child: ProgrammesScreen(content:'القدس')):Container()
            ],
          ),
        ),
      ),
    );
  }
}
