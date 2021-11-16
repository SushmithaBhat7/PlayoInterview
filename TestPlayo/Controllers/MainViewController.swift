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
    var articleData:NSArray = []
    var data: NSData = NSData()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib(nibName: MainTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        fetchFilms()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let loader =   self.loader()
               DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                   self.stopLoader(loader: loader)
               }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalRes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let item = self.articleData[indexPath.row] as? Articles
        
        cell.authorLabel?.text = item?.author
        cell.descriptionLabel?.text = item?.description
        cell.titleLabel.text = item?.title
        cell.imageViewNews.contentMode = .scaleAspectFit
        
        let url = URL(string: (item?.urlToImage)!)
          let data = try? Data(contentsOf: url!)
          if let imageData = data {
              let image = UIImage(data: imageData)
            cell.imageViewNews.image = image
          }else {
            cell.imageViewNews.image = UIImage(named: "Detail")
          }
       
    
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.articleData[indexPath.row] as? Articles
        let DetailedVC = DtailedVewViewController()
        DetailedVC.links = item?.url ?? "https://google.com"
        let navVC = UINavigationController(rootViewController: DetailedVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    
    func addAlert() {
        let alert = UIAlertController(title: "Long press", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        }
    func loader() -> UIAlertController {
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.large
    loadingIndicator.startAnimating()
    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)
    return alert
    }

func stopLoader(loader : UIAlertController) {
    DispatchQueue.main.async {
        loader.dismiss(animated: true, completion: nil)
    }
}
 }


extension MainViewController {
  func fetchFilms() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=fe72a14cc71248af932ccb972334c3f5")
  
    Alamofire.request(url!, method: .get).responseData {
               response in
               if response.result.isSuccess {
                if let resJson = response.result.value {
                        do {
                            let root = try JSONDecoder().decode(Base.self, from: resJson )
                            
                            print("\(root)")
                            self.totalRes = root.totalResults!
                            
                            let data: [Articles] = root.articles!
                            self.articleData = data as NSArray
                            
                            self.mainTableView.reloadData()
                            //all fine with jsonData here
                        } catch {
                            //handle error
                            print(error)
                        }
                    
                      }
               } else {
                print("Fail")
               }
           }
    }
  }
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}
