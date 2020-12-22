namespace TestingGrounds {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Add() : Int {
        let a = 3;
        let b = 2;
        return a + b;
    }

    @EntryPoint()
    operation Main() : Unit {
        let sum = Add();
    }
}
