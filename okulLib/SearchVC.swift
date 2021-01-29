//
//  SearchVC.swift
//  okulLib
//
//  Created by Mustafa Çağrı Peker on 22.01.2021.
//

import UIKit
import Firebase

class SearchVC: UIViewController , UISearchBarDelegate , UITableViewDelegate , UITableViewDataSource{
    
    

    var currentData = [getBook]()
    var datas = [getBook]()
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "search")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData() // Tabloyu yeniler
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // Search bar ayarları
        
        guard !searchText.isEmpty else {
            currentData = datas
            tableView.reloadData()
            return
        }
        currentData = datas.filter({ (getBook) -> Bool in
            getBook.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
        
    func fetchData() { // Datayı çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("books").whereField("bookstatus", isEqualTo: 0).getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                self.datas.removeAll()
                for document in data!.documents{
                    self.datas.append(getBook(name: document.get("bookname") as! String, author: document.get("author") as! String, description: document.get("bookdesc") as! String, status: document.get("bookstatus") as! Int, image: document.get("imageurl") as! String, date: document.get("date") as! String, reservedUser: document.get("reserveduser") as! String, type: document.get("type") as! String, id: document.documentID as! String))
                }
                self.currentData = self.datas
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search") as! SearchCell
        cell.authorLabel.text = currentData[indexPath.row].author
        cell.bookImage.sd_setImage(with: URL(string: currentData[indexPath.row].image))
        cell.bookNameLabel.text = currentData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RezervasyonPage") as! RezervasyonPage
        vc.book = currentData[indexPath.row]
        self.present(vc, animated: true)
    }
    
    
    

    
    
 

}

