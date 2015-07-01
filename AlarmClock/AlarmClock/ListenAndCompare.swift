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
    
    var comparisonIndex = 0
    while (comparisonIndex <= nrOfElementsToCompare) {
        if tunePlayedByUser[comparisonIndex] != tuneToCopy[comparisonIndex] {
            return(true)
            }

        } // end while
    // if you're here, comparison failed.
    return(false)
} // end userPlayedWrongNote()

func startAgain() {
    
    tunePlayedByUser = []
    
    UserPlayedWrongTuneText.text = "Sorry, wrong note"
    
}

