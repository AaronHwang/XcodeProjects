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
    
    @IBAction func operate(sender: UIButton)//传回参数为sender，类型为UIbutton
    {
        let operation = sender.currentTitle!//传回参数的名称currentTitle用来辨识
        if userIsInTheMiddleofTypingANumber
        {
            enter()
        }
        
        switch operation
        {
//            case "×":performOperation(multiply)//将函数multiply当做一个参数传入，并且可以不需要单独创建一个函数
//        case "×":performOperation({ (op1:Double, op2:Double)->Double in
//            return op1*op2
//        case "×":performOperation({ (op1, op2)in return op1*op2})//自动判断类型
//            case "×":performOperation({ (op1, op2)in op1*op2})//自动判断返回值
//            case "×":performOperation({ $0*$1 })//不需要命名变量
            case "×":performOperation(){ $0*$1 }//最后的参数可以放在花括号外面
            case "÷":performOperation {$1/$0}//不要括号也可以
            case "+":performOperation {$1+$0}
            case "−":performOperation {$1-$0}
            case "√":performOperation {sqrt($0)}
        default: break
        }
    }
    
    func performOperation(operation :(Double,Double)->Double)//两个Double型的参数，返回一个Double型
    {
        if operandStack.count >= 2//stack中至少有两个操作数
        {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation :Double->Double)//同样的函数名，只有一个参数
    //Objective-C 不支持函数重载。代码中ViewController继承了UIViewController，而UIViewController是Objective-C的代码，所以会报错。如果你把继承关系去掉，就不会报错了。obj-c不支持function overloading，但是swift支持，如果swift类里overloading的函数被obj-c调用的话，很可能crash,因此新版本的swift会报编译错误。解决这个问题不需要把函数重命名，把函数定义为private就可以了
    {
        if operandStack.count >= 1//stack中至少有两个操作数
        {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
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
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue//得到display中的字符串并转换为Double
        }
        set
        {
            display.text = "\(newValue)"//将数字转换为字符串
            userIsInTheMiddleofTypingANumber = false
        }
    }
}

