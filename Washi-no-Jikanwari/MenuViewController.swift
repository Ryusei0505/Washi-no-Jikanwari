//
//  MenuViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/10/08.
//

import UIKit

class MenuViewController: UIViewController
                          ,UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var TableView: UITableView!
    
    //配列settingsを設定
    let settings = ["時間割作成", "時間割削除", "テーマ設定", "通知設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.delegate=self
        TableView.dataSource = self
        
    }
    
    @IBOutlet weak var mapView: UIView!
    
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
    //メニュー表示設定
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // メニューの位置を取得する
        let menuPos = self.mapView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.mapView.layer.position.x = -self.mapView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.mapView.layer.position.x = menuPos.x
        },
            completion: { bool in
        })
        
    }

    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.mapView.layer.position.x = -self.mapView.frame.width
                },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                }
                )
            }
        }
    }
    


    
    //setting配列数取得
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
        
    //TableViewCell指定、取得
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            // セルを取得する
            let cell: UITableViewCell = TableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = settings[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
          // セルの選択を解除
          // 遷移前にセルの選択状態を解除しておかないと、Appleの審査に落ちることがあるらしい
          tableView.deselectRow(at: indexPath, animated: true)
          
          // performSegue(withIdentifier: "toTestView", sender: nil)

          // 別の画面に遷移
          switch indexPath.row {
          case 0:
              performSegue(withIdentifier: "S1", sender: nil)
          case 1:
              performSegue(withIdentifier: "S2", sender: nil)
          case 2:
              performSegue(withIdentifier: "S3", sender: nil)
          case 3:
              performSegue(withIdentifier: "S4", sender: nil)
          default:
              break
          }
      }
    
    
    

    
    
    
    
    
    
    
}
    
