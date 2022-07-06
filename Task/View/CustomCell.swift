//
//  CustomCell.swift
//  Task
//
//  Created by Sai Balaji on 05/07/22.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell{
    
    static let CELL_ID = "ROW_ID"
    private var ThumbnailImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    private var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CustomCell.CELL_ID)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HELPERS
    func configureUI(){
        addSubview(ThumbnailImageView)
        ThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        ThumbnailImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ThumbnailImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ThumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        ThumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        addSubview(NameLabel)
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        NameLabel.leftAnchor.constraint(equalTo: ThumbnailImageView.rightAnchor,constant: 100).isActive = true
        NameLabel.topAnchor.constraint(equalTo: topAnchor,constant:50).isActive = true
    }
    func updateCell(Name: String,ImageName: String){
        self.NameLabel.text = Name
        self.ThumbnailImageView.image = UIImage(named: ImageName)
    }
}
