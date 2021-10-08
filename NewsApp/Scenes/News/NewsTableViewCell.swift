//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by VN01-MAC-0006 on 25/09/2021.
//

import UIKit



class NewsTableViewCell: UITableViewCell , NewsCellView{
    lazy var title : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0

        return lb
        
    }()
    lazy var lbcontent : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        

        return lb
        
    }()
    
    lazy var  publicDate  : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0

        return lb
        
    }()
    
    
    lazy var  thumbnailView  : UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.contentMode = .scaleAspectFit
        return imgV
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(title)
        
        self.contentView.addSubview(lbcontent)
        self.contentView.addSubview(publicDate)
        self.contentView.addSubview(thumbnailView)
        thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5).isActive = true
        thumbnailView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant : 100).isActive = true

        
        title.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor,constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5).isActive = true
//        title.bottomAnchor.constraint(equalTo: lbcontent.topAnchor,constant: -5).isActive = true
        
        lbcontent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        lbcontent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        lbcontent.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor,constant: 5).isActive = true
        lbcontent.bottomAnchor.constraint(equalTo: publicDate.topAnchor,constant: -5).isActive = true

        
        publicDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        publicDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        publicDate.topAnchor.constraint(equalTo: lbcontent.bottomAnchor,constant: 5).isActive = true
        publicDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5).isActive = true
               
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func display(title: String) {
        self.title.text = title
    }
    
    func display(content: String) {
        self.lbcontent.text = content
    }
    
    func display(publicDate: String) {
        self.publicDate.text = publicDate
    }
    
    func display(image: Data) {
        self.thumbnailView.image = UIImage(data: image)
    }

}
