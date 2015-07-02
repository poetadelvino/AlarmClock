//
//  AlarmAndNotifFunctions.swift
//  AlarmClock
//
//  Created by ernesto on 7/1/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import Foundation
import UIKit


func turnOffAlarmAndNotifications(){
    
    // turn alarm switch off:
    alarmIsOn = false
    
    // now clear all notifications:
    UIApplication.sharedApplication().cancelAllLocalNotifications()
}

