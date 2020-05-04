//
//  ViewController.swift
//  TestCodableProtocol
//
//  Created by Allen Savio on 3/27/19.
//  Copyright © 2019 Allen Savio. All rights reserved.
//

import UIKit
import Mockingjay
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let company = ["name":"Apple", "domain":"iOS"]
        let body: [String: Any] = ["name":"Kyle", "age":"25", "company": company]
        MockingjayProtocol.addStub(matcher: uri("/hello"), builder: json(body))
    }


    @IBAction func tap(_ sender: Any) {
        getUser()
    }
    
    func getUser() {
        Request.getUser.execute.validate().fetchJson { (req: URLRequest?, res: HTTPURLResponse?, user: User) in
            print(user.name)
            print(user.age)
            print(user.company?.name)
            print(user.company?.domain)
            
            let company = user.company
            print(company?.user?.name)
            print(company?.user?.age)
        }
    }
}

class Utils {
    static var superContext: NSManagedObjectContext? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.persistentContainer.viewContext
    }
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}



