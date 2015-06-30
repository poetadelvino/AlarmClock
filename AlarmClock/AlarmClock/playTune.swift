//
//  playTune.swift
//  AlarmClock
//
//  Created by ernesto on 6/29/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import Foundation
import AVFoundation

// 4 functions for the 4 notes, upperLeft, lowerLeft, Uu

var audioPlayer: AVAudioPlayer?

func playUpperLeft () {
    var gNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoG", ofType: "wav")!)
    
    // for testing..
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: gNote, error: &error)
    //print the result of the file retrieval
    println(error)
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
}  // playUpperLeft

func playUpperRight () {
    var aNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoA", ofType: "wav")!)
    
    // for testing..
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: aNote, error: &error)
    //print the result of the file retrieval
    println(error)
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
}  // playUpperRight

func playLowerLeft () {
    var cNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoC#", ofType: "wav")!)
    
    // for testing..
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: cNote, error: &error)
    //print the result of the file retrieval
    println(error)
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
}  // playLowerLeft

func playLowerRight () {
    var eNote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PianoE", ofType: "wav")!)
    
    // for testing..
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: eNote, error: &error)
    //print the result of the file retrieval
    println(error)
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
}  // playLowerRight


func playTune (sequence: [String]) {

    
    // index for sequence, the array of key notes
    var noteNr = 0
    while (noteNr < sequence.count) {
        switch (sequence[noteNr]) {
            case "ul":
                playUpperLeft()
            case "ur":
                playUpperRight()
            case "ll":
                playLowerLeft()
            case "lr":
                playLowerRight()
            default:
                println("note doesnt exist")
        } // end switch
        noteNr++
        // make some time..
        for var i=0.0; i < 1000000000; i++ {}
        
    } // end while loop
} // end playTune function
//} // end PlayTuneClass