import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'characters_dependency_providers.dart';
import 'characters_exception.dart';

final class RmSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final characterSearchQueryProvider = NotifierProvider<RmSearchQueryNotifier, String>(
  RmSearchQueryNotifier.new,
);

final class RmCharacterListState {
  const RmCharacterListState({
    required this.characters,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<RmCharacterEntity> characters;
  final bool hasMore;
  final bool isLoadingMore;

  RmCharacterListState copyWith({
    List<RmCharacterEntity>? characters,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return RmCharacterListState(
      characters: characters ?? this.characters,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class RmCharactersNotifier extends AsyncNotifier<RmCharacterListState> {
  int _page = 1;

  Future<RmCharactersPage> _fetchPage(String name, int pageNumber) async {
    final result = await ref
        .read(getCharactersUseCaseProvider)
        .call(name: name.isEmpty ? null : name, page: pageNumber);

    return switch (result) {
      RmSuccess(value: final page) => page,
      RmFailure(message: final message) => throw RmCharactersException(message),
    };
  }

  @override
  Future<RmCharacterListState> build() async {
    _page = 1;
    final name = ref.watch(characterSearchQueryProvider);
    final page = await _fetchPage(name, _page);
    return RmCharacterListState(characters: page.characters, hasMore: page.hasNext);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    final name = ref.read(characterSearchQueryProvider);
    try {
      final page = await _fetchPage(name, _page + 1);
      _page += 1;
      state = AsyncData(
        RmCharacterListState(
          characters: [...current.characters, ...page.characters],
          hasMore: page.hasNext,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}

final charactersNotifierProvider =
    AsyncNotifierProvider<RmCharactersNotifier, RmCharacterListState>(RmCharactersNotifier.new);

final characterDetailProvider = FutureProvider.family<RmCharacterEntity, int>((ref, id) async {
  final result = await ref.watch(getCharacterDetailUseCaseProvider).call(id);

  return switch (result) {
    RmSuccess(value: final character) => character,
    RmFailure(message: final message) => throw RmCharactersException(message),
  };
});
