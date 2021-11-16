//
//  DtailedVewViewController.swift
//  TestPlayo
//
//  Created by Sushmitha Bhat on 16/11/21.
//

import UIKit
import WebKit

class DtailedVewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: WKWebView!
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var links: String = "https://google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        let myURL = URL(string: links)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    func addBackButton() {
        let icon = UIImage(named: "back")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(self.backBtnAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = barButton
    }
    @objc func backBtnAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
