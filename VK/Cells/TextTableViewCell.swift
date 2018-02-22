//
//  TextTableViewCell.swift
//  VK
//
//  Created by Ринат Хабибуллин on 24.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit

protocol UpdateTextTableViewCellHeightDelegate: class {
    func updateHeight(cell: TextTableViewCell)
}
extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}


class TextTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath!
    
    @IBOutlet weak var smallHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bigHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textInfo: UILabel!
    
    weak var delegate: UpdateTextTableViewCellHeightDelegate?
    
    @IBOutlet weak var readAllButton: UIButton!
    @IBAction func readAllButton(_ sender: Any) {
        
        
        self.delegate?.updateHeight(cell: self)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
