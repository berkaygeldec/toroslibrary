
struct Student {
    var name : String
    var schoolNumber : String
    var phoneNumber : String
    var idNumber : String
    
}

import UIKit
import Firebase

class KullanicilarVC: UIViewController ,Observer{
    func observe() {
        fetchData() // Kullanıcı ekledikten sonra çalışacak delegate
    }
    
    func observe2(){
        fetchData()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
        vc.buttonText = "Devam Et"
        vc.imageName = "check"
        vc.labelText = "Kullanıcı Başarıyla Oluşturuldu"
        self.present(vc, animated: true, completion: nil)
    }
    
    

    var studentArray = [Student]()
    
    

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SorumluUserTableViewCell", bundle: nil), forCellReuseIdentifier: "sorumluuser")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData() // Kullanıcıları çeken fonksiyonu çağırdım.
    }
    
    func fetchData() { // Kullancııları çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("users").whereField("status", isEqualTo: "0").getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                self.studentArray.removeAll()
                for document in data!.documents{
                    self.studentArray.append(Student(name: document.get("ad_soyad") as! String, schoolNumber: document.get("kullanici_adi") as! String, phoneNumber: document.get("tel") as! String, idNumber: document.get("tc") as! String))
                }
                print("Resetlendi")
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func addUserAction(_ sender: Any) { // Kullanıcı ekleme butonunun yapacağı işlemler
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "adduser") as! AddUserVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.observer =  self
        self.tabBarController!.present(vc, animated: true, completion: nil)
        
    }

    
}

extension KullanicilarVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sorumluuser", for: indexPath) as! SorumluUserTableViewCell
        cell.bind(studentArray[indexPath.row])
        return cell
    }
    
}
protocol Observer{
    func observe()
    func observe2()
}
