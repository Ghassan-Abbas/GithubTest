//
//  ViewController.swift
//  GithubTest
//
//  Created by MacAdmin on 27/11/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

struct Company {
    var id =  UUID()
    var name: String
    var description: String
    var longitude: String
    var latitude: String
}

struct Course {
    var name : String
    var location: String
    var ageRange : String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var companies = [Company]()
    var workers = ["Hello", "Hello1", "Hello2"]
    
    let ageRanges = ["5-7", "8-11", "12-15"]
    let priceFilters = ["5-10", "10-15", "20-25"]
    
    var courses = [DataSnapshot]()
    var filteredCourses = [DataSnapshot]()
    var filteredItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController()
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        fetchAllCourses()
    }
    
    func fetchAllCourses() {
            let ref = Database.database().reference()

            ref.child("courses").observe(.value, with: { snapshot in
                guard let result = snapshot.children.allObjects as? [DataSnapshot] else { return }
                self.courses = result
                self.filteredCourses = result
                self.tableView1.reloadData()
            })
        }

    func applyFilters(categoryId: String, ageRange: String) {
        filteredCourses = courses.filter { child in
            let ageRangeValue = child.childSnapshot(forPath: "ageRange").value as? String ?? ""
            let categoryIdValue = child.childSnapshot(forPath: "categoryId").value as? String ?? ""
            
            return ageRangeValue == ageRange && categoryIdValue == categoryId
        }
        
        print(filteredCourses)
        tableView1.reloadData()
    }

    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    @IBAction func filterButton(_ sender: Any) {
        applyFilters(categoryId: "29381EDSHAKJH23KH", ageRange: "5-7")
    }
    
    func filteredData() {
        let ref = Database.database().reference()
        
        ref.child("courses").observe(.value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            self.courses = result
            //print(result)
            
            let categoryId = "29381EDSHAKJH23KH"
            
            for child in result {
                let ageRangeValue = child.childSnapshot(forPath: "ageRange").value as! String
                let categoryIdValue = child.childSnapshot(forPath: "categoryId").value as! String
                
                if ageRangeValue == "5-7" && categoryIdValue == categoryId {
                    let snapshot = child.children.allObjects as? [DataSnapshot]
                    
                }
            }
            self.tableView1.reloadData()

        })
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
        return tableView == tableView1 ? filteredCourses.count : workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
                
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "first") as! CourseTableViewCell
            
            if let courseCell = cell as? CourseTableViewCell {
                
                let courseValue = filteredCourses[indexPath.row].value as? NSDictionary
                
                courseCell.courseName.text = courseValue!["name"] as? String
                courseCell.coursePrice.text = courseValue!["price"] as? String
                courseCell.courseAgeRange.text = courseValue!["ageRange"] as? String
            }
            
        }
        
        if tableView == tableView2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "second") as! SecondTableViewCell
        }
        
        
        return cell
    }
    

}

