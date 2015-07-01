//
//  ViewController.swift
//  AlarmClock
//
//  Created by ernesto on 6/19/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import UIKit
import AVFoundation

// this is vincent's comment

//sparks making a comment
//here's another one
//sparks making a comment
//here's another one

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
    
    
    @IBOutlet weak var SnoozeTime: UITextField!
    
    @IBOutlet weak var Difficulty: UITextField!
    
    // User played wrong tune text field:
    
    
    @IBOutlet weak var UserPlayedWrongTuneText: UITextField!
    
    
    // music buttons:
   
    //    low E-note (green, upper left, an octave lower than blue);
    
    
    @IBAction func lowE(sender: UIButton) {
        
        // First play the note:
        
        // here's a code from stack overflow on getting sound:
        // Grab the path to the file
        //, make sure to add it to your project!
        var gNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoG", ofType: "wav")!)
        
        // for testing..
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: gNote, error: &error)
        //print the result of the file retrieval
        println(error)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("ul")
        
        // comparing:
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            UserPlayedWrongTuneText.text = "Sorry, wrong note"
            } else {
            //do nothing
        } // end if
        
    } // end low E button
    
//    E-note (blue, lower right);
    @IBAction func E(sender: UIButton) {
        var eNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoE", ofType: "wav")!)
        
        // for testing..
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: eNote, error: &error)
        //print the result of the file retrieval
        println(error)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("lr")
        
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            startAgain()

        } else {
            //do nothing
            } // end if
    }
    
//    C♯-note (yellow, lower left);
    @IBAction func C(sender: UIButton) {
        var cNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoC#", ofType: "wav")!)
        
        // for testing..
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: cNote, error: &error)
        //print the result of the file retrieval
        println(error)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("ll")
        
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            UserPlayedWrongTuneText.text = "Sorry, wrong note"
        } else {
            //do nothing
            }
    } // end func C
    
//    A-note (red, upper right).
    @IBAction func A(sender: UIButton) {
        var aNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoA", ofType: "wav")!)
        
        // for testing..
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: aNote, error: &error)
        //print the result of the file retrieval
        println(error)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        //Now add the note played by user to his tune:
        
        tunePlayedByUser.append("ur")
        println("user played: \(tunePlayedByUser)")
        println("user must play: \(tuneToCopy)")
        
        // test if user is playing tune correctly:
        if (userPlayedWrongNote() == true) {
            UserPlayedWrongTuneText.text = "Sorry, wrong note"
        } else {
            //do nothing
            }
    } // end upperRight

    //av player
    
    
    
    // snooze button:
    
    
    // off button (pressed by User when he finished playing the tune:
    
    @IBAction func Off(sender: UIButton) {
        
    userFinishedPlaying = true
        
    }
    
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

        readTextTimeAndStoreAsInts()
        //now store wakeup time as a time
        timeToWakeUp.hour = 21
        timeToWakeUp.minute = 38
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
        
        UIApplication.sharedApplication().scheduleLocalNotification(wakeUpNotification)
        

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // here goes the tune he must copy:
        tuneToCopy = ["ul","ll","lr"]
        playTune(tuneToCopy)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

