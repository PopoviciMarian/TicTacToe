import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerVsAi extends StatefulWidget {
  @override
  _PlayerVsAiState createState() => _PlayerVsAiState();
}


class _PlayerVsAiState extends State<PlayerVsAi> {
  @override
  List<List<String>> gridState = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ];
  bool isPlayer1Turn = true;
  int scorePlayer = 0;
  int scoreAI = 0;
  List<List<bool>> _listButtonsCol = [
    [false, false, false],
    [false, false, false],
    [false, false, false],
  ];
  List<List<bool>> _listButtonsEnabled = [
    ///prevent errors
    [true, true, true],
    [true, true, true],
    [true, true, true],
  ];
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.yellow,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Player vs AI',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 120),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 120, 5, 0),
                  child: _buildCeil(gridState[0][0], 0, 0),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 120, 0, 0),
                  child: _buildCeil(gridState[0][1], 0, 1),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 120, 0, 0),
                  child: _buildCeil(gridState[0][2], 0, 2),
                ),
              ]),
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                  child: _buildCeil(gridState[1][0], 1, 0),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: _buildCeil(gridState[1][1], 1, 1),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: _buildCeil(gridState[1][2], 1, 2),
                ),
              ]),
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                  child: _buildCeil(gridState[2][0], 2, 0),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: _buildCeil(gridState[2][1], 2, 1),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: _buildCeil(gridState[2][2], 2, 2),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _buildCeil(String val, int x, int y) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: _listButtonsCol[x][y] ? Colors.red[400] : Colors.yellow[500],
      textColor: _listButtonsCol[x][y] ? Colors.yellow[500] : Colors.black,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.fromLTRB(8, 18, 8, 18),
      splashColor: Colors.yellow[600],
      onPressed: () {
        if (_listButtonsEnabled[x][y]) gameLogic(val, x, y);
      },
      child: Text(
        val,
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }
//----------------------------------------------------------< - AI & Game Logic - >----------------------------------------------------------------

  void gameLogic(String val, int x, int y) {
    testIfMustStartNewGame(val, x, y);
    if (val == ' ') {
      if (isPlayer1Turn) {
        _listButtonsEnabled = [
          [false, false, false],
          [false, false, false],
          [false, false, false],
        ];
        val = 'X';
        gridState[x][y] = 'X';
        setState(() {});
        testIfMustStartNewGame(val, x, y);
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            if (isMovesLeft(gridState)) {
              List bestMove = findBestMove(gridState);
              gridState[bestMove[0]][bestMove[1]] = 'O';
              drawLine(gridState);
              testIfMustStartNewGame(val, x, y);
              _listButtonsEnabled = [
                [true, true, true],
                [true, true, true],
                [true, true, true],
              ];
            }
          });
        });
        drawLine(gridState);
        testIfMustStartNewGame(val, x, y);
      }
    }
  }

  void testIfMustStartNewGame(String val, int x, int y) {
    if (evaluate(gridState) == 10) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
              gridState[i][j] = ' ';
              _listButtonsCol[i][j] = false;
            }
          }
        });
      });
    }
    if (evaluate(gridState) == -10) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print("GATAAAAAA Player ----- 01");
        setState(() {
          for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
              gridState[i][j] = ' ';
              _listButtonsCol[i][j] = false;
            }
          }
        });
      });
    }
    if (!isMovesLeft(gridState)) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
              gridState[i][j] = ' ';
            }
          }
        });
      });
    }
  }

  void drawLine(List<List<String>> b) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        for (int row = 0; row < 3; row++) {
          if (b[row][0] == b[row][1] && b[row][1] == b[row][2]) {
            if (b[row][0] == 'O')
              _listButtonsCol[row][0] =
                  _listButtonsCol[row][1] = _listButtonsCol[row][2] = true;
          }
        }
        for (int col = 0; col < 3; col++) {
          if (b[0][col] == b[1][col] && b[1][col] == b[2][col]) {
            if (b[0][col] == 'O')
              _listButtonsCol[0][col] =
                  _listButtonsCol[1][col] = _listButtonsCol[2][col] = true;
          }
        }
        if (b[0][0] == b[1][1] && b[1][1] == b[2][2]) {
          if (b[0][0] == 'O')
            _listButtonsCol[0][0] =
                _listButtonsCol[1][1] = _listButtonsCol[2][2] = true;
        }

        if (b[0][2] == b[1][1] && b[1][1] == b[2][0]) {
          if (b[0][2] == 'O')
            _listButtonsCol[0][2] =
                _listButtonsCol[1][1] = _listButtonsCol[2][0] = true;
        }
      });
    });
  }

  bool isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++) if (board[i][j] == ' ') return true;
    return false;
  }

  int evaluate(List<List<String>> b) {
    for (int row = 0; row < 3; row++) {
      if (b[row][0] == b[row][1] && b[row][1] == b[row][2]) {
        if (b[row][0] == 'O')
          return 10;
        else if (b[row][0] == 'X') return -10;
      }
    }
    for (int col = 0; col < 3; col++) {
      if (b[0][col] == b[1][col] && b[1][col] == b[2][col]) {
        if (b[0][col] == 'O')
          return 10;
        else if (b[0][col] == 'X') return -10;
      }
    }
    if (b[0][0] == b[1][1] && b[1][1] == b[2][2]) {
      if (b[0][0] == 'O')
        return 10;
      else if (b[0][0] == 'X') return -10;
    }

    if (b[0][2] == b[1][1] && b[1][1] == b[2][0]) {
      if (b[0][2] == 'O')
        return 10;
      else if (b[0][2] == 'X') return -10;
    }
    return 0;
  }

  int minimax(List<List<String>> board, int depth, bool isMax) {
    int score = evaluate(board);
    if (score == 10) return score;
    if (score == -10) return score;
    if (isMovesLeft(board) == false) return 0;
    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == ' ') {
            board[i][j] = 'O';
            int resultMiniMax = minimax(board, depth + 1, !isMax);
            if (resultMiniMax > best) {
              best = resultMiniMax;
            }
            board[i][j] = ' ';
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == ' ') {
            board[i][j] = 'X';
            int resultMiniMax = minimax(board, depth + 1, !isMax);
            if (best > resultMiniMax) {
              best = resultMiniMax;
            }
            board[i][j] = ' ';
          }
        }
      }
      return best;
    }
  }

  List findBestMove(List<List<String>> board) {
    int bestVal = -1000;
    // List bestMove;
    List<int> bestMove = new List(2);
    bestMove[0] = -1;
    bestMove[1] = -1;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == ' ') {
          board[i][j] = 'O';
          int moveVal = minimax(board, 0, false);
          board[i][j] = ' ';
          if (moveVal > bestVal) {
            bestMove[0] = i;
            bestMove[1] = j;
            bestVal = moveVal;
          }
        }
      }
    }
    return bestMove;
  }
}
