//
//  DataManager.swift
//  Runner
//
//  Created by 근성가이 on 18/01/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Photos

class DataManager {
    static let imageManager = PHImageManager.default()
    static let imageRequestSize = CGSize(width: 180, height: 180)
    
    class func assetsFromCameraRoll(_ isVideoType: Bool = false) -> [PHAsset] {
        let tomorrowDate = NSDate(timeIntervalSinceNow:24 * 60 * 60)
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d && creationDate < %@", PHAssetMediaType.video.rawValue, PHAssetMediaType.image.rawValue, tomorrowDate) //이미지와 동영상 모두 불러옴
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] //최신 순 정렬
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        let normalResultArr = assetsFromFetchResult(fetchResult)
        
        return normalResultArr
    }
    
    class func assetsFromFetchResult(_ fetchResult: PHFetchResult<PHAsset>) -> [PHAsset]{
        var assets = [PHAsset]()
        
        fetchResult.enumerateObjects({ (asset, _, _) in //클로저 (Objective-c Block)로 asset가져옴
            assets.append(asset)
        })
        
        print("카메라롤 수 :: \(assets.count)")
        
        return assets
    }
}


