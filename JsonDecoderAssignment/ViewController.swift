//
//  ViewController.swift
//  JsonDecoderAssignment
//
//  Created by Mac on 05/01/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var usersDetailViewController : UsersDetailViewController?
    var usersDetailCollectionViewCell : UsersDetailCollectionViewCell?
    
    @IBOutlet weak var usersDetailCollectionView: UICollectionView!
    

    var data : [University] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonDecodable()
        registerXIBWithCollectionView()
        initializeCollectionView()
    }
    
    func registerXIBWithCollectionView()
    {
        usersDetailCollectionView.dataSource = self
        usersDetailCollectionView.delegate = self
    }
    func initializeCollectionView()
    {
        let uinib = UINib(nibName: "UsersDetailCollectionViewCell", bundle: nil)
        usersDetailCollectionView.register(uinib, forCellWithReuseIdentifier: "UsersDetailCollectionViewCell")
    }
    
    func  jsonDecodable(){
        
        let url = URL(string: "https://reqres.in/api/users?page=2")
        var urlRequest = URLRequest(url: url!)
        let urlSession = URLSession(configuration: .default)
        let urlDatatask = urlSession.dataTask(with: urlRequest) { Data, Response, Error in
            let urlResponse = try! JSONSerialization.jsonObject(with: Data!) as! [String : Any]
          
            let userDictionary = urlResponse as! [String : Any]
            let studentPage = urlResponse["page"] as! Int
            let studentPerPage = urlResponse["per_page"] as! Int
            let studentTotal = urlResponse["total"] as! Int
            let studentTotalPages = urlResponse["total_pages"] as! Int
            let data = urlResponse["data"] as! [[String : Any]]
            
            for dataResponse in data
            {

                let studentId = dataResponse["id"] as! Int
                let studentEmail = dataResponse["email"] as! String
                let studentFirstName = dataResponse["first_name"] as! String
                let studentLastName = dataResponse["last_name"] as! String
                let studentAvatar = dataResponse["avatar"] as! String
                
                let dataObject = Datas(id: studentId, first_name: studentFirstName, last_name: studentLastName, avatar: studentAvatar, email: studentEmail)
                
                let usersObject = University(page: studentPage, per_page: studentPerPage, total: studentTotal, total_pages: studentTotalPages, data: [dataObject])
                
                self.data.append(usersObject)
                print(self.data)
            }
            DispatchQueue.main.async {
                self.usersDetailCollectionView.reloadData()
            }
            
        }
        urlDatatask.resume()
    }
}
extension ViewController : UICollectionViewDelegate{
   
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            usersDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UsersDetailViewController") as! UsersDetailViewController
            
            usersDetailViewController?.userContainer = data[indexPath.row]
            navigationController?.pushViewController(usersDetailViewController!, animated: true)
            
        }
    
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let spaceBetweenTheCells : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
            
            let size = (usersDetailCollectionView.frame.width - spaceBetweenTheCells) / 2.0
            
            return CGSize(width: size, height: size)
    }
}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            usersDetailCollectionViewCell = self.usersDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "UsersDetailCollectionViewCell", for: indexPath) as! UsersDetailCollectionViewCell
            usersDetailCollectionViewCell?.userPageLabel.text = String(data[indexPath.row].page)
            for i in 0...data[indexPath.row].data.count-1
            {
                usersDetailCollectionViewCell?.first_name.text = data[indexPath.row].data[i].first_name.description.codingKey.stringValue
                
                usersDetailCollectionViewCell?.last_name.text = data[indexPath.row].data[i].last_name.description.codingKey.stringValue
                
            }
            
            return usersDetailCollectionViewCell!
        }
    }
