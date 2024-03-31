import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/search_history/bloc.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget(
      {super.key,
      required this.onDelete,
      required this.onClear,
      required this.onPress});

  final Function(String) onDelete;
  final VoidCallback onClear;
  final Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
      builder: (context, state) {
        if (state is LoadedSearchHistory) {
          if (state.history.isEmpty) {
            return const Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "검색 기록이 없습니다.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            );
          }
          return Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "검색 기록:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onClear,
                    child: Text(
                      "모두 삭제",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onPress(state.history[index]),
                      child: Row(
                        children: [
                          Text(
                            state.history[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          IconButton(
                            constraints: const BoxConstraints(),
                            style: IconButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => onDelete(state.history[index]),
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
