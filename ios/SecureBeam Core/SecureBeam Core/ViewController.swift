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

    @IBAction func touchedGenerateKeyPair(_ sender: Any) {
        let tag = "com.securebeam.core".data(using: .utf8)!
        let attributes: [String: Any] =
            [kSecAttrKeyType as String:            kSecAttrKeyTypeRSA,
             kSecAttrKeySizeInBits as String:      2048,
             kSecPrivateKeyAttrs as String:
                [kSecAttrIsPermanent as String:    true,
                 kSecAttrApplicationTag as String: tag]
        ]
        var error: Unmanaged<CFError>?
        do {
            guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
                throw error!.takeRetainedValue() as Error
            }
            let publicKey = SecKeyCopyPublicKey(privateKey)
        } catch {
            print(error)
        }
    }
    
    @IBAction func touchedBrowseDocuments(_ sender: Any) {
        performSegue(withIdentifier: "browseDocuments", sender: nil)
    }
    
}

