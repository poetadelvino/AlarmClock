//
//  ReadAndCompare.swift
//  AlarmClock
//
//  Created by ernesto on 6/29/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import Foundation


func startMusicalTest() {
    
    // make a pause (take a deep breath)
    // the first time, and after going wrong
    sleep(3)
    // here goes the tune he must copy:
    tuneToCopy = ["ur","ll","ur","lr"]
    
    // play it if User didn't turn alarm off!:
    if (alarmIsOn == true) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            playTune(tuneToCopy)
        })
    } // end if
    

    
} // end runMusicalTest()

func seeIfUserPlayedWrongNote () -> Bool {
    var nrOfElementsToCompare = tuneToCopy.count
    
    // if user played one note too many, return true.
    if tunePlayedByUser.count > tuneToCopy.count {
        return (true)
        }
    //if not, see if he's played a correct note:
    for (var i = 0; i < tunePlayedByUser.count; i++) {
        if (tunePlayedByUser[i] != tuneToCopy[i]) {
            println("played wrong note!!!")
            return (true)
            }
        } // end for
    
    // if you got here, User played right up to now, so return false
    return(false)
    
    } // end seeIfUserPlayedWrongNote()

// This function below is called if user played the wrong note.

func startAgain() -> String {
    
    //clear the array that records what the User has played
    tunePlayedByUser = []
    return("Sorry, wrong note. Try Again")
    
}

