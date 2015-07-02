//
//  ReadAndCompare.swift
//  AlarmClock
//
//  Created by ernesto on 6/29/15.
//  Copyright (c) 2015 Pyramidia. All rights reserved.
//

import Foundation

func userPlayedWrongNote () -> Bool {
    var nrOfElementsToCompare = tuneToCopy.count
    
    // if user played one note too many, return true.
    if tunePlayedByUser.count > tuneToCopy.count {
        return (true)
        }
    //if not, see if he's played a correct note:
    for (var i = 0; i < tunePlayedByUser.count; i++) {
        if (tunePlayedByUser[i] != tuneToCopy[i]) {
            
            return (true)
            }
        } // end for
    
    // if you got here, User played right up to now, so return false

    return(false)
    } // end userPlayedWrongNote()

// This function below is called if user played the wrong note.

func startAgain() -> String {
    
    //clear the array that records what the User has played
    tunePlayedByUser = []
    
    return("Sorry, wrong note. Try Again")
    
}

