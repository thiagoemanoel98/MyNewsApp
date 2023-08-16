//
//  NewsViewController.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 13/08/23.
//

import WebKit

class NewsViewController: UIViewController {
    
    // Conecta o interface builder com o interface component
    @IBOutlet weak var newsWebView:WKWebView!
    @IBOutlet weak var loadingView: UIView!;
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var news: NewsModel? {
        didSet {
            self.title = news?.source.name;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupWebView();
    }
    
    private func setupWebView() {
        self.newsWebView.navigationDelegate = self;
        
        guard let news = news, let url = URL(string: news.url) else { return };
        
        self.newsWebView.load(URLRequest(url: url));
        self.newsWebView.allowsBackForwardNavigationGestures = true;
        
    }

}

extension NewsViewController: WKNavigationDelegate {
    // ver navegacao da webview
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loadingActivityIndicator.startAnimating();
        self.loadingView.isHidden = false;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.isHidden = true;
        self.loadingActivityIndicator.stopAnimating();
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingView.isHidden = true;
        self.loadingActivityIndicator.stopAnimating();
    }
}
