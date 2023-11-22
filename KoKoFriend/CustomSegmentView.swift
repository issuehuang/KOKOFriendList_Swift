//
//  CustomSegmentView.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/22.
//

import UIKit
protocol CustemSegmontedViewDataSource: AnyObject {
    func itemNumber() -> Int
    func itemTitle(row: Int) -> String
}

protocol CustemSegmontedViewDelegate: AnyObject {
    func didSelect(row: Int) -> Bool
}

class CustomSegmentedView: UIView {
    
    var defaultBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    var segmentedBorderColor: UIColor = .white {
        didSet {
            layer.borderColor = segmentedBorderColor.cgColor
        }
    }
    var defaultTitleColor: UIColor = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1) {
        didSet {
            if btns.count != 0 {
                for item in btns {
                    item.setTitleColor(defaultTitleColor, for: .normal)
                }
            }
        }
    }
    var selectTitleColor: UIColor = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)  {
        didSet {
            if btns.count != 0 {
                for item in btns {
                    item.setTitleColor(selectTitleColor, for: .selected)
                }
            }
        }
    }
    var indicatorViewBackgroundColor: UIColor = .hotPink {
        didSet {
            indicatorView.backgroundColor = indicatorViewBackgroundColor
        }
    }
    var segmentedCornerRadius: CGFloat = 4 {
        didSet {
            layer.cornerRadius = segmentedCornerRadius
        }
    }
    var segmentedBorderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = segmentedBorderWidth
        }
    }
    weak var dataSource: CustemSegmontedViewDataSource? {
        didSet {
            setUI()
        }
    }
    var indicatorViewWidth: CGFloat = 20
    var indicatorViewHeight: CGFloat = 4
    
    var selectNum = 0
    weak var delegate: CustemSegmontedViewDelegate?
    private var titleFontSize: CGFloat = 14
    private var itemCount: Int = 0
    private var indicatorView: UIView!
    private var lastSelectBtn: UIButton!
    var btns: [UIButton] = []
    
    override func layoutSubviews() {
        clipsToBounds = true
        layer.cornerRadius = segmentedCornerRadius
        layer.borderWidth = segmentedBorderWidth
        layer.borderColor = segmentedBorderColor.cgColor
        backgroundColor = defaultBackgroundColor
    }
    
    private func setUI() {
        
        layoutIfNeeded()
        
        itemCount = dataSource?.itemNumber() ?? 0
        if itemCount == 0 {
            return
        }
        
        let itemWidth = frame.width/CGFloat(itemCount)
        
        for i in 0..<itemCount {
            let btn = UIButton(frame: CGRect(x: itemWidth*CGFloat(i), y: 0, width: itemWidth, height: frame.height))
            let title = dataSource?.itemTitle(row: i)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(defaultTitleColor, for: .normal)
            btn.setTitleColor(selectTitleColor, for: .selected)
            btn.tag = i+10
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            if i == 0 {
                lastSelectBtn = btn
                btn.isSelected = true
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleFontSize)
                selectNum = i
            }
            btns.append(btn)
            addSubview(btn)
        }
        
        
        indicatorView = UIView()
        indicatorView.frame.size = CGSize(width: indicatorViewWidth, height: indicatorViewHeight)
        indicatorView.center = CGPoint(x: lastSelectBtn.center.x, y: frame.height)
        indicatorView.backgroundColor = indicatorViewBackgroundColor
        indicatorView.layer.cornerRadius = indicatorViewHeight/2
        addSubview(indicatorView)
    }
    
    func setSelectNum(row: Int) {
        setIndicatorViewPosition(row: row)
    }
    
    @objc private func btnClick(_ sender: UIButton) {
        let row = sender.tag - 10
        if selectNum == row { return }
        setIndicatorViewPosition(row: row)
    }
    
    private func setIndicatorViewPosition(row: Int) {
        
        if !(delegate?.didSelect(row: row) ?? false) { return }
        selectNum = row
        let sender = self.btns[row]
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        if lastSelectBtn == sender { return }
        sender.isSelected = true
        lastSelectBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize) //UIFont.sportFont(ofSize: titleFontSize)
        lastSelectBtn.isSelected = false
        lastSelectBtn = sender
        
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame.size = CGSize(width: self.indicatorViewWidth, height: self.indicatorViewHeight)
            self.indicatorView.center = CGPoint(x: sender.center.x, y: self.frame.height)
        }
    }
    
    private func setSelectNumber(row: Int) {
        
        if row >= btns.count { return }
        selectNum = row
        let sender = self.btns[row]
        sender.isSelected = true
        lastSelectBtn.isSelected = false
        lastSelectBtn = sender
        indicatorView.center = CGPoint(x: sender.center.x, y: sender.center.y+15)
    }
    
    func reloadData() {
        
        btns.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        setUI()
    }
}
