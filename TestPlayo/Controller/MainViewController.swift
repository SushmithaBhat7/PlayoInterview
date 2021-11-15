//
//  MainViewController.swift
//  TestPlayo
//
//  Created by Sushmitha Bhat on 15/11/21.
//

import UIKit
import Alamofire

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var mainTableView: UITableView!
    var totalRes = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: MainTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        fetchFilms()
        mainTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
    
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


}
extension MainViewController {
  func fetchFilms() {

        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=fe72a14cc71248af932ccb972334c3f5")
  
    Alamofire.request(url!, method: .get).responseData {
               response in
               if response.result.isSuccess {
                if let resJson = response.result.value {
//                                    print("JSON: \(resJson)")
                    
//                    self.jsonData = resJson as! NSData
                    DispatchQueue.global(qos: .background).async{
                        do {
                            let root = try JSONDecoder().decode(Base.self, from: resJson )
                            print("\(root)")
                            self.totalRes = root.totalResults!
                            
                            //all fine with jsonData here
                        } catch {
                            //handle error
                            print(error)
                        }
                    }
                    
                      }
               } else {
                print("Fail")
               }
           }
    
    
    
                      
    
    }
  }
