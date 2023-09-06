import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_tow/info/bloc/Info_bloc.dart';
import 'package:tic_tac_tow/main.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key, required this.result, required this.player});

  final String result;
  final String player;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor:  Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              result,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: font * 24),
            ),
            Text(
              player,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: font * 24),
            ),
            SizedBox(
              height: height * 0.04,
            ),

            InkWell(
              onTap: () {
                context.read<InfoBloc>().clearBoard();
                Navigator.pop(context);
              },
              child: Container(
                width: width * 0.5,
                height: height * 0.06,
                decoration: BoxDecoration(
                    color: const Color(0xFF1D1A3D),
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Center(
                  child: Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: font * 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
