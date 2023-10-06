/*
Copyright © 2023 RueLee, All rights reserved.
*/

ClearGameEventCallbacks();

class Pawn {
    color = 0;
    name = "";
    moveCounter = 0;
    played_two_tiles = null;

    constructor(color, name) {
        this.color = color;
        this.name = name;
        played_two_tiles = false;
    }
    
    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function getMovedStatus() {
        return wasMoved;
    }

    function getMoveCounter() {
        return moveCounter;
    }
    
    function addMoveCounter() {
        moveCounter++;
    }

    function getPlayedTwoTilesStatus() {
        return played_two_tiles;
    }

    function setPlayedTwoTilesStatus(played_two_tiles) {
        this.played_two_tiles = played_two_tiles;
    }

    /*
    This function will have all other same parameter from different classes except for the King.
    */
    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false) {
        if (chessturn != color || checkPins) {      // Check if the player matches with their assigned colors.
            return [];
        }
        local available_tile_moves = [];
        if (checkLineDetector) {
            if (color == 0) {
                if (getCurrentCol - 1 >= 0) {
                    if (getCurrentRow - 1 == blackKingPosition[0] && getCurrentCol - 1 == blackKingPosition[1] && 0 == chessturn) {
                        return [board[getCurrentRow][getCurrentCol], board[getCurrentRow - 1][getCurrentCol - 1]];
                    }
                }
                if (getCurrentCol + 1 < 8) {
                    if (getCurrentRow - 1 == blackKingPosition[0] && getCurrentCol + 1 == blackKingPosition[1] && 0 == chessturn) {
                        return [board[getCurrentRow][getCurrentCol], board[getCurrentRow - 1][getCurrentCol + 1]];
                    }
                }
            }
            else if (color == 1) {
                if (getCurrentCol - 1 >= 0) {
                    if (getCurrentRow + 1 == whiteKingPosition[0] && getCurrentCol - 1 == whiteKingPosition[1] && 1 == chessturn) {
                        return [board[getCurrentRow][getCurrentCol], board[getCurrentRow + 1][getCurrentCol - 1]];
                    }
                }
                if (getCurrentCol + 1 < 8) {
                    if (getCurrentRow + 1 == whiteKingPosition[0] && getCurrentCol + 1 == whiteKingPosition[1] && 1 == chessturn) {
                        return [board[getCurrentRow][getCurrentCol], board[getCurrentRow + 1][getCurrentCol + 1]];
                    }
                }
            }
            return [];
        }
        if (checkTile) {
            if (color == 0) {
                if (getCurrentCol - 1 >= 0) {
                    available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol - 1]);
                }
                if (getCurrentCol + 1 < 8) {
                    available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol + 1]);
                }
            }
            else if (color == 1) {
                if (getCurrentCol - 1 >= 0) {
                    available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol - 1]);
                }
                if (getCurrentCol + 1 < 8) {
                    available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol + 1]);
                }
            }
            return available_tile_moves;
        }

        if (color == 0) {   // White Pawn
            if (occupied[getCurrentRow - 1][getCurrentCol] == null) {
                available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol]);
            }
            if (getCurrentCol - 1 >= 0) {
                if (occupied[getCurrentRow - 1][getCurrentCol - 1] != null) {
                    if (occupied[getCurrentRow - 1][getCurrentCol - 1].getColor() != color) {
                        available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol - 1]);
                    }
                }
            }
            if (getCurrentCol + 1 < 8) {
                if (occupied[getCurrentRow - 1][getCurrentCol + 1] != null) {
                    if (occupied[getCurrentRow - 1][getCurrentCol + 1].getColor() != color) {
                        available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol + 1]);
                    }
                }
            }

            if (moveCounter == 0 && occupied[getCurrentRow - 1][getCurrentCol] == null) {
                if (occupied[getCurrentRow - 2][getCurrentCol] == null) {
                    available_tile_moves.append(board[getCurrentRow - 2][getCurrentCol]);
                }
            }
            if (moveCounter == 3) {     // Check for en passant
                if (getCurrentCol - 1 >= 0) {
                    if (occupied[getCurrentRow][getCurrentCol - 1] != null) {
                        if (Entities.FindByName(null, occupied[getCurrentRow][getCurrentCol - 1].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                            if (occupied[getCurrentRow][getCurrentCol - 1].getPlayedTwoTilesStatus() && occupied[getCurrentRow][getCurrentCol - 1].getColor() != color) {
                                available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol - 1]);
                            }
                        }
                    }
                }
                if (getCurrentCol + 1 < 8) {
                    if (occupied[getCurrentRow][getCurrentCol + 1] != null) {
                        if (Entities.FindByName(null, occupied[getCurrentRow][getCurrentCol + 1].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                            if (occupied[getCurrentRow][getCurrentCol + 1].getPlayedTwoTilesStatus() && occupied[getCurrentRow][getCurrentCol + 1].getColor() != color) {
                                available_tile_moves.append(board[getCurrentRow - 1][getCurrentCol + 1]);
                            }
                        }
                    }
                }
            }
        }
        else if (color == 1) {  // Black Pawn
            if (occupied[getCurrentRow + 1][getCurrentCol] == null) {
                available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol]);
            }
            if (getCurrentCol - 1 >= 0) {
                if (occupied[getCurrentRow + 1][getCurrentCol - 1] != null) {
                    if (occupied[getCurrentRow + 1][getCurrentCol - 1].getColor() != color) {
                        available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol - 1]);
                    }
                }
            }
            if (getCurrentCol + 1 < 8) {
                if (occupied[getCurrentRow + 1][getCurrentCol + 1] != null) {
                    if (occupied[getCurrentRow + 1][getCurrentCol + 1].getColor() != color) {
                        available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol + 1]);
                    }
                }
            }

            if (moveCounter == 0 && occupied[getCurrentRow + 1][getCurrentCol] == null) {
                //board[getCurrentRow - 1][getCurrentCol].__KeyValueFromString("rendercolor", "58 161 75");
                if (occupied[getCurrentRow + 2][getCurrentCol] == null) {
                    //board[getCurrentRow - 2][getCurrentCol].__KeyValueFromString("rendercolor", "58 161 75");
                    available_tile_moves.append(board[getCurrentRow + 2][getCurrentCol]);
                }
            }
            if (moveCounter == 3) {     // Check for en passant
                if (getCurrentCol - 1 >= 0) {
                    if (occupied[getCurrentRow][getCurrentCol - 1] != null) {
                        if (Entities.FindByName(null, occupied[getCurrentRow][getCurrentCol - 1].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                            if (occupied[getCurrentRow][getCurrentCol - 1].getPlayedTwoTilesStatus() && occupied[getCurrentRow][getCurrentCol - 1].getColor() != color) {
                                available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol - 1]);
                            }
                        }
                    }
                }
                if (getCurrentCol + 1 < 8) {
                    if (occupied[getCurrentRow][getCurrentCol + 1] != null) {
                        if (Entities.FindByName(null, occupied[getCurrentRow][getCurrentCol + 1].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                            if (occupied[getCurrentRow][getCurrentCol + 1].getPlayedTwoTilesStatus() && occupied[getCurrentRow][getCurrentCol + 1].getColor() != color) {
                                available_tile_moves.append(board[getCurrentRow + 1][getCurrentCol + 1]);
                            }
                        }
                    }
                }
            }
        }
        return available_tile_moves;
    }

    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece) {
        // No needed. Only the King is the valid move.
        if (threat_piece.len() > 1) {
            return [];
        }
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            if (threat_piece[0].find(value) != null) {
                available_tile_moves.append(value);
            }
        }
        return available_tile_moves;
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece) {
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            foreach (i, j in pinned_piece) {
                if (j.find(value) != null) {
                    available_tile_moves.append(value);
                }
            }
        }
        return available_tile_moves;
    }
}

