import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/search/bloc.dart';
import '../../../../models/search_document/image_document/info.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _queryFocusNode = FocusNode();
  bool _searched = false;

  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _initializeSearchBloc();

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        context.read<SearchImageBloc>().add(LoadMore());
      }
    });
  }

  _initializeSearchBloc() {
    context.read<SearchImageBloc>().add(SearchInitialize());
  }

  _search(String query) {
    context.read<SearchImageBloc>().add(Search(query: query));
  }

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
              _initializeSearchBloc();
            }
            _searched = false;
            setState(() {});
          },
          onFieldSubmitted: (value) {
            _search(value);
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
      body: BlocBuilder<SearchImageBloc, SearchState>(
        builder: (context, state) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.documents.length,
            itemBuilder: (context, index) {
              final document = state.documents[index] as ImageDocumentInfo;
              return CachedNetworkImage(imageUrl: document.imageUrl);
            },
          );
        },
      ),
    );
  }
}
