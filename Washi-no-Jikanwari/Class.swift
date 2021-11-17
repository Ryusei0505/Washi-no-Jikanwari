//
//  InputViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/10/29.
//

import UIKit

//保存したい教室名などを格納したクラス
class Class: NSObject, NSCoding {


    let className: String
    let roomName: String
    let cellNumber: Int

    init(className: String, roomName: String, cellNumber: Int) {

        self.className = className
        self.roomName = roomName
        self.cellNumber = cellNumber
    }

    func encode(with acoder: NSCoder) {
        acoder.encode(self.className, forKey: "name")
        acoder.encode(self.roomName, forKey: "room")
        acoder.encode(self.cellNumber, forKey: "number")
    }

    required init?(coder aDecoder: NSCoder) {
        self.className = aDecoder.decodeObject(forKey: "name") as! String
        self.roomName = aDecoder.decodeObject(forKey: "room") as! String
        self.cellNumber = aDecoder.decodeInteger(forKey: "number")
    }
}



class Edit: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var subjectTextField: UITextField!

    @IBOutlet weak var roomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //入力フォームの薄文字
        subjectTextField.placeholder = "科目名を入力してください"
        roomTextField.placeholder = "教室名を入力してください"
        
    }


    @IBAction func comitButtom(_ sender: UIButton) {
        //入力データ保存
        
        let classData = Class(className:subjectTextField.text!, roomName: roomTextField.text!, cellNumber: ViewController.cellNumber)
        ViewController.testArray.append(classData)
        
         
        let data = try! NSKeyedArchiver.archivedData(withRootObject: ViewController.testArray , requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: "TimeTable")
        UserDefaults.standard.synchronize()
        print("配列の中身:\(ViewController.testArray)")
        
    }
    
}



