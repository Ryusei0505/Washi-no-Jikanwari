//
//  TimeTableController.swift
//  Washi-no-Jikanwari
//
//  Created by Kawai Ryusei on 2021/10/18.
//

import UIKit

class TimeTableController{
    //仮置きの値
    var week:CGFloat = 1
    var flame:CGFloat = 1
    var classes:[[String]] = [[]]
    
    func createFlameWork() -> CGFloat{
        return week * flame
    }
    func getWeek() -> CGFloat{
        return self.week
    }
    func setTimeTableInfo(week: CGFloat,flame: CGFloat){
        self.week = week
        self.flame = flame
    }
    
}
