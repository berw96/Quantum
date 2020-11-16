namespace QuantumRNG {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    //Result is a type which stores a measured qubit
    operation QGenerateRandomBit() : Result {
        using(q = Qubit()){
            H(q);

            return MResetZ(q);
        }
    }

    operation QSampleRandomNumberInRange(max : Int, min : Int) : Int {
        mutable output = 0;
        repeat{
            mutable bits = new Result[0];
            //idxBit is the iterator, 1..BitSizeI(max) is the collection.
            for(idxBit in 1..BitSizeI(max)){
                //Increment the bits variable with a random value on each iteration.
                set bits += [QGenerateRandomBit()];
            }
            //Set the output of the loop as the end result of bits.
            set output = ResultArrayAsInt(bits);
            //Continue iterating until output exceeds limits.
        } until(output <= max and output >= min);
        return output;
    }

    @EntryPoint()
    operation QGenerateRandomNumber() : Int {
        let max = 100;
        let min = 50;
        Message($"Sampling a random number between {min} and {max}: ");
        return QSampleRandomNumberInRange(max, min);
    }

    
}
