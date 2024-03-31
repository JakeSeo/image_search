import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _queryFocusNode = FocusNode();
  bool _searched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _queryController,
          focusNode: _queryFocusNode,
          decoration: InputDecoration(
            hintText: "검색어를 입력해주세요.",
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: _queryController.text.isEmpty
                ? null
                : GestureDetector(
                    onTap: () {
                      _queryController.text = "";
                      _searched = false;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
          ),
          onChanged: (value) {
            if (_searched) {
              // _initializeSearchBlocs();
            }
            _searched = false;
            setState(() {});
          },
          onFieldSubmitted: (value) {
            // _search(value);

            _searched = true;
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
