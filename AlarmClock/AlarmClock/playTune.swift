//
//  playTune.swift
//  AlarmClock
//
//  Created by ernesto on 6/29/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import Foundation
import AVFoundation

func playTune (sequence: [String]) {
    var audioPlayer: AVAudioPlayer?
    
    // index for sequence, the array of key notes
    var noteNr = 0
    
    
    while (noteNr < sequence.count) {
        switch (sequence[noteNr]) {
            case "ul":
                var gNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoG", ofType: "wav")!)
                
                // for testing..
                var error: NSError?
                audioPlayer = AVAudioPlayer(contentsOfURL: gNote, error: &error)
                //print the result of the file retrieval
                println(error)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                println("ul")
            case "ur":
                println("ur")
            case "ll":
                println("ll")
            case "lr":
                println("lr")
            default:
            
                println("note doesnt exist")
        } // end switch
        
    } // end while loop
} // end playTune