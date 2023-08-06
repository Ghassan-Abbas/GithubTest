//
//  ViewController.swift
//  GithubTest
//
//  Created by MacAdmin on 27/11/2022.
//

import UIKit
import FirebaseFirestore

struct Company {
    var id =  UUID()
    var name: String
    var description: String
    var longitude: String
    var latitude: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var companies = [Company]()
    var workers = ["Hello", "Hello1", "Hello2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTableView1()
        
    }
    
    func fetchTableView1() {
        let db = Firestore.firestore()
        
        db.collection("Company").addSnapshotListener({
            (snapshot, error) in guard let result = snapshot?.documents else {return}
            
            for document in result {
                print(document)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tableView1 ? companies.count : workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "first") as! FirestoreTableViewCell
        }
        
        if tableView == tableView2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "second") as! SecondTableViewCell
        }
        
        
        return cell
    }
    

}

