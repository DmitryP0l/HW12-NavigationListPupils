//
//  ViewController.swift
//  HW12-NavigationListPupils
//
//  Created by lion on 29.10.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
 
    @IBOutlet weak var openTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = "Pupils"
        descriptionLabel.text = "This application is designed for visual control of students. It allows you to instantly access a student's class number and GPA."
        openTableButton.layer.cornerRadius = 10
      
    }

    @IBAction func openTablePressed(_ sender: UIButton) {
      let controller = TableViewController()
        let navigation = UINavigationController(rootViewController: controller)
        present(navigation, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

