//
//  ViewController.swift
//  AlarmClock
//
//  Created by ernesto on 6/19/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import UIKit
import AVFoundation

// Arrays of tunes:

var tuneToCopy = [String]()
var tunePlayedByUser = [String]()

class ViewController: UIViewController {
    
    // global variables for reading user's tune:
    
    var userFinishedPlaying = false

    // global variables for wake up notification:
    
    var hourInt: Int = 0
    var minInt: Int = 0
    var secInt: Int = 0
    
    var timeToWakeUp = NSDateComponents()
    
    // sound properties:
    
    var audioPlayer: AVAudioPlayer?
    
    
    // wake up time buttons:
    
    @IBOutlet weak var wakeUpTime: UITextField!
    
    
    // User played wrong tune text field:
    
    @IBOutlet weak var instructionTextBox: UITextField!
    
    // music buttons:
   
    //    low E-note (green, upper left, an octave lower than blue);
    @IBAction func upperLeft(sender: UIButton) {
        playWavFile("PianoG")
        //Now add the note to the array that holds the User's tune:
        tunePlayedByUser.append("ul")
        
        // comparing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            instructionTextBox.text = startAgain()
        } // end if
    } // end upperLeft button
    
//    E-note (blue, lower right);
    @IBAction func lowerRight(sender: UIButton) {
        playWavFile("PianoE")
        // now play the note:
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        //Now add the note played by user to his tune:
        tunePlayedByUser.append("lr")
        
        //testing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            instructionTextBox.text = startAgain()
        } // end if
    }  // end func lowerRight()
    
//    C♯-note (yellow, lower left);
    @IBAction func lowerLeft(sender: UIButton) {
        
                playWavFile("PianoC#")

        //Now add the note played by user to his tune:
        tunePlayedByUser.append("ll")

        // testing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            instructionTextBox.text = startAgain()
            } // end if
    } // end func lowerLeft()
    
//    A-note (red, upper right).
    @IBAction func upperRight(sender: UIButton) {
        
        // use new function:
        playWavFile("PianoA")
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("ur")
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            instructionTextBox.text = startAgain()
        } else {
            instructionTextBox.text = "Go on, you're doing well"
        }// end if
    } // end upperRight

    //av player
    
    
    // snooze button:
    
    
    // off button (pressed by User when he finished playing the tune:
    
    @IBAction func Off(sender: UIButton) {
        userFinishedPlaying = true
        
        if (tunePlayedByUser == tuneToCopy) {
            // Congratulate User, and turn off the alarm
            instructionTextBox.text = "Congrats!!  Alarm has been turned off"
            // TODO: turn alarm off!
            }
    } // end Off button
    
    // now lets read the time to rise:
    
    func readTextTimeAndStoreAsInts() {
 
        var wakeUpTimeString: String = wakeUpTime.text

        func textToInts (textTime: String) {
            //var fullName = "First Last"
            var textTimeArray = split(textTime) {$0 == ":"}
            var hourText: String = textTimeArray[0]
            var minText: String? = textTimeArray.count > 1 ? textTimeArray[1] : nil
            
            hourInt = hourText.toInt()!
            minInt = minText!.toInt()!
            }  // end textToInts
        
        textToInts(wakeUpTimeString)
        
        println(" here's the wakeup time in text: \(wakeUpTimeString)")
        // now see if the transformation worked:
        println("and here as ints: \(hourInt) : \(minInt)")

    } // readTextTimeAndStoreAsInts

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if user did NOT play tune right, send notification in 10 sec
        // wakeUpNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        //wakeUpNotification.fireDate = NSDate(
        
        // to cancel all notifications:  
        //UIApplication.sharedApplication().cancelAllLocalNotifications()
        
//   UIApplication.sharedApplication().presentLocalNotificationNow(wakeUpNotification)
        
        // Anounce tune:
        instructionTextBox.text = "Please listen to the tune"
        
    } // end viewDidLoad()
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // here goes the tune he must copy:
        tuneToCopy = ["ur","ll","lr"]
        // play it:
        playTune(tuneToCopy)
        
        // now ask him to play it back:
        
        instructionTextBox.text = "Now play it again Sam"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAlarmOn() {
        // read Wake up time:
        // hour and minute will be stored in vars: hourInt and minInt
        
        readTextTimeAndStoreAsInts()
        //now store wakeup time as a time
        timeToWakeUp.hour = hourInt
        timeToWakeUp.minute = minInt
        timeToWakeUp.second = 0
        timeToWakeUp.day = 1
        timeToWakeUp.month = 1
        timeToWakeUp.year = 1980
        
        let wakeUpDate = NSCalendar.currentCalendar().dateFromComponents(timeToWakeUp)
        
        let wakeUpNotification = UILocalNotification()
        
        wakeUpNotification.fireDate = wakeUpDate
        
        wakeUpNotification.repeatInterval = NSCalendarUnit.CalendarUnitDay
        
        wakeUpNotification.alertBody = "wakeup!!"
        wakeUpNotification.soundName = "coin.wav"

//        UIApplication.sharedApplication().presentLocalNotificationNow(wakeUpNotification)
        // testing:
        //wakeUpNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(wakeUpNotification)

    } // end createNotification()
}

