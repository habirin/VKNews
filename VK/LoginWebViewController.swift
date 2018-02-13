//
//  LoginWebViewController.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class LoginWebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loginWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loginWebView.delegate = self
        
        loginWebView.loadRequest(URLRequest(url: URL(string: "https://oauth.vk.com/authorize?client_id=6116575&scope=139286&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&response_type=token&v=5.67&revoke=1")!))
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let webViewResponseAfterParsing = request.url!.absoluteString.components(separatedBy: ["=", "&"])
        for answer in webViewResponseAfterParsing {
            if answer.characters.count >= 85 && answer.characters.count <= 90 {
                let accessToken = answer
                ServerManager.init(accessToken: accessToken)
                webView.removeFromSuperview()
                performSegue(withIdentifier: "NewsFeedSegue", sender: nil)
            }}
        
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
