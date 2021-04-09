//
//  ViewController.swift
//  MatchApp
//
//  Created by chenzhizs on 2021/04/05.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        //set the view controller an ther datesource and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Collection View Delegate Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        
        
        //Return it
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Configure the state of the cell based on the properties of the Card that it represents
        
        let cardCell = cell as? CardCollectionViewCell
        
        // Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        
        //Configure it
        cardCell?.configureCell(card: card)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get a referencew to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the status of the card to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            
            // Flip the card up
            cell?.flipUp()
            
            // check if this is the first card that was flipped or the second card
            if firstFlippedCardIndex == nil {
                
                // This is the first card flipped over
                
                firstFlippedCardIndex = indexPath
            }
            else{
                
                // Second card that is flipped
                
                
                // Run the comparison logic
                checkForMatch(indexPath)
            }
        }
//        else {
//            // Flip the card down
//            cell?.flipDown()
//
//        }
    }
    
    // MARK: - Game logic Methods
    func checkForMatch(_ secondFlippedCardIndex:IndexPath){
        
        // Get the two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // Get the two collection view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            // It's a match
            
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }
        else{
            
            // It's not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
        
    }
}

