//
//  ViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/10/08.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var CollectionViewFlowLayout: UICollectionViewFlowLayout!
        
    let timeTableCon = TimeTableController()
        private let sideMargin: CGFloat = 10
        //private let itemPerWidth: CGFloat = 6
        private let itemSpacing: CGFloat = 5

        override func viewDidLoad() {
            super.viewDidLoad()
            //ここを変更すると枠数を変える
            timeTableCon.setTimeTableInfo(week: 7, flame: 7)
            collectionView.dataSource = self
            collectionView.delegate = self

            let layout = UICollectionViewFlowLayout()
            layout.sectionInset =
                UIEdgeInsets(top: 10,
                             left:sideMargin,
                             bottom: 10,
                             right:sideMargin)
            layout.minimumInteritemSpacing = itemSpacing
            collectionView.collectionViewLayout = layout

        }


    }

    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            Int(timeTableCon.createFlameWork())
        }

        //時間割セルの表示
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録
            cell.backgroundColor = .white// セルの色
            //cell.layer.borderWidth = 1.0//セルの枠組み(有無どっちでもいい)
            return cell
        }
    }

    extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // セルの割当に利用可能なwidth
            // :親viewのwidth - 左右のマージン - セル間の水平方向の間隔 * (列数 - 1)
            let availableWidth = (collectionView.frame.width - sideMargin * 2) - itemSpacing * (timeTableCon.getWeek() - 1)

            // セル一つのwidth
            let width = availableWidth/timeTableCon.getWeek()

            return CGSize(width: width, height: width + 20)
        }
    }
    
    




