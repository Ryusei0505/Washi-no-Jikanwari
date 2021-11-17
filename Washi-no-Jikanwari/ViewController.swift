//
//  ViewController.swift
//  Washi-no-Jikanwari
//
//  Created by Shogo Taguchi on 2021/10/08.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    

    static var cellNumber: Int = 0

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    static var testArray: [Class] = []

    
    @IBOutlet weak var CollectionViewFlowLayout: UICollectionViewFlowLayout!
        
    
    var weeks:[String] = ["月曜","火曜","水曜","木曜","金曜","土曜"]
    var flames:[String] = ["1限","2限","3限","4限","5限","6限","7限","8限","9限"]
    
    
    let timeTableCon = TimeTableController()
    private let sideMargin: CGFloat = 5
       private let itemSpacing: CGFloat = 2
       private let lineSpacing: CGFloat = 2
       private let week:CGFloat = 5
       private let flame:CGFloat = 7
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //ここを変更すると枠数を変える
        timeTableCon.setTimeTableInfo(week: self.week, flame: self.flame)
        createFlameHedder()
        createWeekHedder()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self

        
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset =
            UIEdgeInsets(top: 0,
                         left:sideMargin,
                         bottom: 10,
                         right:sideMargin)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        collectionView.collectionViewLayout = layout
        
        

    }

    
    
    func createFlameHedder(){
        let availableHeight = (collectionView.frame.height - 10) - lineSpacing * (timeTableCon.getFlame() - 1)
        let height = availableHeight/timeTableCon.getFlame()
        timeTableCon.setFlameSize(flameSize: height)
        var offset: CGFloat = timeTableCon.getFlameSize()/2 + collectionView.frame.minY
        
        
        for i in 0...Int(timeTableCon.getFlame() - 1) {
            let flameLabel = UILabel()
            //flameLabel.adjustsFontForContentSizeCategory = true
            flameLabel.minimumScaleFactor = 0.3
            flameLabel.text = flames[i]
            flameLabel.adjustsFontSizeToFitWidth = true
            flameLabel.numberOfLines = 0;
            // viewにラベルを追加
            flameLabel.sizeToFit()
            view.addSubview(flameLabel)
            // AutoLayoutとバッティングしないためFalse
            flameLabel.translatesAutoresizingMaskIntoConstraints = false

            // 大本のViewとX軸中心合わせ
            flameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            // Top Anchorは大本のViewに合わせる(オフセットでずらす。）
            flameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
           
            
            offset += timeTableCon.getFlameSize() + lineSpacing
        }
    }
    
    func createWeekHedder(){
        let availableWidth = (collectionView.frame.width - sideMargin * 2) - itemSpacing * (timeTableCon.getWeek() - 1)
        let width = availableWidth/timeTableCon.getWeek()
        timeTableCon.setWeekSize(weekSize: width)
        var offset: CGFloat = timeTableCon.getWeekSize()/2 + collectionView.frame.minX + 2*itemSpacing
        let labelHeight = collectionView.topAnchor
        for i in 0...Int(timeTableCon.getWeek() - 1) {
            let weekLabel = UILabel()
            weekLabel.adjustsFontForContentSizeCategory = true
            weekLabel.adjustsFontSizeToFitWidth = true
            weekLabel.minimumScaleFactor = 0.3
            weekLabel.text = weeks[i]
            weekLabel.adjustsFontSizeToFitWidth = true
            
            // viewにラベルを追加
            view.addSubview(weekLabel)
            // AutoLayoutとバッティングしないためFalse
            weekLabel.translatesAutoresizingMaskIntoConstraints = false

            // constraints
            weekLabel.sizeToFit()
            
            //位置調整のおまじない
            if(i==0){
                offset -= weekLabel.bounds.width/2
            }
            
            // 大本のViewとX軸中心合わせ
            weekLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset).isActive = true
            
            // Top Anchorは大本のViewに合わせる(オフセットでずらす。）
            weekLabel.topAnchor.constraint(equalTo: labelHeight,constant: -1*timeTableCon.getFlameSize()/5).isActive = true
            
            
            offset += timeTableCon.getWeekSize() + itemSpacing
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {

        //key"TimeTable"に保存されたデータ取得
        if let data = UserDefaults.standard.object(forKey: "TimeTable")as? Data{
           if let array = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Class]{
                ViewController.testArray = array
                print("array:\(array)")
            }else{
                
                print("NoData")
            }
            print("testArray:\(ViewController.testArray)")
            collectionView.reloadData()
        
    }

    }

    
    //セル選択時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        ViewController.cellNumber = indexPath.row

        if ViewController.cellNumber == indexPath.row {
            print("セル番号:\(indexPath.row)")
        }

        performSegue(withIdentifier: "Modall", sender: self)
    }

    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Int(timeTableCon.createFlameWork())
    }
    
    
    
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1.0
 
        if let data = ViewController.testArray.first(where: { $0.cellNumber == indexPath.row }) {
            cell.subjectLabel.text = data.className
            cell.roomLabel.text = data.roomName
        } else {
            cell.subjectLabel.text = ""
            cell.roomLabel.text = ""
        }

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: timeTableCon.getWeekSize(), height: timeTableCon.getFlameSize())
    }

    
    //ViewControlollerに戻るためのunwindSegue(時間割入力時)
    @IBAction func returenSegue(segue: UIStoryboardSegue){
        viewWillAppear(true) //再読み込み
    }
    
    //ViewControlollerに戻るためのunwindSegue(全時間割削除時)
    @IBAction func returenResetSegue(segue: UIStoryboardSegue){
        viewWillAppear(true)//再読み込み
    }
    
}
    



    
    




