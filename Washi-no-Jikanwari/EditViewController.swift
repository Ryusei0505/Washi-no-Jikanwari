//
//  EditViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/10/28.
//

import UIKit

class EditViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {


    
    
    
    @IBOutlet weak var EditTableView: UITableView!
    
    
    // section毎の画像配列
    let imgArray1:[String] = ["授業曜日","授業数","授業時間"]
    let imgArray2:[String] = ["時間割名"]
    
    
    
    // Sectionのタイトル
    let sectionTitle:[String] = [
         "授業",
         "時間割名",
         "時間割削除"]
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    // Sectionのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return imgArray1.count
        }
        else if section == 1 {
            return imgArray2.count
        }
        else{
            return 0
        }
    }
    
    //セクション内に表示するセルの中身を指定する（返すメソッド）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingCell = EditTableView.dequeueReusableCell(withIdentifier: "EditCell",
                                                     for: indexPath as IndexPath)
        
        switch indexPath.section {
        case 0:
            settingCell.textLabel?.text = imgArray1[indexPath.row]
        case 1:
            settingCell.textLabel?.text = imgArray2[indexPath.row]
        default:
            break
        }
        
        return settingCell
    }
}
    


    
    

      

