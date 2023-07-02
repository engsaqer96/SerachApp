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
  var _search_itmes = ['الحلقات', 'البرامج', 'تقارير ومقابلات'];
  var _selectedIndex = 0, listIndex;
  var form_key = GlobalKey<FormState>();
  bool show_cancel = false, search_flag = false;
  String search_txt = '';
  var userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (value) {
                        // if(value.length>0)
                        //   form_key.currentState?.reset();
                        if (show_cancel != value.isNotEmpty) {

                          setState(() {
                            show_cancel = !show_cancel;
                          });
                        }
                      },
                      maxLines: 1,
                      minLines: 1,
                      controller: userController,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          ),
                        ),
                        icon: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                            icon:
                                Icon(Icons.search, color: AppColors.colodBlue),
                            onPressed: () {
                              // Perform search action
                              if (form_key.currentState?.validate() ?? false)
                                setState(() {
                                  show_cancel = false;
                                  search_flag = true;
                                });
                            },
                          ),
                        ),
                        contentPadding: EdgeInsets.only(right: 10),
                        hintText:
                            'ابحث في الحلقات او البرامج او التقارير والمقابلات ',
                        hintStyle:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                        fillColor: AppColors.colodBlue,
                        filled: true,
                        suffixIcon: show_cancel
                            ? IconButton(
                                icon: Icon(Icons.cancel,
                                    color: AppColors.mainColor),
                                onPressed: () {
                                  // Clear the text field
                                  userController.clear();
                                  setState(() {
                                    show_cancel = false;
                                  });
                                },
                              )
                            : null,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 50,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _search_itmes.length,
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
                            width: (MediaQuery.of(context).size.width /
                                    _search_itmes.length) -
                                5,
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
              search_flag
                  ? Expanded(
                      child: _selectedIndex == 0
                          ? EpisodeScreen(content: userController.text)
                          : _selectedIndex == 1
                              ? ProgrammesScreen(content: userController.text)
                              : ReportsScreen(content: userController.text))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
