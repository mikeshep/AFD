//: Playground - noun: a place where people can play

///Formalmente un AFD se define como una tupla (Q, Σ, q0, δ, F) donde:
/*
 Q: Conjunto de estados = 4
 Σ: Es un alfabeto = [+,-,*,/,0,1,2,3,4,5,6,7,8,9]
 q0 ∈ Q : El estado inicial = Estado 0
 δ: Q x Σ -> Q : Es una función de transición =
 δ: Q x Σ -> Q = {
 0 x digito = 1,
 1 x digito = 1,
 1 x operador = 2,
 2 x digito = 3,
 3 x digito = 3,
 3 x operador 2
 }
 
 F ⊆ Q : Conjunto de estados finales o de aceptación = Estado 3
 */

/*Tabla de transiciones*/
/*
 Estado Digito Operador FDC
 0         1    Error   Error
 1         1    2       Error
 2         3    Error   Error
 3         3    2       Aceptación
 */

enum Qstate: Int{
    case zero,one,two,three,error, accept
}


/// Defines a alphabet
///
/// - digit: An group that define a sub group of alpahet
/// - op: An group that define a sub group of alpahet
/// - unknow: If the alphabet no exits
enum Alphabet{
    case digit, op, unknow
}

extension Character {
    var isDigit: Bool {
        guard let currentDigit = Int(self.description) else { return false }
        return (0...10).contains(currentDigit)
    }
    
    var isOperator: Bool {
        return ["+","-","/","*"].contains(self.description)
    }
    
    func alphabet() -> Alphabet?{
        if isDigit { return .digit }
        if isOperator { return .op }
        return nil
    }
}


func debugDesctiption(currentState: Qstate, nextState: Qstate, character: Character){
    debugPrint("|currentState: \(currentState), nextState: \(nextState), character: \(character)")
}

//Este es la tabla de transiciones del automata AFD creado
let transitions: [[Qstate]] = [[.one,.error,.error],[.one,.two,.error],[.three,.error,.error],[.three,.two,.accept]]

let initialState: Qstate = .zero
let test = "12+44*344-3+3"
var currentState = initialState
for character in test {
    guard let alphabet: Alphabet = character.alphabet() else {
        debugPrint("Cadena no admitida, error con \(character)")
        break
    }
    let nextState = transitions[currentState.hashValue][alphabet.hashValue]
    guard nextState != .error else {
        debugPrint("Cadena no admitida, error con \(character)")
        break
    }
    debugDesctiption(currentState: currentState, nextState: nextState, character: character)
    currentState = nextState
}

if currentState == .three {
    debugPrint("Cadena admitida")
}

