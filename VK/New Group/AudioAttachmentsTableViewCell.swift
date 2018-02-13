//
//  AudioTableViewCell.swift
//  VK
//
//  Created by Ринат Хабибуллин on 25.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class AudioAttachmentsTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    var audioAttachments: [AudioAttachments]!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.audioAttachments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let musicTableViewCellNib = UINib(nibName: "MusicTableViewCell", bundle: nil)
        
        tableView.register(musicTableViewCellNib, forCellReuseIdentifier: "MusicTableViewCell")
        
        let musicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        
        musicTableViewCell.name.text = self.audioAttachments[indexPath.row].title
        return musicTableViewCell
        
        // return musicTableViewCell
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
