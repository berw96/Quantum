namespace Teleportation {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    operation Teleport(alice : Qubit, bob : Qubit) : Unit  {
            //create a single qubit
            using (register = Qubit[1]){
                //assign qubit to variable
                let temp = register[0];
                //create superposition from qubit
                H(temp);
                //entangle qubits
                Controlled X([temp], bob);
                Controlled X([alice], temp);
                //create superposition from alice's qubit
                H(alice);

                if(M(temp) == One){
                    X(bob);
                    DumpMachine();
                }

                if(M(alice) == One){
                    Z(bob);
                    DumpMachine();
                }
            }
    }

    @EntryPoint()
    operation Main() : Unit {
        //prepare two qubits for use in teleportation
        using (register = Qubit[2]){
            let alice   = register[0];
            let bob     = register[1];
            //apply teleportation to qubits
            Teleport(alice, bob);
            //acknowledge teleportation
            Message("Teleported");
        }
    }
}
