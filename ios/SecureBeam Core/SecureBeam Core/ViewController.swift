//
//  ViewController.swift
//  SecureBeam Core
//
//  Created by Martin Vasko on 04.12.17.
//  Copyright © 2017 expressFlow GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var document: UIDocument?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                print(self.document?.fileURL.lastPathComponent)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func touchedBrowseDocuments(_ sender: Any) {
        performSegue(withIdentifier: "browseDocuments", sender: nil)
    }
    
}