class Knight {
    color = 0;
    name = "";

    constructor(color, name) {
        this.color = color;
        this.name = name;
    }

    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false) {
        /*
        Code reference: https://www.geeksforgeeks.org/possible-moves-knight/
        */
        if (chessturn != color || checkPins) {
            return [];
        }
        local available_tile_moves = [];
        local pre_x = [2, 1, -1, -2, -2, -1, 1, 2];
        local pre_y = [1, 2, 2, 1, -1, -2, -2, -1];

        for (local i = 0; i < 8; i++) {
            local x = getCurrentRow + pre_x[i];
            local y = getCurrentCol + pre_y[i];

            if (x >= 0 && y >= 0 && x < 8 && y < 8 && occupied[x][y] == null) {
                available_tile_moves.append(board[x][y]);
            }

            if (x >= 0 && y >= 0 && x < 8 && y < 8 && occupied[x][y] != null) {
                if (occupied[x][y].getColor() != color || checkTile) {
                    available_tile_moves.append(board[x][y]);
                    if (checkLineDetector) {
                        if (x == whiteKingPosition[0] && y == whiteKingPosition[1] && 0 != chessturn) {
                            //printl("KNIGHT CALLED")
                            return [board[getCurrentRow][getCurrentCol], board[x][y]];
                        }
                        else if (x == blackKingPosition[0] && y == blackKingPosition[1] && 1 != chessturn) {
                            return [board[getCurrentRow][getCurrentCol], board[x][y]];
                        }
                    }
                }
            }
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        return available_tile_moves;
    }

    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece) {
        // No needed. Only the King is the valid move.
        if (threat_piece.len() > 1) {
            return [];
        }
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            if (threat_piece[0].find(value) != null) {
                available_tile_moves.append(value);
            }
        }
        return available_tile_moves;
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece) {
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            foreach (i, j in pinned_piece) {
                if (j.find(value) != null) {
                    available_tile_moves.append(value);
                }
            }
        }
        return available_tile_moves;
    }
}

/*
Bishop, Rook, and Queen class have been referenced from: https://github.com/jlundstedt/chess-java
However, it has been heavily modified to match this programming language, game compatibility, and code algorithms.
*/

class Bishop {
    color = 0;
    name = "";

