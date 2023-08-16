//
//  NewsTableViewCell.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 12/08/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceNameLabel: UILabel!;
    @IBOutlet weak var authorLabel: UILabel!;
    @IBOutlet weak var titleLabel: UILabel!;
    @IBOutlet weak var descriptionLabel: UILabel!;
    @IBOutlet weak var imageImageView: UIImageView!;
    @IBOutlet weak var publishLabel: UILabel!;
    @IBOutlet weak var linkImageView: UIImageView!;
        
    public var news: NewsModel? {
        didSet {
            self.sourceNameLabel.text = news?.source.name;
            self.authorLabel.text = news?.author;
            self.titleLabel.text = news?.title;
            self.descriptionLabel.text = news?.description;
            self.imageImageView.loadImage(from: news?.urlToImage);
            
            self.publishLabel.text = news?.publishedAt.toString();
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink));
        self.linkImageView.isUserInteractionEnabled = true;
        self.linkImageView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func openLink() {
        guard let news = news, let url = URL(string: news.url) else { return  };
        UIApplication.shared.open(url);
        
    }
    
}



extension Date {
    func toString(with formatter: String = "dd/MM/yyyy") -> String {
        let dateFormat = DateFormatter();
        
        if Calendar.current.isDateInToday(self) {
            dateFormat.dateFormat = "HH:mm";
            dateFormat.locale = Locale.init(identifier: "pt-br");
            dateFormat.timeZone = TimeZone(abbreviation: "UTC");
            return "Hoje às \(dateFormat.string(from: self))";
        }
        dateFormat.dateFormat = formatter;
        return dateFormat.string(from: self)
    }
}
