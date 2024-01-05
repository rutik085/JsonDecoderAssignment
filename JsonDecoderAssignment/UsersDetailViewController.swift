//
//  UsersDetailViewController.swift
//  JsonDecoderAssignment
//
//  Created by Mac on 05/01/24.
//

import UIKit

class UsersDetailViewController: UIViewController {
    

    @IBOutlet weak var usersImageView: UIImageView!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var per_pageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var total_pagesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var first_nameLabel: UILabel!
    @IBOutlet weak var last_nameLabel: UILabel!

    var userContainer : University?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        bindImage()
        
    }
    func fetchData()
    {
        pageLabel.text = userContainer?.page.description.codingKey.stringValue
        per_pageLabel.text = userContainer?.per_page.description.codingKey.stringValue
        totalLabel.text = userContainer?.total.description.codingKey.stringValue
        total_pagesLabel.text = userContainer?.total_pages.description.codingKey.stringValue
        
        
        for i in 0...(userContainer?.data.count)!-1
        {
            idLabel.text = userContainer?.data[i].id.description.codingKey.stringValue
            first_nameLabel.text = userContainer?.data[i].first_name.description.codingKey.stringValue
            last_nameLabel.text = userContainer?.data[i].last_name.description.codingKey.stringValue
            emailLabel.text = userContainer?.data[i].email.description.codingKey.stringValue

        }
        
    }
    func bindImage()
    {
        for i in 0...(userContainer?.data.count)!-1
        {
            if let image = userContainer?.data[i].avatar,
               let imageUrl = URL(string: image)
            {
                usersImageView.kf.setImage(with: imageUrl)
            }
        }
    }
  
}
