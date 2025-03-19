import std.stdio;
import std.random;

enum RectilinearBase {
    Vertical,
    Horizontal
}

enum DiagonalBase {
    Diagonal,
    AntiDiagonal
}

struct Qubit {
    RectilinearBase rect;
    DiagonalBase diag;
}

Qubit prepareQubit() {
    if (uniform(0, 2) == 0) {
        return Qubit(RectilinearBase.Vertical, DiagonalBase.Diagonal);
    } else {
        return Qubit(RectilinearBase.Horizontal, DiagonalBase.AntiDiagonal);
    }
}

bool measureQubit(Qubit q, bool useRect) {
    // bob measures in the rectilinear base (true) or diagonal base (false)
    if (useRect) {
        return q.rect == RectilinearBase.Vertical;
    } else {
        return q.diag == DiagonalBase.Diagonal;
    }
}

void main() {
    // Simulate BB84
    Qubit a = prepareQubit();
    
    bool b = uniform(0, 2) == 0;  // true = Rectilinear, false = Diagonal
    bool bMeasure = measureQubit(a, b);

    string baseStr, measureStr;

    if (b) {
        baseStr = "Rectilinear";
    } else {
        baseStr = "Diagonal";
    }

    writeln("Bob's base choice: ", baseStr);

    if (bMeasure) {
        measureStr = "0";
    } else {
        measureStr = "1";
    }

    writeln("Bob's measurement result: ", measureStr);
    writeln("Alice and Bob will only keep the bit if their bases match.");
}
