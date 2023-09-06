import 'package:equatable/equatable.dart';

enum GameState { empty, circle, cross }

enum WinCombination { diagonal, nonDiagonal, column, row, none }

class InfoBlocState extends Equatable {
  @override
  List<Object?> get props => [
        gridBoxesStates,
        turn,
        row,
        player,
        column,
        playedBoxes,
        hasCombinationMatched,
        combination,
      ];

  final WinCombination combination;
  final GameState player;
  final List<GameState> gridBoxesStates;
  final int turn;
  final int row;
  final int column;
  final List<int> playedBoxes;
  final bool hasCombinationMatched;

  const InfoBlocState({
    this.row = 0,
    this.player = GameState.empty,
    this.column = 0,
    this.gridBoxesStates = const [],
    this.combination = WinCombination.none,
    this.turn = 0,
    this.playedBoxes = const [],
    this.hasCombinationMatched = false,
  });

  InfoBlocState copyWith(
      {List<GameState>? gridBoxesStates,
      WinCombination? combination,
      int? row,
      int? column,
      GameState? player,
      int? turn,
      List<int>? playedBoxes,
      bool? hasCombinationMatched}) {
    return InfoBlocState(
        gridBoxesStates: gridBoxesStates ?? this.gridBoxesStates,
        turn: turn ?? this.turn,
        row: row ?? this.row,
        player: player ?? this.player,
        column: column ?? this.column,
        combination: combination ?? this.combination,
        playedBoxes: playedBoxes ?? this.playedBoxes,
        hasCombinationMatched:
            hasCombinationMatched ?? this.hasCombinationMatched);
  }
}
