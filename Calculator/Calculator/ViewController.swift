//
//  ViewController.swift
//  Calculator
//
//  Created by 黄奕龙 on 15/10/24.
//  Copyright © 2015年 Aaron Hwang. All rights reserved.
//
//最好不要在一个方法里面塞太多代码，可以写更多的方法然后调用那些方法来实现逻辑
import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!//一个实例，类里面的变量，“！”的作用是对这个optional自动unwrap，这样方法中再次使用时就不需要手动再加“！”来unwrap
    var userIsInTheMiddleofTypingANumber: Bool = false//不用担心变量名过长因为Xcode会自动补全
    //var userIsInTheMiddleofTypingANumber = false 可以不用指定类型，通过后面的false自动判断为bool
    
    //对象初始化时同时也必须要初始化变量

    @IBAction func appendDigit(sender: UIButton)//方法method，类里面的函数
    {
        let digit = sender.currentTitle!//let表示常量，一旦设定则无法更改， 感叹号表示解包unwrap optional的值，如果optional的值never been set也就是nil，则程序crash；否则得到optional非空时的类型值，这里是string，因为currentTitle是string？(set)，？表示optional
        //display.text = nil 是合法的，因为.text是string？
        //digit的类型可以从后面的sender.currentTitle!推断出来，因为swift is strongly typed
        if userIsInTheMiddleofTypingANumber
        {
            display.text = display.text! + digit//必须要加“！”来unwrap，否则一个optional string类型不可以直接加一个string类型
        }else
        {
            display.text = digit
            userIsInTheMiddleofTypingANumber = true 
        }
        
        
        //print("digit = \(digit)")//会显示在console里面
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        if userIsInTheMiddleofTypingANumber
        {
            enter()
        }
        
        switch operation
        {
            case "×":performOperation(multiply)//将函数multiply当做一个参数传入，并且可以不需要单独创建一个函数
//            case "÷":performOperation(divide)
//            case "+":
//            case "−":
        default: break
        }
    }
    
    func performOperation(operation :(Double,Double)->Double)//两个Double型的参数，返回一个Double型
    {
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1:Double, op2:Double)->Double
    {
        return op1*op2
    }
    
    @IBAction func enter()//不需要传回参数
    {
        userIsInTheMiddleofTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double
        {
        get
        {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set
        {
            display.text = "\(newValue)"
            userIsInTheMiddleofTypingANumber = false
        }
    }
}

