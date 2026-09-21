import 'character_entity.dart';

final class RmCharactersPage {
  const RmCharactersPage({required this.characters, required this.hasNext});

  final List<RmCharacterEntity> characters;
  final bool hasNext;
}
