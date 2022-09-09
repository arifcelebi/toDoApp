//
//  YapilacakİsGüncelleViewController.swift
//  toDoApp
//
//  Created by Arif Celebi on 9.09.2022.
//

import UIKit

class YapilacakisGüncelleViewController: UIViewController {

    @IBOutlet weak var yapilacakisTextField: UITextField!
    
    var yapilacak:Yapilacaklar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let k = yapilacak{
            
            yapilacakisTextField.text = k.yapilacak_is
            
        }
        
        
    }
    

    @IBAction func guncelle(_ sender: Any) {
        
        if let k = yapilacak ,let ıs = yapilacakisTextField.text {
          
            yapilacaklardao().yapilacakisGuncelle(yapilacak_id: k.yapilacak_id!, yapilacak_is: ıs)
            
        
    }
    }

}
