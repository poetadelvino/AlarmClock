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

var alarmIsOn: Bool = false

class ViewController: UIViewController {
    
    // global variables for reading user's tune:
    
    var userFinishedPlaying = false
    
    var nrOfTimesUserFailedPlayingTunes = 0
    var maxTryouts = 3
    
    // global variables for wake up notification:
    
    var hourInt: Int = 0
    var minInt: Int = 0
    var secInt: Int = 0
    
    var timeToWakeUp = NSDateComponents()
    
    // sound properties:
    
    var audioPlayer: AVAudioPlayer?
    
    
    // wake up time buttons:
    
    @IBOutlet weak var wakeUpTime: UITextField!
    
    @IBAction func alarmOnButton(sender: UIButton) {
        
        alarmIsOn = true
        setAlarmAndNotificationsOn()
    }
    
    
    @IBAction func alarmOffButton(sender: UIButton) {
        
        alarmIsOn = false
        
        userFinishedPlaying = true
        
        if (tunePlayedByUser == tuneToCopy) {
            // Congratulate User, and turn off the alarm
            instructionTextBox.text = "Congrats!!  Alarm has been turned off"
        }
    }
    
    
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
        

        if (userPlayedWrongNote() == true) {
        // if user played wrong note, start again:
            userDidBad()
        } //if
        else {
        // He played the right note so:
            userDidGood()
        } //else
    } // end upperLeft button
    
//    E-note (blue, lower right);
    @IBAction func lowerRight(sender: UIButton) {
    
        playWavFile("PianoE")
        
        //Now add the note played by user to his tune:
        tunePlayedByUser.append("lr")
        
        //testing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        if (userPlayedWrongNote() == true) {
            // if user played wrong note, start again:
            userDidBad()
        } //if
        else {
            // He played the right note so:
            userDidGood()
        } //else
    }  // end func lowerRight()
    
//    C♯-note (yellow, lower left);
    @IBAction func lowerLeft(sender: UIButton) {
        
                playWavFile("PianoC#")

        //Now add the note played by user to his tune:
        tunePlayedByUser.append("ll")

        // testing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        if (userPlayedWrongNote() == true) {
            // if user played wrong note, start again:
            userDidBad()
        } //if
        else {
            // He played the right note so:
            userDidGood()
        } //else
    } // end func lowerLeft()
    
//    A-note (red, upper right).
    @IBAction func upperRight(sender: UIButton) {
        
        // use new function:
        playWavFile("PianoA")
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("ur")
        
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        if (userPlayedWrongNote() == true) {
            // if user played wrong note, start again:
            userDidBad()
        } //if
        else {
            // He played the right note so:
            userDidGood()
        } //else
    } // end upperRight

    // off button (pressed by User when he finished playing the tune:
    

    
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
        
        if (alarmIsOn == true) {
            startMusicalTest()
        }
        
        // if Alarm time box is not empty, set alarm and nots ON:


    } // end viewDidLoad()
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAlarmAndNotificationsOn() {
        // read Wake up time:
        // hour and minute will be stored in vars: hourInt and minInt
        
        // first see if alarm time box isn't empty:
        if (wakeUpTime == "") {
            instructionTextBox.text = "Please Enter the Wake Up Time and Press Alarm On"
        } else {
            
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

            // now schedule notification:
            UIApplication.sharedApplication().scheduleLocalNotification(wakeUpNotification)
        }// else

    } // end setAlarmAndNotification()
    
    func createNotificationInTenMinutes() {
        
        let wakeUpNotification = UILocalNotification()
        wakeUpNotification.alertBody = "wakeup!!"
        wakeUpNotification.soundName = "coin.wav"
        wakeUpNotification.fireDate = NSDate(timeIntervalSinceNow: 600)
        UIApplication.sharedApplication().scheduleLocalNotification(wakeUpNotification)
    }
    
    func userDidBad() {
        
            if (nrOfTimesUserFailedPlayingTunes < 3) {
                nrOfTimesUserFailedPlayingTunes++
                instructionTextBox.text = "Wrong note, please try again"
                startMusicalTest()
            } else {
                instructionTextBox.text = "Wrong note.  Sorry, you failed more than \(maxTryouts) times.  Notification will come in ten"
                createNotificationInTenMinutes()
                
            } // end else
    } // end func userDidBad()
    
    func userDidGood() {
        
        //if he played the WHOLE tune, congratulate him and turn the alarm and notifications off
        if (tuneToCopy == tunePlayedByUser) {
            instructionTextBox.text = "Well done!!! Alarm is off now!!"
            turnOffAlarmAndNotifications()
            
        } else {
            // if you're here, User has played the right note, but hasn't finished playing ALL the right notes yet.
            // just cheer him:
            instructionTextBox.text = "Go on, you're doing well"
        } // end else
    } // end userDidGood()
}

