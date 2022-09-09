//
//  Yapilacaklardao.swift
//  toDoApp
//
//  Created by Arif Celebi on 9.09.2022.
//

import Foundation

class yapilacaklardao{
    
    let db:FMDatabase?
    init(){

        let hedefyol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefyol).appendingPathComponent("yapilacaklar.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
        
    }
    
    func tumYapilicaklarıAl() -> [Yapilacaklar]{
        
        var liste = [Yapilacaklar]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM yapilacaklar", values: nil)
        
            while rs.next(){

                let yapilacak = Yapilacaklar(yapilacak_id: Int(rs.string(forColumn: "yapilacak_id"))!, yapilacak_is: rs.string(forColumn: "yapilacak_is")!)
                
                liste.append(yapilacak)
                
                
            }
        
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
        
    }
    func aramaYap(yapilacak_is:String) -> [Yapilacaklar]{
        
        var liste = [Yapilacaklar]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM yapilacaklar WHERE yapilacak_is like '%\(yapilacak_is)%'", values: nil)
        
            while rs.next(){

                let yapilacak = Yapilacaklar(yapilacak_id: Int(rs.string(forColumn: "yapilacak_id"))!, yapilacak_is: rs.string(forColumn: "yapilacak_is")!)
                
                liste.append(yapilacak)
                
                
            }
        
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
        
    }
    
    func yapilacakisEkle(yapilacak_is:String){
        
        db?.open()
        
        do {
          
            try db!.executeUpdate("INSERT INTO yapilacaklar (yapilacak_is) VALUES(?)", values: [yapilacak_is])
            
        
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        
    }
    func yapilacakisGuncelle(yapilacak_id:Int,yapilacak_is:String){
        
        db?.open()
        
        do {
          
            try db!.executeUpdate("UPDATE yapilacaklar SET yapilacak_is = ? WHERE yapilacak_id = ? ", values: [yapilacak_is,yapilacak_id])
            
        
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        
    }
    func yapilacakisSil(yapilacak_id:Int){
        
        db?.open()
        
        do {
          
            try db!.executeUpdate("DELETE FROM yapilacaklar WHERE yapilacak_id = ?", values: [yapilacak_id])
            
        
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        
    }

    
}
