using CSM_Gate_Foundation_Server_Core;

class Program {
    static void Main(string[] args) {


        // Starting Gate Foundation Server
        GateFoundationServer.Start(
                args,
                sign: "GFSRR"
            );
    }
}