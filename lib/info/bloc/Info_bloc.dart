import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_tow/info/bloc/info_bloc_state.dart';

class InfoBloc extends Cubit<InfoBlocState> {
  InfoBloc() : super(const InfoBlocState());

  void initialize() {
    List<GameState> tempStates = [];
    for (int i = 0; i < 9; i++) {
      tempStates.add(GameState.empty);
    }
    emit(state.copyWith(gridBoxesStates: tempStates));
  }

  void clearBoard() {
    List<int> tempPlayedBoxes = List.from(state.playedBoxes);

    tempPlayedBoxes.clear();

    emit(
      state.copyWith(
        playedBoxes: tempPlayedBoxes,
        turn: 0,
        hasCombinationMatched: false,
        combination: WinCombination.none,
      ),
    );
    initialize();
  }

  void play({required int index}) {
    final bool isEvenTurn = state.turn % 2 == 0;
    final bool isPlayed = state.playedBoxes.contains(index);

    if (isPlayed) {
      debugPrint('already played');
      return;
    }

    if (state.turn < 9) {

      List<int> tempPlayedBoxes = List.from(state.playedBoxes);
      List<GameState> tempStates = List.from(state.gridBoxesStates);

      tempPlayedBoxes.add(index);
      if (isEvenTurn) {
        tempStates[index] = GameState.circle;
        emit(state.copyWith(playedBoxes: tempPlayedBoxes, gridBoxesStates: tempStates));
      } else {
        tempStates[index] = GameState.cross;
        emit(state.copyWith(playedBoxes: tempPlayedBoxes, gridBoxesStates: tempStates));
      }


      bool diagonalCombination = false,
          nonDiagonalCombination = false,
          columnCombination = false,
          rowCombination = false;
      diagonalCombination = isDiagonalWin();
      debugPrint('Diagonal Combination: -------->$diagonalCombination');
      nonDiagonalCombination = isNonDiagonalWin();
      debugPrint('Non Diagonal Combination: ---->$nonDiagonalCombination');
      columnCombination = isColumnWin();
      debugPrint('Column Combination: ---------->$columnCombination');
      rowCombination = isRowWin();
      debugPrint('Row Combination: ------------->$rowCombination');

      if(diagonalCombination){
        emit(
          state.copyWith(
            hasCombinationMatched: true,
            combination: WinCombination.diagonal
          ),
        );
        return;
      }
      else if(nonDiagonalCombination){
        emit(
          state.copyWith(
            hasCombinationMatched: true,
              combination: WinCombination.nonDiagonal
          ),
        );
        return;
      }
      else if(columnCombination){
        emit(
          state.copyWith(
            hasCombinationMatched: true,
              combination: WinCombination.column
          ),
        );
        return;
      }
      else if(rowCombination){
        emit(
          state.copyWith(
            hasCombinationMatched: true,
              combination: WinCombination.row
          ),
        );
        return;
      }
      else{
        emit(
          state.copyWith(
            hasCombinationMatched: false,
              combination: WinCombination.none
          ),
        );
      }

      nextTurn();

    } else {
      debugPrint('No more boxes left');
    }
  }

  void nextTurn() {
    debugPrint('TURNS: ------> ${state.turn}');
    int tempTurn = state.turn;
    tempTurn++;
    emit(state.copyWith(turn: tempTurn));
  }


  bool isDiagonalWin() {
    if (state.gridBoxesStates[0] != GameState.empty &&
        (state.gridBoxesStates[4] != GameState.empty) &&
        (state.gridBoxesStates[8] != GameState.empty)) {
      if (state.gridBoxesStates[0] == state.gridBoxesStates[4]) {
        if (state.gridBoxesStates[4] == state.gridBoxesStates[8]) {
          emit(state.copyWith(player: state.gridBoxesStates[0]));
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool isNonDiagonalWin() {
    if (state.gridBoxesStates[2] != GameState.empty &&
        (state.gridBoxesStates[4] != GameState.empty) &&
        (state.gridBoxesStates[6] != GameState.empty)) {
      if (state.gridBoxesStates[2] == state.gridBoxesStates[4]) {
        if (state.gridBoxesStates[4] == state.gridBoxesStates[6]) {
          emit(state.copyWith(player: state.gridBoxesStates[2]));
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool isRowWin() {
    bool result = false;

    if (state.gridBoxesStates[0] != GameState.empty &&
        state.gridBoxesStates[0] == state.gridBoxesStates[1] &&
        state.gridBoxesStates[1] == state.gridBoxesStates[2]) {
      emit(state.copyWith(row: 0, player: state.gridBoxesStates[0]));
      result = true;
    }
    else if (state.gridBoxesStates[3] != GameState.empty &&
        state.gridBoxesStates[3] == state.gridBoxesStates[4] &&
        state.gridBoxesStates[4] == state.gridBoxesStates[5]) {
      emit(state.copyWith(row: 3, player: state.gridBoxesStates[3]));
      result = true;
    }
    else if (state.gridBoxesStates[6] != GameState.empty &&
        state.gridBoxesStates[6] == state.gridBoxesStates[7] &&
        state.gridBoxesStates[7] == state.gridBoxesStates[8]) {
      emit(state.copyWith(row: 6, player: state.gridBoxesStates[6]));
      result = true;
    }

    return result;
  }

  bool isColumnWin() {
    bool result = false;

    if (state.gridBoxesStates[0] != GameState.empty &&
        state.gridBoxesStates[0] == state.gridBoxesStates[3] &&
        state.gridBoxesStates[3] == state.gridBoxesStates[6]) {
      emit(state.copyWith(column: 0, player: state.gridBoxesStates[0]));
      result = true;
    }
    else if (state.gridBoxesStates[1] != GameState.empty &&
        state.gridBoxesStates[1] == state.gridBoxesStates[4] &&
        state.gridBoxesStates[4] == state.gridBoxesStates[7]) {
      emit(state.copyWith(column: 1, player: state.gridBoxesStates[1]));
      result = true;
    }
    else if (state.gridBoxesStates[2] != GameState.empty &&
        state.gridBoxesStates[2] == state.gridBoxesStates[5] &&
        state.gridBoxesStates[5] == state.gridBoxesStates[8]) {
      emit(state.copyWith(column: 2, player: state.gridBoxesStates[2]));
      result = true;
    }

    return result;
  }


}
