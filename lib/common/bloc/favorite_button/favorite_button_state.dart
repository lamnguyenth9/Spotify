abstract class FavoriteButtonState{}


class FavoriteButtonInit extends FavoriteButtonState{}

class FavoriteButtonUpdated extends FavoriteButtonState{
  final bool isFavorite;

  FavoriteButtonUpdated({required this.isFavorite});
}