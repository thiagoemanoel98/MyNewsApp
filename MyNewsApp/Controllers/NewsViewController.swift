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
        guard let news = news, let url = URL(string: news.url) else { return };
        
        self.newsWebView.load(URLRequest(url: url));
        
    }

}
