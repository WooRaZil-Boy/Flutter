//
//  TempView.swift
//  Runner
//
//  Created by 근성가이 on 17/01/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit
import Photos

class TempView: UIView, XibProtocol {
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    
    let assets = DataManager.assetsFromCameraRoll()
    var tapCount = 0
    
    override init(frame: CGRect) { //코드로 생성 시
        super.init(frame: frame)
        initialization("TempView")
    }
    
    required init?(coder aDecoder: NSCoder) { //스토리보드에서 생성 시
        super.init(coder: aDecoder)
        initialization("TempView")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let num = Int(sender.value * 100)
    
        sendImageIndex(num)
    
    }
    
    func getImage(from asset: PHAsset) {
        DataManager.imageManager.requestImage(for: asset, targetSize: DataManager.imageRequestSize, contentMode: .aspectFit, options: nil) { [weak self] result, _ in
            if let thumbnail = result {
                self?.imageView.image = thumbnail
            }
        }
    }
    
    func sendImageIndex(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let imageIndexChannel = appDelegate.imageIndexChannel {
            imageIndexChannel.invokeMethod("receiveIndex", arguments: index)
            //imageIndexChannel.invokeMethod("receiveIndex", arguments: 200)로 Flutter로 역방향 전달 할 수 있다.
        }
    }
}
