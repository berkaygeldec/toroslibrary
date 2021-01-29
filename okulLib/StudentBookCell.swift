

import UIKit

class StudentBookCell: UITableViewCell {

    var titleText = ""
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    var parent : UIViewController?
    var books = [getBook]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(BooksCollectionViewCell.nib(), forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }


    
    
    
}

extension StudentBookCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as! BooksCollectionViewCell
        cell.bind(books[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 285)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = parent?.storyboard?.instantiateViewController(withIdentifier: "RezervasyonPage") as! RezervasyonPage
        vc.book = books[indexPath.row]
        self.parent?.present(vc, animated: true)
    }
    
   
    
    
    
    
}
