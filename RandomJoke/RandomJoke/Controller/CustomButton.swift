//
//  CustomButton.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 12/5/22.
//

import Foundation
import UIKit

struct IconTextButtonViewModel {
//    let text: String
    let image : UIImage?
}

class CustomButton: UIButton {
    
    private let iconImage: UIImageView = {
        let iconView = UIImageView()
        iconView.tintColor = .blue
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(iconImage )
        clipsToBounds = true
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: IconTextButtonViewModel) {
        iconImage.image = viewModel.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImage.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/2)
    }
}
