//
//  ViewController.swift
//  toDoApp
//
//  Created by Arif Celebi on 9.09.2022.
//

import UIKit






class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var yapilacaklarTableView: UITableView!
    
    var yapilacaklarListe = [Yapilacaklar]()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        veritabaniKopyala()
        
        
        yapilacaklarTableView.delegate = self
        yapilacaklarTableView.dataSource = self
        
        searchBar.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        yapilacaklarListe = yapilacaklardao().tumYapilicaklarıAl()
        yapilacaklarTableView.reloadData() 
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    let indeks = sender as? Int
        
        if segue.identifier == "toGuncelle"{
            
            let gidilecekVC = segue.destination as! YapilacakisGüncelleViewController
            gidilecekVC.yapilacak = yapilacaklarListe[indeks!]
            
            
        }
        if segue.identifier == "toDetay"{
            
            let gidilecekVC = segue.destination as! detayViewController
            gidilecekVC.yapilacak = yapilacaklarListe[indeks!]
            
            
        }
        
    
}
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "yapilacaklar", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("yapilacaklar.sqlite")
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("veritabanı zaten var. Kopyalamaya gerek yok")
            
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error)
            }
        }
        
        
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacaklarListe.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yapilacak = yapilacaklarListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "yapilacaklarHucre" , for: indexPath) as! YapilacaklarHucreTableViewCell
        
        
        cell.yapilacakislabel.text = "\(yapilacak.yapilacak_is!)"
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let silAction = UITableViewRowAction(style: .default, title: "Sil", handler: { (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
            
            let yapilacak = self.yapilacaklarListe[indexPath.row]
            
            yapilacaklardao().yapilacakisSil(yapilacak_id: yapilacak.yapilacak_id!)
            
            self.yapilacaklarListe = yapilacaklardao().tumYapilicaklarıAl()
            self.yapilacaklarTableView.reloadData()
            
        })
        
        let guncelleAction = UITableViewRowAction(style: .normal  , title: "Güncelle", handler: { (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
            
           
          
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
            
            
            
            
        })
        
        return [silAction,guncelleAction]
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama sonuç :\(searchText )")
        
        yapilacaklarListe = yapilacaklardao().aramaYap(yapilacak_is: searchText)
        
        yapilacaklarTableView.reloadData()
        
        
    }
    
}
