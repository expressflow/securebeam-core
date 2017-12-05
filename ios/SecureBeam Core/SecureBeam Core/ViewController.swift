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
    @IBOutlet weak var publicKeyLabel: UILabel!
    @IBOutlet weak var publicKeyText: UILabel!
    @IBOutlet weak var privateKeyLabel: UILabel!
    @IBOutlet weak var privateKeyText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.publicKeyLabel.isHidden = true
        
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
            if let cfdata = SecKeyCopyExternalRepresentation(privateKey, &error) {
                let data:Data = cfdata as Data
                let b64PrivateKey = data.base64EncodedString()
                self.privateKeyLabel.isHidden = false
                self.privateKeyText.text = b64PrivateKey
                self.privateKeyText.isHidden = false
            }
            let publicKey = SecKeyCopyPublicKey(privateKey)
            var error:Unmanaged<CFError>?
            if let cfdata = SecKeyCopyExternalRepresentation(publicKey!, &error) {
                let data:Data = cfdata as Data
                let b64Key = data.base64EncodedString()
                self.publicKeyLabel.isHidden = false
                self.publicKeyText.text = b64Key
                self.publicKeyText.isHidden = false
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func touchedBrowseDocuments(_ sender: Any) {
        performSegue(withIdentifier: "browseDocuments", sender: nil)
    }
    
}

