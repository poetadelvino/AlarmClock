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
    
    // global variables:
    
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
        
        // here's a code from stack overflow on getting a coin sound:
        // Grab the path, make sure to add it to your project!
        var pianoSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CasioPiano", ofType: "wav")!)
        
        // for testing..
        var error: NSError?
        
        audioPlayer = AVAudioPlayer(contentsOfURL: pianoSound, error: &error)
        //print the result of the file retrieval
        println(error)
        audioPlayer?.prepareToPlay()
        
        audioPlayer?.play()
    }
    
//    E-note (blue, lower right);
    
//    C♯-note (yellow, lower left);
    
//    A-note (red, upper right).

    //av player
    
    
    
    // snooze/off buttons:
    


    

    
    func readTextTimeAndStoreAsInts() {
 
        var wakeUpTimeString: String = wakeUpTime.text
        
        println(" here's the wakeup time: \(wakeUpTimeString)")
        
        func textToInts (textTime: String) {
        
            //var fullName = "First Last"
            var textTimeArray = split(textTime) {$0 == ":"}
            var hourText: String = textTimeArray[0]
            var minText: String? = textTimeArray.count > 1 ? textTimeArray[1] : nil
            
            hourInt = hourText.toInt()!
            minInt = minText!.toInt()!
            
            println("\(hourInt) : \(minInt)")
            
        }  // end textToInts

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        readTextTimeAndStoreAsInts()
        //now store wakeup time as a time
        timeToWakeUp.hour = hourInt
        timeToWakeUp.minute = minInt
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