    constructor(color, name) {
        this.color = color;
        this.name = name;
    }

    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false) {
        if (chessturn != color) {
            return [];
        }
        local available_tile_moves = [];

        local up = getCurrentRow - 1;
        local down = getCurrentRow + 1;
        local left = getCurrentCol - 1;
        local right = getCurrentCol + 1;

        while (up >= 0 && left >= 0) {
            if (occupied[up][left] == null) {
                available_tile_moves.append(board[up][left]);
            }
            if (occupied[up][left] != null) {
                if (checkTile && occupied[up][left].getPieceName().find("king") != null && occupied[up][left].getColor() != color) {
                    available_tile_moves.append(board[up][left]);
                }
                else if (occupied[up][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][left]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0 && --left >= 0) {

                            available_tile_moves.append(board[up][up]);
                            if (occupied[up][left] != null) {
                                if (up == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (up >= 0 && right < 8) {
            if (occupied[up][right] == null) {
                available_tile_moves.append(board[up][right]);
            }
            if (occupied[up][right] != null) {
                if (checkTile && occupied[up][right].getPieceName().find("king") != null && occupied[up][right].getColor() != color) {
                    available_tile_moves.append(board[up][right]);
                }
                else if (occupied[up][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][right]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0 && ++right < 8) {

                            available_tile_moves.append(board[up][right]);
                            if (occupied[up][right] != null) {
                                if (up == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
            right++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (down < 8 && left >= 0) {
            if (occupied[down][left] == null) {
                available_tile_moves.append(board[down][left]);
            }
            if (occupied[down][left] != null) {
                if (checkTile && occupied[down][left].getPieceName().find("king") != null && occupied[down][left].getColor() != color) {
                    available_tile_moves.append(board[down][left]);
                }
                else if (occupied[down][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][left]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8 && --left >= 0) {

                            available_tile_moves.append(board[down][left]);
                            if (occupied[down][left] != null) {
                                if (down == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (down < 8 && right < 8) {
            if (occupied[down][right] == null) {
                available_tile_moves.append(board[down][right]);
            }
            if (occupied[down][right] != null) {
                if (checkTile && occupied[down][right].getPieceName().find("king") != null && occupied[down][right].getColor() != color) {
                    available_tile_moves.append(board[down][right]);
                }
                else if (occupied[down][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][right]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8 && ++right < 8) {

                            available_tile_moves.append(board[down][right]);
                            if (occupied[down][right] != null) {
                                if (down == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
            right++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        return available_tile_moves;
    }

    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece) {
        // No needed. Only the King is the valid move.
        if (threat_piece.len() > 1) {
            return [];
        }
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            if (threat_piece[0].find(value) != null) {
                available_tile_moves.append(value);
            }
        }
        return available_tile_moves;
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece) {
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            foreach (i, j in pinned_piece) {
                if (j.find(value) != null) {
                    available_tile_moves.append(value);
                }
            }
        }
        return available_tile_moves;
    }
}

class Rook {
    color = 0;
    name = "";
    canCastle = null;

    constructor(color, name) {
        this.color = color;
        this.name = name;
        canCastle = true;
    }

    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function getCastleStatus() {
        return canCastle;
    }

    function setCastleStatus(canCastle) {
        this.canCastle = canCastle;
    }

    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false) {
        if (chessturn != color) {
            return [];
        }
        local available_tile_moves = [];
        local up = getCurrentRow - 1;
        local down = getCurrentRow + 1;
        local left = getCurrentCol - 1;
        local right = getCurrentCol + 1;

        while (up >= 0) {
            if (occupied[up][getCurrentCol] == null) {
                available_tile_moves.append(board[up][getCurrentCol]);
            }

            if (occupied[up][getCurrentCol] != null) {
                if (checkTile && occupied[up][getCurrentCol].getPieceName().find("king") != null && occupied[up][getCurrentCol].getColor() != color) {
                    available_tile_moves.append(board[up][getCurrentCol]);
                }
                else if (occupied[up][getCurrentCol].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][getCurrentCol]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0) {

                            available_tile_moves.append(board[up][getCurrentCol]);
                            if (occupied[up][getCurrentCol] != null) {
                                if (up == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (down < 8) {
            if (occupied[down][getCurrentCol] == null) {
                available_tile_moves.append(board[down][getCurrentCol]);
            }

            if (occupied[down][getCurrentCol] != null) {
                if (checkTile && occupied[down][getCurrentCol].getPieceName().find("king") != null && occupied[down][getCurrentCol].getColor() != color) {
                    available_tile_moves.append(board[down][getCurrentCol]);
                }
                else if (occupied[down][getCurrentCol].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][getCurrentCol]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8) {

                            available_tile_moves.append(board[down][getCurrentCol]);
                            if (occupied[down][getCurrentCol] != null) {
                                if (down == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (left >= 0) {
            if (occupied[getCurrentRow][left] == null) {
                available_tile_moves.append(board[getCurrentRow][left]);
            }

            if (occupied[getCurrentRow][left] != null) {
                if (checkTile && occupied[getCurrentRow][left].getPieceName().find("king") != null && occupied[getCurrentRow][left].getColor() != color) {
                    available_tile_moves.append(board[getCurrentRow][left]);
                }
                else if (occupied[getCurrentRow][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[getCurrentRow][left]);
                    if (checkLineDetector) {
                        if (getCurrentRow == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (getCurrentRow == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--left >= 0) {

                            available_tile_moves.append(board[getCurrentRow][left]);
                            if (occupied[getCurrentRow][left] != null) {
                                if (getCurrentRow == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (getCurrentRow == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (right < 8) {
            if (occupied[getCurrentRow][right] == null) {
                available_tile_moves.append(board[getCurrentRow][right]);
            }

            if (occupied[getCurrentRow][right] != null) {
                if (checkTile && occupied[getCurrentRow][right].getPieceName().find("king") != null && occupied[getCurrentRow][right].getColor() != color) {
                    available_tile_moves.append(board[getCurrentRow][right]);
                }
                else if (occupied[getCurrentRow][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[getCurrentRow][right]);
                    if (checkLineDetector) {
                        if (getCurrentRow == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (getCurrentRow == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++right < 8) {

                            available_tile_moves.append(board[getCurrentRow][right]);
                            if (occupied[getCurrentRow][right] != null) {
                                if (getCurrentRow == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (getCurrentRow == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            right++;
        }
        
        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        return available_tile_moves;
    }

    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece) {
        // No needed. Only the King is the valid move.
        if (threat_piece.len() > 1) {
            return [];
        }
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            if (threat_piece[0].find(value) != null) {
                available_tile_moves.append(value);
            }
        }
        return available_tile_moves;
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece) {
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            foreach (i, j in pinned_piece) {
                if (j.find(value) != null) {
                    available_tile_moves.append(value);
                }
            }
        }
        return available_tile_moves;
    }
}

class Queen {
    color = 0;
    name = "";

    constructor(color, name) {
        this.color = color;
        this.name = name;
    }

    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false) {
        if (chessturn != color) {
            return [];
        }
        local available_tile_moves = [];

        local up = getCurrentRow - 1;
        local down = getCurrentRow + 1;
        local left = getCurrentCol - 1;
        local right = getCurrentCol + 1;

        while (up >= 0 && left >= 0) {
            if (occupied[up][left] == null) {
                available_tile_moves.append(board[up][left]);
            }
            if (occupied[up][left] != null) {
                if (checkTile && occupied[up][left].getPieceName().find("king") != null && occupied[up][left].getColor() != color) {
                    available_tile_moves.append(board[up][left]);
                }
                else if (occupied[up][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][left]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0 && --left >= 0) {

                            available_tile_moves.append(board[up][up]);
                            if (occupied[up][left] != null) {
                                if (up == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (up >= 0 && right < 8) {
            if (occupied[up][right] == null) {
                available_tile_moves.append(board[up][right]);
            }
            if (occupied[up][right] != null) {
                if (checkTile && occupied[up][right].getPieceName().find("king") != null && occupied[up][right].getColor() != color) {
                    available_tile_moves.append(board[up][right]);
                }
                else if (occupied[up][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][right]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0 && ++right < 8) {

                            available_tile_moves.append(board[up][right]);
                            if (occupied[up][right] != null) {
                                if (up == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
            right++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (down < 8 && left >= 0) {
            if (occupied[down][left] == null) {
                available_tile_moves.append(board[down][left]);
            }
            if (occupied[down][left] != null) {
                if (checkTile && occupied[down][left].getPieceName().find("king") != null && occupied[down][left].getColor() != color) {
                    available_tile_moves.append(board[down][left]);
                }
                else if (occupied[down][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][left]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8 && --left >= 0) {

                            available_tile_moves.append(board[down][left]);
                            if (occupied[down][left] != null) {
                                if (down == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (down < 8 && right < 8) {
            if (occupied[down][right] == null) {
                available_tile_moves.append(board[down][right]);
            }
            if (occupied[down][right] != null) {
                if (checkTile && occupied[down][right].getPieceName().find("king") != null && occupied[down][right].getColor() != color) {
                    available_tile_moves.append(board[down][right]);
                }
                else if (occupied[down][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][right]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8 && ++right < 8) {

                            available_tile_moves.append(board[down][right]);
                            if (occupied[down][right] != null) {
                                if (down == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
            right++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        up = getCurrentRow - 1;
        down = getCurrentRow + 1;
        left = getCurrentCol - 1;
        right = getCurrentCol + 1;

        while (up >= 0) {
            if (occupied[up][getCurrentCol] == null) {
                available_tile_moves.append(board[up][getCurrentCol]);
            }

            if (occupied[up][getCurrentCol] != null) {
                if (checkTile && occupied[up][getCurrentCol].getPieceName().find("king") != null && occupied[up][getCurrentCol].getColor() != color) {
                    available_tile_moves.append(board[up][getCurrentCol]);
                }
                else if (occupied[up][getCurrentCol].getColor() != color || checkTile) {
                    available_tile_moves.append(board[up][getCurrentCol]);
                    if (checkLineDetector) {
                        if (up == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (up == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--up >= 0) {

                            available_tile_moves.append(board[up][getCurrentCol]);
                            if (occupied[up][getCurrentCol] != null) {
                                if (up == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (up == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            up--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (down < 8) {
            if (occupied[down][getCurrentCol] == null) {
                available_tile_moves.append(board[down][getCurrentCol]);
            }

            if (occupied[down][getCurrentCol] != null) {
                if (checkTile && occupied[down][getCurrentCol].getPieceName().find("king") != null && occupied[down][getCurrentCol].getColor() != color) {
                    available_tile_moves.append(board[down][getCurrentCol]);
                }
                else if (occupied[down][getCurrentCol].getColor() != color || checkTile) {
                    available_tile_moves.append(board[down][getCurrentCol]);
                    if (checkLineDetector) {
                        if (down == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (down == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++down < 8) {

                            available_tile_moves.append(board[down][getCurrentCol]);
                            if (occupied[down][getCurrentCol] != null) {
                                if (down == whiteKingPosition[0] && getCurrentCol == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (down == blackKingPosition[0] && getCurrentCol == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            down++;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (left >= 0) {
            if (occupied[getCurrentRow][left] == null) {
                available_tile_moves.append(board[getCurrentRow][left]);
            }

            if (occupied[getCurrentRow][left] != null) {
                if (checkTile && occupied[getCurrentRow][left].getPieceName().find("king") != null && occupied[getCurrentRow][left].getColor() != color) {
                    available_tile_moves.append(board[getCurrentRow][left]);
                }
                else if (occupied[getCurrentRow][left].getColor() != color || checkTile) {
                    available_tile_moves.append(board[getCurrentRow][left]);
                    if (checkLineDetector) {
                        if (getCurrentRow == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (getCurrentRow == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (--left >= 0) {

                            available_tile_moves.append(board[getCurrentRow][left]);
                            if (occupied[getCurrentRow][left] != null) {
                                if (getCurrentRow == whiteKingPosition[0] && left == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (getCurrentRow == blackKingPosition[0] && left == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            left--;
        }

        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        while (right < 8) {
            if (occupied[getCurrentRow][right] == null) {
                available_tile_moves.append(board[getCurrentRow][right]);
            }

            if (occupied[getCurrentRow][right] != null) {
                if (checkTile && occupied[getCurrentRow][right].getPieceName().find("king") != null && occupied[getCurrentRow][right].getColor() != color) {
                    available_tile_moves.append(board[getCurrentRow][right]);
                }
                else if (occupied[getCurrentRow][right].getColor() != color || checkTile) {
                    available_tile_moves.append(board[getCurrentRow][right]);
                    if (checkLineDetector) {
                        if (getCurrentRow == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                        else if (getCurrentRow == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                            available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                            return available_tile_moves;
                        }
                    }
                    if (checkPins) {
                        while (++right < 8) {

                            available_tile_moves.append(board[getCurrentRow][right]);
                            if (occupied[getCurrentRow][right] != null) {
                                if (getCurrentRow == whiteKingPosition[0] && right == whiteKingPosition[1] && 0 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else if (getCurrentRow == blackKingPosition[0] && right == blackKingPosition[1] && 1 != chessturn) {
                                    available_tile_moves.append(board[getCurrentRow][getCurrentCol]);
                                    return available_tile_moves;
                                }
                                else {
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {
                    break;
                }
            }
            right++;
        }
        
        if (checkLineDetector || checkPins) {
            available_tile_moves.clear();
        }

        return available_tile_moves;
    }

    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece) {
        // No needed. Only the King is the valid move.
        if (threat_piece.len() > 1) {
            return [];
        }
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            if (threat_piece[0].find(value) != null) {
                available_tile_moves.append(value);
            }
        }
        return available_tile_moves;
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece) {
        local all_tile_moves = findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
        local available_tile_moves = [];

        foreach (index, value in all_tile_moves) {
            foreach (i, j in pinned_piece) {
                if (j.find(value) != null) {
                    available_tile_moves.append(value);
                }
            }
        }
        return available_tile_moves;
    }
}

class King {
    color = 0;
    name = "";
    canCastle = null;

    constructor(color, name) {
        this.color = color;
        this.name = name;
        canCastle = true;
    }

    function getColor() {
        return color;
    }

    function getPieceName() {
        return name;
    }

    function getCastleStatus() {
        return canCastle;
    }

    function setCastleStatus(canCastle) {
        this.canCastle = canCastle;
    }

    function findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, checkTile = false, checkLineDetector = false, checkPins = false, tileEliminator = [], inCheck = false) {
        /*
        Code reference:
        https://www.geeksforgeeks.org/total-position-where-king-can-reach-on-a-chessboard-in-exactly-m-moves-set-2/
        */
        if (chessturn != color || checkLineDetector || checkPins) {
            return [];
        }
        local available_tile_moves = [];

        for (local i = 0; i < 8; i++) {
            for (local j = 0; j < 8; j++) {
                if (max(abs(i - getCurrentRow), abs(j - getCurrentCol)) <= 1) {
                    if (checkTile) {
                        available_tile_moves.append(board[i][j]);
                        continue;
                    }
                    if (occupied[i][j] == null) {
                        available_tile_moves.append(board[i][j]);
                    }
                    if (occupied[i][j] != null) {
                        if (occupied[i][j].getColor() != color) {
                            available_tile_moves.append(board[i][j]);
                        }
                    }
                }
            }
        }
        
        // Check King and Rook's condition to castle in both sides.
        if (canCastle && !inCheck) {
            if (occupied[getCurrentRow][getCurrentCol - 4] != null && occupied[getCurrentRow][getCurrentCol - 4].getPieceName().find("rook") != null) {
                if (occupied[getCurrentRow][getCurrentCol - 4].getCastleStatus() && occupied[getCurrentRow][getCurrentCol - 1] == null && occupied[getCurrentRow][getCurrentCol - 2] == null && occupied[getCurrentRow][getCurrentCol - 3] == null) {
                    available_tile_moves.append(board[getCurrentRow][getCurrentCol - 2]);
                }
            }
            if (occupied[getCurrentRow][getCurrentCol + 3] != null && occupied[getCurrentRow][getCurrentCol + 3].getPieceName().find("rook") != null) {
                if (occupied[getCurrentRow][getCurrentCol + 3].getCastleStatus() && occupied[getCurrentRow][getCurrentCol + 1] == null && occupied[getCurrentRow][getCurrentCol + 2] == null) {
                    available_tile_moves.append(board[getCurrentRow][getCurrentCol + 2])
                }
            }
        }
        // Eliminate tile moves for checked tiles.
        if (!checkTile) {
            foreach (i, value in tileEliminator) {
                foreach (j, availability in available_tile_moves) {
                    if (value == availability) {
                        available_tile_moves.remove(j);
                    }
                }
            }
        }
        return available_tile_moves;
    }
    
    function findCheckMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, tileEliminator, inCheck) {
        return findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, false, false, false, tileEliminator, inCheck);
    }

    function findPinMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, tileEliminator) {
        return findLegalMoves(board, occupied, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, false, false, false, tileEliminator);
    }

    // Squirrel does not have a built-in max() function so I had to manually create it myself.
    function max(a, b) {
        return (a < b) ? b : a;
    }
}

const chessboard_str = "chessboard_"
chessboard <- [[Entities.FindByName(null, chessboard_str + "a8"), Entities.FindByName(null, chessboard_str + "b8"), Entities.FindByName(null, chessboard_str + "c8"), Entities.FindByName(null, chessboard_str + "d8"), Entities.FindByName(null, chessboard_str + "e8"), Entities.FindByName(null, chessboard_str + "f8"), Entities.FindByName(null, chessboard_str + "g8"), Entities.FindByName(null, chessboard_str + "h8")],
                [Entities.FindByName(null, chessboard_str + "a7"), Entities.FindByName(null, chessboard_str + "b7"), Entities.FindByName(null, chessboard_str + "c7"), Entities.FindByName(null, chessboard_str + "d7"), Entities.FindByName(null, chessboard_str + "e7"), Entities.FindByName(null, chessboard_str + "f7"), Entities.FindByName(null, chessboard_str + "g7"), Entities.FindByName(null, chessboard_str + "h7")],
                [Entities.FindByName(null, chessboard_str + "a6"), Entities.FindByName(null, chessboard_str + "b6"), Entities.FindByName(null, chessboard_str + "c6"), Entities.FindByName(null, chessboard_str + "d6"), Entities.FindByName(null, chessboard_str + "e6"), Entities.FindByName(null, chessboard_str + "f6"), Entities.FindByName(null, chessboard_str + "g6"), Entities.FindByName(null, chessboard_str + "h6")],
                [Entities.FindByName(null, chessboard_str + "a5"), Entities.FindByName(null, chessboard_str + "b5"), Entities.FindByName(null, chessboard_str + "c5"), Entities.FindByName(null, chessboard_str + "d5"), Entities.FindByName(null, chessboard_str + "e5"), Entities.FindByName(null, chessboard_str + "f5"), Entities.FindByName(null, chessboard_str + "g5"), Entities.FindByName(null, chessboard_str + "h5")],
                [Entities.FindByName(null, chessboard_str + "a4"), Entities.FindByName(null, chessboard_str + "b4"), Entities.FindByName(null, chessboard_str + "c4"), Entities.FindByName(null, chessboard_str + "d4"), Entities.FindByName(null, chessboard_str + "e4"), Entities.FindByName(null, chessboard_str + "f4"), Entities.FindByName(null, chessboard_str + "g4"), Entities.FindByName(null, chessboard_str + "h4")],
                [Entities.FindByName(null, chessboard_str + "a3"), Entities.FindByName(null, chessboard_str + "b3"), Entities.FindByName(null, chessboard_str + "c3"), Entities.FindByName(null, chessboard_str + "d3"), Entities.FindByName(null, chessboard_str + "e3"), Entities.FindByName(null, chessboard_str + "f3"), Entities.FindByName(null, chessboard_str + "g3"), Entities.FindByName(null, chessboard_str + "h3")],
                [Entities.FindByName(null, chessboard_str + "a2"), Entities.FindByName(null, chessboard_str + "b2"), Entities.FindByName(null, chessboard_str + "c2"), Entities.FindByName(null, chessboard_str + "d2"), Entities.FindByName(null, chessboard_str + "e2"), Entities.FindByName(null, chessboard_str + "f2"), Entities.FindByName(null, chessboard_str + "g2"), Entities.FindByName(null, chessboard_str + "h2")],
                [Entities.FindByName(null, chessboard_str + "a1"), Entities.FindByName(null, chessboard_str + "b1"), Entities.FindByName(null, chessboard_str + "c1"), Entities.FindByName(null, chessboard_str + "d1"), Entities.FindByName(null, chessboard_str + "e1"), Entities.FindByName(null, chessboard_str + "f1"), Entities.FindByName(null, chessboard_str + "g1"), Entities.FindByName(null, chessboard_str + "h1")]];
occupied_piece_board <- [[Rook(1, "black_rrook"), Knight(1, "black_rknight"), Bishop(1, "black_rbishop"), Queen(1, "black_queen"), King(1, "black_king"), Bishop(1, "black_lbishop"), Knight(1, "black_lknight"), Rook(1, "black_lrook")],
                        [Pawn(1, "black_pawn8"), Pawn(1, "black_pawn7"), Pawn(1, "black_pawn6"), Pawn(1, "black_pawn5"), Pawn(1, "black_pawn4"), Pawn(1, "black_pawn3"), Pawn(1, "black_pawn2"), Pawn(1, "black_pawn1")],
                        [null, null, null, null, null, null, null, null],
                        [null, null, null, null, null, null, null, null],
                        [null, null, null, null, null, null, null, null],
                        [null, null, null, null, null, null, null, null],
                        [Pawn(0, "white_pawn1"), Pawn(0, "white_pawn2"), Pawn(0, "white_pawn3"), Pawn(0, "white_pawn4"), Pawn(0, "white_pawn5"), Pawn(0, "white_pawn6"), Pawn(0, "white_pawn7"), Pawn(0, "white_pawn8")],
                        [Rook(0, "white_lrook"), Knight(0, "white_lknight"), Bishop(0, "white_lbishop"), Queen(0, "white_queen"), King(0, "white_king"), Bishop(0, "white_rbishop"), Knight(0, "white_rknight"), Rook(0, "white_rrook")]];
getCurrentRow <- 0;
getCurrentCol <- 0;
tileMoves <- [];
chessturn <- null;
allCheckedTiles <- [];
allLegalMoves <- [];
threat_piece <- [];
pinned_piece <- {};
whiteKingPosition <- [7, 4];
blackKingPosition <- [0, 4];
promotion_status <- false;
inCheck <- false;

function Cycle_Turns() {
    // Pretty obvious.
    Refresh_Button_Render();
    if (chessturn == 0) {
        chessturn = 1;
        EntFire("white_laser*", "turnon");
        EntFire("white_block_bullet_wall", "enable");
        EntFire("black_laser*", "turnoff");
        EntFire("black_block_bullet_wall", "disable");
    }
    else {
        chessturn = 0;
        EntFire("white_laser*", "turnoff");
        EntFire("white_block_bullet_wall", "disable");
        EntFire("black_laser*", "turnon");
        EntFire("black_block_bullet_wall", "enable");
    }
}

function Refresh_Button_Render() {
    // Refresh button color in each tile to standard white.
    for (local i = 0; i < 8; i++) {
        for (local j = 0; j < 8; j++) {
            chessboard[i][j].__KeyValueFromString("rendercolor", "255 255 255");
            if (occupied_piece_board[i][j] == null) {
                chessboard[i][j].__KeyValueFromString("renderamt", "0");
            }
            else {
                chessboard[i][j].__KeyValueFromString("renderamt", "255");
            }
            
        }
    }
}

function Reset_Pawn_Promotion() {
    // Beginning of every round, check promoted pawn piece and return them to their usual.
    foreach (key, value in occupied_piece_board) {
        foreach (i, j in value) {
            if (j != null) {
                if (j.getPieceName().find("pawn") != null) {
                    Entities.FindByName(null, j.getPieceName()).SetModel("models/chess_model/chess_pawn.mdl");
                }
            }
        }
    }
}

function Chess_Round_Start() {
    local ent = null;
    while (ent = Entities.FindByClassname(ent, "point_teleport")) {
        EntFire(ent.GetName(), "teleport");
    }
    Refresh_Button_Render();
    Reset_Pawn_Promotion();
    Cycle_Turns();
}

function Chess_Round_End() {
    //printl("Checkmate Declared!");
    EntFire("chess_round_end", "trigger");
}

function Is_Piece_Pinned(board) {
    foreach (key, value in pinned_piece) {
        if (value.find(board) != null) {
            return true;
        }
    }
    return false;
}

function OnScriptHook_OnTakeDamage(params) {
    // Check if it's an entity. Common approach.
    if (params.const_entity.IsPlayer()) {
        return;
    }

    // Make sure the entity type is func_button.
    if (params.const_entity.GetClassname() != "func_button") {
        return;
    }

    if (params.const_entity.GetName().find(chessboard_str) != null || params.const_entity.GetName().find("promotion_") != null) {
        Refresh_Button_Render();
        
        // After the pawn has reached the opponent side of the board, player will choose the piece on the side view.
        if (promotion_status) {
            switch (params.const_entity.GetName()) {
                case "promotion_knight":
                    Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName()).SetModel("models/chess_model/chess_knight.mdl");
                    occupied_piece_board[getCurrentRow][getCurrentCol] = Knight(chessturn, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName());
                    break;
                case "promotion_bishop":
                    Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName()).SetModel("models/chess_model/chess_bishop.mdl");
                    occupied_piece_board[getCurrentRow][getCurrentCol] = Bishop(chessturn, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName());
                    break;
                case "promotion_rook":
                    Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName()).SetModel("models/chess_model/chess_rook.mdl");
                    occupied_piece_board[getCurrentRow][getCurrentCol] = Rook(chessturn, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName());
                    break;
                case "promotion_queen":
                    Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName()).SetModel("models/chess_model/chess_queen.mdl");
                    occupied_piece_board[getCurrentRow][getCurrentCol] = Queen(chessturn, occupied_piece_board[getCurrentRow][getCurrentCol].getPieceName());
                    break;
                default:
                    printl("ERROR: No valid button found during promotion status!");
                    return;
            }
            promotion_status = false;
            EntFire("promotion_*", "lock");
            EntFire("chess_light_sideways", "turnoff");
            CheckmateListener();
            Cycle_Turns();
            return;
        }

        // Apply if legal move has been performed.
        if (tileMoves.len() > 0) {
            foreach (index, value in tileMoves) {
                if (params.const_entity.GetName() == value.GetName()) {
                    Apply_Piece_Move(params);
                    tileMoves = [];
                    return;
                }
            }
            
        }

        // Reset tile moves
        tileMoves.clear();
        
        for (local i = 0; i < 8; i++) {
            for (local j = 0; j < 8; j++) {
                if (params.const_entity.GetName() == chessboard[i][j].GetName() && occupied_piece_board[i][j] != null) {
                    chessboard[i][j].__KeyValueFromString("rendercolor", "52 134 235");
                    getCurrentRow = i;
                    getCurrentCol = j;
                    if (occupied_piece_board[i][j] != null) {
                        if (Is_Piece_Pinned(chessboard[i][j])) {
                            if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                                tileMoves = occupied_piece_board[i][j].findPinMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, allCheckedTiles);
                            }
                            else if (inCheck) {
                                // Do Nothing
                            }
                            else {
                                tileMoves = occupied_piece_board[i][j].findPinMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, pinned_piece);
                            }
                        }
                        else if (inCheck) {
                            if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                                tileMoves = occupied_piece_board[i][j].findCheckMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, allCheckedTiles, inCheck);
                            }
                            else {
                                tileMoves = occupied_piece_board[i][j].findCheckMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, threat_piece);
                            }
                        }
                        else {
                            if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                                tileMoves = occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition, false, false, false, allCheckedTiles);
                            }
                            else {
                                tileMoves = occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, getCurrentRow, getCurrentCol, chessturn, whiteKingPosition, blackKingPosition);
                            }
                        }
                        // for (local row = 0; row < 8; row++) {
                        //     for (local col = 0; col < 8; col++) {
                        //         foreach (index, value in tileMoves) {
                        //             if (value.GetName() == chessboard[row][col].GetName()) {
                        //                 if (occupied_piece_board[row][col] != null && occupied_piece_board[row][col].getColor() != occupied_piece_board[getCurrentRow][getCurrentCol].getColor()) {
                        //                     chessboard[row][col].__KeyValueFromString("rendercolor", "112 158 27");
                        //                     chessboard[row][col].__KeyValueFromString("renderamt", "255");
                        //                 }
                        //                 else {
                        //                     chessboard[row][col].__KeyValueFromString("rendercolor", "58 161 75");
                        //                     chessboard[row][col].__KeyValueFromString("renderamt", "255");
                        //                 }
                        //                 break;
                        //             }
                        //         }
                        //     }
                        // }
                        foreach (index, value in tileMoves) {
                            value.__KeyValueFromString("rendercolor", "58 161 75");
                            value.__KeyValueFromString("renderamt", "255");
                        }
                    }
                    return;
                }
            }
        }
    }
}

function Apply_Piece_Move(params) {
    if (tileMoves.len() == 0) {
        return;
    }
    
    for (local i = 0; i < 8; i++) {
        local canBreak = false;
        for (local j = 0; j < 8; j++) {
            if (occupied_piece_board[i][j] != null) {
                if (Entities.FindByName(null, occupied_piece_board[i][j].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                    if (occupied_piece_board[i][j].getPlayedTwoTilesStatus()) {
                        occupied_piece_board[i][j].setPlayedTwoTilesStatus(false);
                        canBreak = true;
                        break;
                    }
                }
            }
        }
        if (canBreak) {
            break;
        }
    }
    for (local i = 0; i < 8; i++) {
        for (local j = 0; j < 8; j++) {
            if (chessboard[i][j].GetName() == params.const_entity.GetName()) {
                local piece = occupied_piece_board[getCurrentRow][getCurrentCol];
                if (occupied_piece_board[i][j] != null) {
                    if (occupied_piece_board[i][j].getColor() != piece.getColor()) {
                        Entities.FindByName(null, occupied_piece_board[i][j].getPieceName()).SetOrigin(Vector(-7670, -6939, 631));
                    }
                }
                else if (Entities.FindByName(null, piece.getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                    if (piece.getColor() == 0) {
                        if (getCurrentCol - 1 >= 0) {
                            if (chessboard[getCurrentRow - 1][getCurrentCol - 1].GetName() == params.const_entity.GetName() && occupied_piece_board[getCurrentRow][getCurrentCol - 1] != null) {
                                if (occupied_piece_board[getCurrentRow][getCurrentCol - 1].getPieceName().find("pawn") != null) {
                                    if (piece.getColor() != occupied_piece_board[getCurrentRow][getCurrentCol - 1].getColor()) {
                                        Entities.FindByName(null, occupied_piece_board[i + 1][j].getPieceName()).SetOrigin(Vector(-7670, -6939, 631));
                                        occupied_piece_board[getCurrentRow][getCurrentCol - 1] = null;
                                    }
                                }
                            }
                        }
                        if (getCurrentCol + 1 < 8) {
                            if (chessboard[getCurrentRow - 1][getCurrentCol + 1].GetName() == params.const_entity.GetName() && occupied_piece_board[getCurrentRow][getCurrentCol + 1] != null) {
                                if (occupied_piece_board[getCurrentRow][getCurrentCol + 1].getPieceName().find("pawn") != null) {
                                    if (piece.getColor() != occupied_piece_board[getCurrentRow][getCurrentCol + 1].getColor()) {
                                        Entities.FindByName(null, occupied_piece_board[i + 1][j].getPieceName()).SetOrigin(Vector(-7670, -6939, 631));
                                        occupied_piece_board[getCurrentRow][getCurrentCol + 1] = null;
                                    }
                                }
                            }
                        }
                    }
                    else if (piece.getColor() == 1) {
                        if (getCurrentCol - 1 >= 0) {
                            if (chessboard[getCurrentRow + 1][getCurrentCol - 1].GetName() == params.const_entity.GetName() && occupied_piece_board[getCurrentRow][getCurrentCol - 1] != null) {
                                if (occupied_piece_board[getCurrentRow][getCurrentCol - 1].getPieceName().find("pawn") != null) {
                                    if (piece.getColor() != occupied_piece_board[getCurrentRow][getCurrentCol - 1].getColor()) {
                                        Entities.FindByName(null, occupied_piece_board[i - 1][j].getPieceName()).SetOrigin(Vector(-7670, -6939, 631));
                                        occupied_piece_board[getCurrentRow][getCurrentCol - 1] = null;
                                    }
                                }
                            }
                        }
                        if (getCurrentCol + 1 < 8) {
                            if (chessboard[getCurrentRow + 1][getCurrentCol + 1].GetName() == params.const_entity.GetName() && occupied_piece_board[getCurrentRow][getCurrentCol + 1] != null) {
                                if (occupied_piece_board[getCurrentRow][getCurrentCol + 1].getPieceName().find("pawn") != null) {
                                    if (piece.getColor() != occupied_piece_board[getCurrentRow][getCurrentCol + 1].getColor()) {
                                        Entities.FindByName(null, occupied_piece_board[i - 1][j].getPieceName()).SetOrigin(Vector(-7670, -6939, 631));
                                        occupied_piece_board[getCurrentRow][getCurrentCol + 1] = null;
                                    }
                                }
                            }
                        }
                    }
                }
                Entities.FindByName(null, piece.getPieceName()).SetOrigin(params.const_entity.GetOrigin());

                occupied_piece_board[i][j] = piece;
                occupied_piece_board[getCurrentRow][getCurrentCol] = null;
                
                if (Entities.FindByName(null, occupied_piece_board[i][j].getPieceName()).GetModelName().find("chess_pawn.mdl") != null) {
                    if (occupied_piece_board[i][j].getMoveCounter() == 0 && (i == 3 || i == 4)) {
                        occupied_piece_board[i][j].setPlayedTwoTilesStatus(true);
                        occupied_piece_board[i][j].addMoveCounter();
                    }
                    occupied_piece_board[i][j].addMoveCounter();
                    if (occupied_piece_board[i][j].getMoveCounter() >= 6) {
                        EntFire("promotion_*", "unlock");
                        EntFire("chess_light_sideways", "turnon");
                        promotion_status = true;
                        getCurrentRow = i;
                        getCurrentCol = j;
                        return;
                    }
                }
                else if (occupied_piece_board[i][j].getPieceName().find("rook") != null) {
                    if (occupied_piece_board[i][j].getCastleStatus()) {
                        occupied_piece_board[i][j].setCastleStatus(false);
                    }
                }
                else if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                    if (occupied_piece_board[i][j].getColor() == 0) {
                        whiteKingPosition = [i, j];
                    }
                    else {
                        blackKingPosition = [i, j];
                    }
                    if (occupied_piece_board[i][j].getCastleStatus()) {
                        occupied_piece_board[i][j].setCastleStatus(false);
                        if (chessboard[getCurrentRow][getCurrentCol - 2].GetName() == params.const_entity.GetName()) {
                            Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol - 4].getPieceName()).SetOrigin(chessboard[getCurrentRow][getCurrentCol - 1].GetOrigin());
                            occupied_piece_board[getCurrentRow][getCurrentCol - 1] = occupied_piece_board[getCurrentRow][getCurrentCol - 4];
                            occupied_piece_board[getCurrentRow][getCurrentCol - 4] = null;
                            occupied_piece_board[getCurrentRow][getCurrentCol - 1].setCastleStatus(false);
                        }
                        if (chessboard[getCurrentRow][getCurrentCol + 2].GetName() == params.const_entity.GetName()) {
                            Entities.FindByName(null, occupied_piece_board[getCurrentRow][getCurrentCol + 3].getPieceName()).SetOrigin(chessboard[getCurrentRow][getCurrentCol + 1].GetOrigin());
                            occupied_piece_board[getCurrentRow][getCurrentCol + 1] = occupied_piece_board[getCurrentRow][getCurrentCol + 3];
                            occupied_piece_board[getCurrentRow][getCurrentCol + 3] = null;
                            occupied_piece_board[getCurrentRow][getCurrentCol + 1].setCastleStatus(false);
                        }
                    }
                }

                CheckmateListener();
                Cycle_Turns();
                return;
            }
        }
    }

    
}

// Scan all the current pieces on board everytime an object has been played. This would be used to manipulate status for the King.
function CheckmateListener() {
    allCheckedTiles.clear();
    allLegalMoves.clear();
    threat_piece.clear();
    pinned_piece.clear();
    for (local i = 0; i < 8; i++) {
        for (local j = 0; j < 8; j++) {
            if (occupied_piece_board[i][j] != null) {
                if (occupied_piece_board[i][j].getColor() == chessturn) {
                    allCheckedTiles.extend(occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, i, j, chessturn, whiteKingPosition, blackKingPosition, true));
                    threat_piece.append(occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, i, j, chessturn, whiteKingPosition, blackKingPosition, false, true));
                    pinned_piece[occupied_piece_board[i][j].getPieceName()] <- occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, i, j, chessturn, whiteKingPosition, blackKingPosition, false, false, true);
                }
            }
        }
    }
    inCheck = false;

    local temp_list = [];
    foreach (index, value in threat_piece) {
        if (value.len() > 1) {
            temp_list.append(value);
        }
    }
    threat_piece = temp_list;

    if (threat_piece.len() > 0) {
        inCheck = true;
        //printl("Check declared!")
    }

    if (inCheck) {
        Test_Piece_Availablility_for_Check();
    }
    else {
        StalemateListener();
    }

    // For debug
    // foreach (index, value in allCheckedTiles) {
    //     value.__KeyValueFromString("rendercolor", "255 0 255");
    // }

    // foreach (index, value in threat_piece) {
    //     foreach (i, j in value) {
    //         j.__KeyValueFromString("rendercolor", "255 0 255");
    //     }
    // }
}

function Test_Piece_Availablility_for_Check() {
    local test_king_available_tiles = (chessturn == 0) ? occupied_piece_board[blackKingPosition[0]][blackKingPosition[1]].findCheckMoves(chessboard, occupied_piece_board, blackKingPosition[0], blackKingPosition[1], 1, whiteKingPosition, blackKingPosition, allCheckedTiles, inCheck) : occupied_piece_board[whiteKingPosition[0]][whiteKingPosition[1]].findCheckMoves(chessboard, occupied_piece_board, whiteKingPosition[0], whiteKingPosition[1], 0, whiteKingPosition, blackKingPosition, allCheckedTiles, inCheck);
    if (test_king_available_tiles.len() > 0) {
        return;
    }
    //printl("Line test")
    for (local i = 0; i < 8; i++) {
        for (local j = 0; j < 8; j++) {
            if (occupied_piece_board[i][j] != null) {
                local available_piece_check = [];
                if (occupied_piece_board[i][j].getColor() != chessturn) {
                    if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                        available_piece_check.extend(occupied_piece_board[i][j].findCheckMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition, allCheckedTiles, inCheck));
                    }
                    else {
                        available_piece_check.extend(occupied_piece_board[i][j].findCheckMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition, threat_piece));
                    }
                }

                if (available_piece_check.len() > 0) {
                    return;
                }
            }
        }
    }

    if (chessturn == 0) {
        ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 White has won by checkmate!");
    }
    else if (chessturn == 1) {
        ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 Black has won by checkmate!");
    }
    Chess_Round_End();
}

function StalemateListener() {
    for (local i = 0; i < 8; i++) {
        for (local j = 0; j < 8; j++) {
            if (occupied_piece_board[i][j] != null) {
                if (occupied_piece_board[i][j].getColor() != chessturn) {
                    if (Is_Piece_Pinned(chessboard[i][j])) {
                        if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                            allLegalMoves.extend(occupied_piece_board[i][j].findPinMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition, allCheckedTiles));
                        }
                        else {
                            allLegalMoves.extend(occupied_piece_board[i][j].findPinMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition, pinned_piece));
                        }
                    }
                    else {
                        if (occupied_piece_board[i][j].getPieceName().find("king") != null) {
                            allLegalMoves.extend(occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition, false, false, false, allCheckedTiles));
                        }
                        else {
                            allLegalMoves.extend(occupied_piece_board[i][j].findLegalMoves(chessboard, occupied_piece_board, i, j, occupied_piece_board[i][j].getColor(), whiteKingPosition, blackKingPosition));
                        }
                    }
                    if (allLegalMoves.len() > 0) {
                        return;
                    }
                }
            }
        }
    }
    ClientPrint(null, 3, "\x0787CEEB[\x0740E0D0Chess Manager\x0787CEEB]\x01 Game has ended in a draw by stalemate! No winner has been decided!");
    Chess_Round_End();
}

if (GetMapName().find("jump_fantasticalwood") != null) {
    Chess_Round_Start();
    __CollectGameEventCallbacks(this);
    printl("Chess script loaded!");
}
else {
    printl("ERROR: No matching mapname has been found!");
}
