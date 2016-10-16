//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jonathan Zelaya on 8/10/16.
//  Copyright © 2016 Jonathan Zelaya. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    fileprivate var accumulator = 0.0
    
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    fileprivate var operations: Dictionary<String,Operation> = [
        "π"  : Operation.constant(M_PI),
        "e"  : Operation.constant(M_E),
        "+/-": Operation.unaryOperation({-$0}),
        "√"  : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "+"  : Operation.binaryOperation({$0 + $1}),
        "×"  : Operation.binaryOperation({$0 * $1}),
        "÷"  : Operation.binaryOperation({$0 / $1}),
        "-"  : Operation.binaryOperation({$0 - $1}),
        "="  : Operation.equals,
        "c"  : Operation.clear
    ]
    
    fileprivate enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
        case clear
    }
    
    // receives operation symbol as argument
    func performOperation(_ symbol: String){
        // takes symbol string and checks in operations dictionary for operation
        if let operation = operations[symbol] {
            // switches the corresponding enum operation
            switch operation {
            case .constant(let value): accumulator = value
            case .unaryOperation(let function): accumulator = function(accumulator)
            case .binaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                executePendingOperation() // else do nothing
            case .clear: accumulator = 0; pending = nil
            }
        }
    }
    
    fileprivate func executePendingOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil;
        }
    }
    
    // use this to hold operand before erasing it
    fileprivate var pending: PendingBinaryOperationInfo?
    
    fileprivate struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get{
            return accumulator
        }
    }
}
