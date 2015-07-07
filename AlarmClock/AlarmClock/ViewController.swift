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
        
        // tell user what he's done:
        instructionTextBox.text = "Turning alarm off, are you sure?"
        

        
        // store the alarmIsOn "off" status:
        NSUserDefaults.standardUserDefaults().setObject(alarmIsOn, forKey: "alarmIsOnBoolean")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // clear alarm time:
        wakeUpTime.text = ""
        
        // store alarm time as "" (empty)
        NSUserDefaults.standardUserDefaults().setObject(wakeUpTime.text, forKey: "timeAsUserDefault")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        // ?
        userFinishedPlaying = true
        
        // if tune was played the right tune:
        if (tunePlayedByUser == tuneToCopy) {
            
            // Congratulate User:
            instructionTextBox.text = "Congrats!!  Alarm has been turned off"
        } else {
            // send another notification to start in 10 min:
            createNotificationInTenMinutes()
        } // end else
    } // alarmOffButton
    
    // User played wrong tune text field:
    @IBOutlet weak var instructionTextBox: UITextField!
    
    // music buttons:
   
    //    low E-note (green, upper left, an octave lower than blue);
    
    func testIfRightNoteAndAddToUserTune( key: String) {
        if (alarmIsOn == true) {

            if (userPlayedWrongNote() == true)  {
                // if user played wrong note, start again:
                TellUserHeDidBad()
            } //if
            else {
                // He played the right note so:
                TellUserHeDidWell()
                //Add the note the user played to the array that holds the User's tune:
                tunePlayedByUser.append("ul")
            } //end else
            // test: comparing:
            println("user played: \(tunePlayedByUser)")
            println("user must play: \(tuneToCopy)")
        } // end if alarm is on
    } // end testIfRightNote etc..
    
    @IBAction func upperLeft(sender: UIButton) {
        
        playWavFile("PianoG")
        testIfRightNoteAndAddToUserTune("ul")

    } // end upperLeft button
    
//    E-note (blue, lower right);
    @IBAction func lowerRight(sender: UIButton) {
    
        playWavFile("PianoE")
        testIfRightNoteAndAddToUserTune("lr")
        
    }  // end func lowerRight()
    
//    C♯-note (yellow, lower left);
    @IBAction func lowerLeft(sender: UIButton) {
        
        playWavFile("PianoC#")
        testIfRightNoteAndAddToUserTune("ll")
        
    } // end func lowerLeft()
    
//    A-note (red, upper right).
    @IBAction func upperRight(sender: UIButton) {
        
        playWavFile("PianoA")
        testIfRightNoteAndAddToUserTune("ur")
        
    } // end upperRight

    
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
        if (wakeUpTime.text == "") {
            instructionTextBox.text = "Please enter time to wake up"
        } else {
            textToInts(wakeUpTimeString)
          }
        
        println(" here's the wakeup time in text: \(wakeUpTimeString)")
        // now see if the transformation worked:
        println("and here as ints: \(hourInt) : \(minInt)")

    } // readTextTimeAndStoreAsInts

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterForeground", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        didEnterForeground()
        
    } // end viewDidLoad()
    
    func didEnterBackground () {
        // store wake-up time in chip:

        println("im in didEnterBackground")
        NSUserDefaults.standardUserDefaults().setObject(wakeUpTime.text, forKey: "timeAsUserDefault")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // store alarm on-off switch status
        NSUserDefaults.standardUserDefaults().setObject(alarmIsOn, forKey: "alarmIsOnBoolean")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func didEnterForeground(){
        // TODO: check with Pat
        // restore wake-up time from chip to display:
        if let time = NSUserDefaults.standardUserDefaults().objectForKey("timeAsUserDefault") as? String {
            wakeUpTime.text = time
        }  // end iflet
        //  restore alarm on-off switch:
        if let alarmSwitch = NSUserDefaults.standardUserDefaults().objectForKey("alarmIsOnBoolean") as? Bool {
            alarmIsOn = alarmSwitch
        }
        
        // test if value for alarm was saved and restored:
        if (alarmIsOn == true) {
            println(" alarm is on, time hear the tune and play it")
            instructionTextBox.text = "Time to wake up!! Listen to tune and repeat"
            startMusicalTest()
        } else {
            println("alarm is off")
        }
    } // didEnterForeground(...

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
            
            instructionTextBox.text = "Thank you, wakeup time is \(wakeUpTime.text) hs."
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
    
    func TellUserHeDidBad() {
        
            if (nrOfTimesUserFailedPlayingTunes < 3) {
                nrOfTimesUserFailedPlayingTunes++
                instructionTextBox.text = "Wrong note, listen and try again"
                
                // give user some time:
                sleep(3)
                
                // now ask user to play the tune again:
                instructionTextBox.text = "Now try again:"
                startMusicalTest()
                
            } else {
                instructionTextBox.text = "Missed \(maxTryouts) times, try in 10min"
                createNotificationInTenMinutes()
                
            } // end else
    } // end func userDidBad()
    
    func TellUserHeDidWell() {
        
        if (alarmIsOn == true) {
            //if he played the WHOLE tune, congratulate him and turn the alarm and notifications off
            if (tuneToCopy == tunePlayedByUser) {
                instructionTextBox.text = "Well done!!! Alarm is off now!!"
                turnOffAlarmAndNotifications()
                
            } else {
                // if you're here, User has played the right note, but hasn't finished playing ALL the right notes yet.
                // just cheer him:
                instructionTextBox.text = "Go on, you're doing well"
            } // end else
            
        } // end if alarmIsOn
        

    } // end TellUserHeDidWell()
}

