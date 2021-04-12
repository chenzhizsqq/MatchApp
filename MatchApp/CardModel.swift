//
//  CardModel.swift
//  MatchApp
//
//  Created by chenzhizs on 2021/04/07.
//

import Foundation

class CardModel{
    func getCards() -> [Card]{
        
        // Declare an empty array to store numbers that we've generated
        var generatedNumbers = [Int]()
        
        
        //an emplty arryy
        var generatedCards = [Card]()
        
        //Random 8 cards
        //for _ in 1...8 {
        while generatedNumbers.count < 8 {
            
            //Generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false {
                
                //Create two new card objects
                let cardOne = Card()
                let cardTwo = Card()
                
                //Set their image names
                cardOne.imageName = "\(randomNumber)"
                cardTwo.imageName = "\(randomNumber)"
                
                //Add ther to the array
                generatedCards.append(cardOne)
                generatedCards.append(cardTwo)
                
                // Add this number to the list of generated numbers
                generatedNumbers.append(randomNumber)
                
                print(randomNumber)
            }
        }
        
        
        //randomize the cards within the array
        generatedCards.shuffle()
        
        //return the array
        return generatedCards
    }
}
