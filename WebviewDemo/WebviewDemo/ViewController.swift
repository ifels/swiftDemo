//
//  ViewController.swift
//  WebviewDemo
//
//  Created by 聂鑫鑫 on 16/11/29.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController,UIWebViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        //setupViews()
        setupViews2()
    }
    
    
    func setupViews(){
        
        let webView = UIWebView()
        view.addSubview(webView)
        
        webView.backgroundColor = UIColor.black
        webView.scalesPageToFit = true
        webView.isOpaque = false
        
        webView.snp.makeConstraints{ make in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(60)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        webView.delegate = self
        let url = "https://ifels.cn/hualipu_instruction.png"
        //let url = Bundle.main.path(forResource: "hualipu_about", ofType: "png")!;
        //let timeout = Double(1000000.0)
        //let request = URLRequest(url: URL(string:url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: timeout)
        let request = URLRequest(url: URL(string:url)!)
        webView.loadRequest(request)
    }
    
    func setupViews2(){
        
        let scrollView = UIScrollView()
        let imageView = UIImageView()
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        
        let url = URL(string: "https://ifels.cn/hualipu_instruction.png")!
        imageView.kf.setImage(with: url,
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        
        
        scrollView.snp.makeConstraints{ make in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(60)
            make.right.equalTo(view)
            make.bottom.equalTo(2000)
        }
        
        imageView.snp.makeConstraints{ make in
            make.left.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.right.equalTo(scrollView)
        }
        //imageView.image = UIImage(named: "hualipu_instruction")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        print("shouldStartLoadWith")
        return true
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        print("webViewDidStartLoad")
        
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        print("webViewDidFinishLoad")
        
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        print("didFailLoadWithError")
        
    }

}

