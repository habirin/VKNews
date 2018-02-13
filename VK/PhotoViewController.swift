//
//  PhotoViewController.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 25.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit


class PhotoViewController: UIViewController, UIScrollViewDelegate {
    static var photoArray: [PhotoAttachments]!
    static var index: Int!
    
    @IBAction func leftSwipe(_ sender: Any) {
        if PhotoViewController.index < PhotoViewController.photoArray.count - 1 {
            PhotoViewController.index = PhotoViewController.index + 1
            changePhotoWithAnimation()
        }
        
        
        
    }
    @IBAction func rightSwipe(_ sender: Any) {
        if PhotoViewController.index > 0  {
            PhotoViewController.index = PhotoViewController.index - 1
            changePhotoWithAnimation()
        }
    }
    func changePhotoWithAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.photoImage.alpha = 0
            
            self.photoImage.image = UIImage.getImageFromString(stringUrl: PhotoViewController.photoArray[PhotoViewController.index].photo604)
            self.photoImage.alpha = 1
            
        })
        
    }
    
    
    
    @IBAction func doubleTap(_ sender: Any) {
        
        if (photoScrollView.zoomScale > photoScrollView.minimumZoomScale) {
            photoScrollView.setZoomScale(photoScrollView.minimumZoomScale, animated: true)
        } else {
            photoScrollView.setZoomScale(photoScrollView.maximumZoomScale, animated: true)
        }
        
    }
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet var photoScrollView: UIScrollView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoScrollView.minimumZoomScale = 1.0
        photoScrollView.maximumZoomScale = 5.0
        self.photoImage.image = UIImage.getImageFromString(stringUrl: PhotoViewController.photoArray[PhotoViewController.index].photo604)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
