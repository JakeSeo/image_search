import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/search/bloc.dart';
import '../../../../blocs/search_history/bloc.dart';
import '../../../../models/search_document/image_document/info.dart';
import '../components/search_history_widget.dart';

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

  Timer? _debounce;

  @override
  initState() {
    super.initState();
    context.read<SearchHistoryBloc>().add(SearchHistoryInitialize());
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
    if (query.isEmpty) return;
    context.read<SearchImageBloc>().add(Search(query: query));
    context.read<SearchHistoryBloc>().add(AddQuery(query: query));
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
                      context.read<SearchHistoryBloc>().add(
                            LoadSearchHistory(),
                          );
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
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 200), () {
              context.read<SearchHistoryBloc>().add(
                    LoadSearchHistory(
                      query: _queryController.text,
                    ),
                  );
            });
            _searched = false;
            setState(() {});
          },
          onFieldSubmitted: (value) {
            if (value.isEmpty) return;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Builder(builder: (context) {
          if (!_searched) {
            return SearchHistoryWidget(
              onPress: (query) {
                FocusManager.instance.primaryFocus?.unfocus();
                _queryController.text = query;
                _search(query);
                _searched = true;
                setState(() {});
              },
              onDelete: (query) => context
                  .read<SearchHistoryBloc>()
                  .add(DeleteQuery(query: query)),
              onClear: () =>
                  context.read<SearchHistoryBloc>().add(ClearSearchHistory()),
            );
          }
          return BlocBuilder<SearchImageBloc, SearchState>(
            builder: (context, state) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.documents.length,
                itemBuilder: (context, index) {
                  final document = state.documents[index] as ImageDocumentInfo;
                  return GestureDetector(
                    child: AspectRatio(
                      aspectRatio: document.width / document.height,
                      child: CachedNetworkImage(
                        imageUrl: document.imageUrl,
                        errorWidget: (context, url, error) {
                          return Container(color: Colors.grey.shade300);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
