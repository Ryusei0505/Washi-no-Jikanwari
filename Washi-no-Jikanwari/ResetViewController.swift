//
//  ResetViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/11/10.
//  userDefault 時間割入力データ削除クラス (キーはTimeTable)

import UIKit

class ResetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetButton(_ sender: Any) {
        //削除処理
        UserDefaults.standard.removeObject(forKey: "TimeTable")
        ViewController.testArray.removeAll() //配列testArrayの消去
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
