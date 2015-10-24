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
    
    @IBOutlet weak var display: UILabel!//一个实例，类里面的变量
    var userIsInTheMiddleofTypingANumber: Bool = false//不用担心变量名过长因为Xcode会自动补全
    //对象初始化时同时也必须要初始化变量
    @IBAction func appendDigit(sender: UIButton)//方法method，类里面的函数
    {
        let digit = sender.currentTitle!//let表示常量，一旦设定则无法更改， 感叹号表示解包unwrap optional的值，如果optional的值never been set也就是nil，则程序crash；否则得到optional非空时的类型值，这里是string，因为currentTitle是string？(set)，？表示optional
        //display.text = nil 是合法的，因为.text是string？
        if userIsInTheMiddleofTypingANumber
        {
            display.text = display.text! + digit//必须要加！来unwrap，否则一个optional string类型不可以直接加一个string类型
        }else
        {
            display.text = digit
            userIsInTheMiddleofTypingANumber = true 
        }
        
        
        //print("digit = \(digit)")//会显示在console里面
    }
}

