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


class ViewController: UIViewController {
    
    
    // global variables for reading user's tune:
    
    var userFinishedPlaying = false
    var tunePlayedByUser = [String]()
    
    // global variables for wake up notification:
    
    var hourInt: Int = 0
    var minInt: Int = 0
    var secInt: Int = 0
    
    var timeToWakeUp = NSDateComponents()
    
    // sound properties:
    
    var audioPlayer: AVAudioPlayer?
    
    // text buttons:
    
    // wake up time:
    
    
    
    @IBOutlet weak var wakeUpTime: UITextField!
    
    
    @IBOutlet weak var SnoozeTime: UITextField!
    
    @IBOutlet weak var Difficulty: UITextField!
    
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
    }
    
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
    }
    
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
    }

    //av player
    
    
    
    // snooze button:
    
    
    // off button:
    
    
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
        
        // test of sound:
        playTune(["ul","ur","ur","ll","lr"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

