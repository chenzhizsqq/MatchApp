//
//  ViewController.swift
//  MatchApp
//
//  Created by chenzhizs on 2021/04/05.
//

import UIKit

class ViewController: UIViewController {

    let model = CardModel()
    var cardsArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
    }


}

