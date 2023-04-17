//
//  CustomViewButton.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-17.
//

import UIKit

protocol CustomViewButtonDelegate: AnyObject {
    func customViewButtonTapped(sender: CustomViewButton)
}

@IBDesignable
class CustomViewButton: UIView {
    
    // MARK: - Properties
    var view: UIView!
    
    // MARK: - Delegate
    weak var delegate: CustomViewButtonDelegate?
    
    // MARK: - @IBOutlet
    @IBOutlet weak var customButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func customButtonTapped(_ sender: Any) {
        delegate?.customViewButtonTapped(sender: self)
    }
    
    // MARK: - @IBInspectable
    @IBInspectable var title: String = "title" {
        didSet {
            customButton.setAttributedTitle(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
        }
    }
    
    @IBInspectable var color: UIColor = .white {
        didSet {
            customButton.tintColor = color
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 4 {
        didSet {
            customButton.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.appColor(DKColor.LightGray) {
        didSet {
            customButton.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            customButton.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Load View
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomViewButton", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
        
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        
    }
}
