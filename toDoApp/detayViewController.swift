//
//  detayViewController.swift
//  toDoApp
//
//  Created by Arif Celebi on 9.09.2022.
//

import UIKit

class detayViewController: UIViewController {

    @IBOutlet weak var yapilacakisLabel: UILabel!
    
    var yapilacak:Yapilacaklar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let k = yapilacak{
            
            yapilacakisLabel.text = k.yapilacak_is
            
        }
        
    }
    

 
  

}
