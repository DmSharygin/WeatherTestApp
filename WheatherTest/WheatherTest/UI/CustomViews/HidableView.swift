//
//  HidableView.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 23.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit

protocol HidableViewDelegate: class {
    func hidableView(_ view: HidableView, touched: UITouch)
    func hidableView(_ view: HidableView, movedWith touch: UITouch)
    func hidableView(_ view: HidableView, dropped touch: UITouch, withEvent event: UIEvent)
}

class HidableView: UIView {

    weak var delegate: HidableViewDelegate? = nil

}
