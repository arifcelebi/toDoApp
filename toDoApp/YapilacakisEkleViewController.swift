//
//  YapilacakİsEkleViewController.swift
//  toDoApp
//
//  Created by Arif Celebi on 9.09.2022.
//

import UIKit

class YapilacakisEkleViewController: UIViewController {

    @IBOutlet weak var yapilacakisTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ekle(_ sender: Any) {
        
        if let ıs = yapilacakisTextField.text {
           
            yapilacaklardao().yapilacakisEkle(yapilacak_is: ıs)
            
        }
    }
    

}
