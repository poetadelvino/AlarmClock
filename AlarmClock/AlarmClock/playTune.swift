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

func playTune (sequence: [String]) {
    
    // Anounce:

    // noteNr is the index for the array of notes user must play
    var noteNr = 0
    
    // while there's still a note to be played, continue playing..
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
        
        sleep(1)
        
    } // end while loop
} // end playTune function

// the 4 functions to play the 4 notes:
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

func playWavFile(fileName: String) {
    
    var noteFile = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "wav")!)
    
    // for testing..
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: noteFile, error: &error)
    //print the result of the file retrieval
    println(error)
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()

}
