import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_tow/dialog_box.dart';
import 'package:tic_tac_tow/info/bloc/Info_bloc.dart';
import 'package:tic_tac_tow/info/bloc/info_bloc_state.dart';
import 'package:tic_tac_tow/main.dart';
import 'dart:math' as math;

import '../custom_painter.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<InfoBloc>().clearBoard();
        },
        child: const Icon(Icons.cancel),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text(
                      'Player 1',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Image.asset(
                      'assets/circle.png',
                      width: width * 0.08,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Player 2',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Image.asset(
                      'assets/cross.png',
                      width: width * 0.09,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            BlocConsumer<InfoBloc, InfoBlocState>(listener: (context, state) {
              if (state.hasCombinationMatched) {
                debugPrint('----------------> CombinationMatched');
                if(state.player == GameState.cross){
                  Future.delayed(const Duration(seconds: 1), () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const DialogBox(result: 'WIN!!!', player: 'Player 2');
                      },
                    );
                  });
                }
                else if(state.player == GameState.circle){
                  Future.delayed(const Duration(seconds: 1), () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const DialogBox(result: 'WIN!!!', player: 'Player 1');
                      },
                    );
                  });
                }
              }
              else if(state.turn == 9 && !state.hasCombinationMatched){
                showDialog(context: context, builder: (context) {
                  return const DialogBox(result: 'DRAW!!!', player: '',);
                });
              }
            }, builder: (context, state) {
              return Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.count(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(9, (index) {
                            return GridBox(
                              index: index,
                              isOccupied: state.playedBoxes.contains(index),
                              onTap: () {
                                context.read<InfoBloc>().play(index: index);
                              },
                              state: state.gridBoxesStates[index],
                            );
                          })),
                    ),
                    const WinningLine(),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class GridBox extends StatelessWidget {
  const GridBox({
    super.key,
    required this.index,
    required this.isOccupied,
    required this.onTap,
    required this.state,
  });

  final int index;
  final bool isOccupied;
  final Function onTap;
  final GameState state;

  @override
  Widget build(BuildContext context) {
    Widget boxChild = const SizedBox.shrink();
    if (state == GameState.empty) {
      boxChild = const SizedBox.shrink();
    } else if (state == GameState.circle) {
      boxChild = Image.asset('assets/circle.png');
    } else {
      boxChild = Image.asset('assets/cross.png');
    }

    return InkWell(
      onTap: () {
        if (!isOccupied) {
          onTap.call();
        } else {
          debugPrint('box already occupied');
        }
      },
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: boxChild,
      ),
    );
  }
}

class WinningLine extends StatelessWidget {
  const WinningLine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoBlocState>(builder: (context, state) {
      if (state.combination == WinCombination.diagonal) {
        return Positioned(
          left: 30,
          right: 30,
          child: Transform(
            transform: Matrix4.identity()
              ..scale(1.5, 1.5)
              ..rotateZ(math.pi / 4),
            child: SizedBox(
                width: width,
                child: const Divider(
                  color: Colors.black,
                  thickness: 4,
                )),
          ),
        );
      } else if (state.combination == WinCombination.nonDiagonal) {
        return Positioned(
          top: 30,
          right: 50,
          left: 0,
          bottom: 200,
          child: SizedBox(
            width: width * 1.05,
            height: height * 0.5,
            child: CustomPaint(
              painter: CrossPainter(),
              size: const Size(200, 200),
            ),
          ),
        );
      } else if (state.combination == WinCombination.column) {
        return state.column == 0
            ? Positioned(
                child: SizedBox(
                    width: width * 0.41,
                    height: height * 0.45,
                    child: const VerticalDivider(
                      color: Colors.black,
                      thickness: 5,
                      width: 4,
                    )),
              )
            : (state.column == 1
                ? Positioned(
                    child: SizedBox(
                        width: width * 1.2,
                        height: height * 0.45,
                        child: const VerticalDivider(
                          color: Colors.black,
                          thickness: 5,
                          width: 4,
                        )),
                  )
                : Positioned(
                    left: 80,
                    child: SizedBox(
                        width: width * 1.2,
                        height: height * 0.45,
                        child: const VerticalDivider(
                          color: Colors.black,
                          thickness: 5,
                          width: 4,
                        )),
                  ));
      } else if (state.combination == WinCombination.row) {
        return state.row == 0
            ? Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: SizedBox(
                    width: width,
                    child: const Divider(
                      color: Colors.black,
                      thickness: 5,
                    )),
              )
            : (state.row == 3
                ? Positioned(
                    top: 180,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                        width: width,
                        child: const Divider(
                          color: Colors.black,
                          thickness: 5,
                        )),
                  )
                : Positioned(
                    top: 300,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                        width: width,
                        child: const Divider(
                          color: Colors.black,
                          thickness: 5,
                        )),
                  ));
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
