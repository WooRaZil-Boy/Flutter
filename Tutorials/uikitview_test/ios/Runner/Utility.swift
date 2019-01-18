//
//  Utility.swift
//  Runner
//
//  Created by 근성가이 on 18/01/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

protocol XibProtocol { }

//MARK: - Initialization
extension XibProtocol where Self: UIView {
    func initialization(_ xibBundleName: String) {
        let view = Bundle.main.loadNibNamed(xibBundleName, owner: self, options: nil)?.first as! UIView //xib파일 찾아서 연결
        view.frame = bounds //현재 뷰의 크기 지정
        view.translatesAutoresizingMaskIntoConstraints = true //오토 사이징 설정
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight] //오토 사이징 적용할 제약사항 : 가로, 세로 모두
        
        addSubview(view) //자신에게 추가
    }
}
