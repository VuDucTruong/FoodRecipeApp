import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';

class LanguageListView extends StatefulWidget {
  const LanguageListView({super.key, required this.selectedLanguage});

  final MutableVariable<String> selectedLanguage;

  @override
  _LanguageListViewState createState() {
    return _LanguageListViewState();
  }
}

class _LanguageListViewState extends State<LanguageListView> {
  @override
  void initState() {
    super.initState();
  }

  List<String> languageList = Constant.languageList;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return RadioListTile(
            value: languageList[index],
            groupValue: widget.selectedLanguage.value,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  widget.selectedLanguage.value = value;
                });
              }
            },
            title: Text(languageList[index]),
          );
        },
        separatorBuilder: (context, index) {
          if (index != languageList.length - 1) {
            return const Divider(
              indent: 4,
              endIndent: 4,
            );
          } else {
            return Container();
          }
        },
        itemCount: languageList.length);
  }
}
