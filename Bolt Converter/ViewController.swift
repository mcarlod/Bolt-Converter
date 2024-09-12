//
//  ViewController.swift
//  Bolt Converter
//
//  Created by Carlo Diesta on 9/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imageUrl = URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.fixingsmegastore.co.uk%2Fhelp%2Fmetric-imperial-conversion-table&psig=AOvVaw0gWAgL4MKPtyUFLg3YY355&ust=1726211300410000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJDKwK3svIgDFQAAAAAdAAAAABAE") else {
            print("Invalid URL")
            return
        }
    }

    @IBOutlet weak var boltChartImage: UIImageView!
    
    
}

