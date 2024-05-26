//
//  ViewController.swift
//  MixColors
//
//  Created by Alexander Bokhulenkov on 25.05.2024.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {

//    MARK: - Properties
    
 
    @IBOutlet weak var firstColorButton: UIButton!
    @IBOutlet weak var firstColorLabel: UILabel!
    
    @IBOutlet weak var secondColorLabel: UILabel!
    @IBOutlet weak var secondColorButton: UIButton!
    
    @IBOutlet weak var resultColor: UIButton!
    
    var activityButton: UIButton?
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialColors()
    }

//    MARK: - Helpers
    
//    установка начальных значений
    func initialColors() {
        firstColorButton.backgroundColor = .red
        firstColorLabel.text = firstColorButton.backgroundColor?.accessibilityName
        
        secondColorButton.backgroundColor = .blue
        secondColorLabel.text = secondColorButton.backgroundColor?.accessibilityName
        
        firstColorLabel.textAlignment = .center
        firstColorLabel.adjustsFontSizeToFitWidth = true

        
        secondColorLabel.textAlignment = .center
        secondColorLabel.adjustsFontSizeToFitWidth = true
        
        let blendedColor = UIColor.blend(color1: firstColorButton.backgroundColor ?? .red, with: secondColorButton.backgroundColor ?? .blue)
        resultColor.backgroundColor = blendedColor
        
    }
    
    @IBAction func chooseFirstColorPicker(_ sender: UIButton) {
        activityButton = sender
        presentColorPicker()
        
    }
    
    @IBAction func chooseSecondColorPicker(_ sender: UIButton) {
        activityButton = sender
        presentColorPicker()
    }
    
//    палитра цветов
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.title = "Choose Color"
        colorPicker.supportsAlpha = false
        colorPicker.modalPresentationStyle = .popover
        present(colorPicker, animated: true)
    }
    
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        activityButton!.backgroundColor = UIColor(cgColor: color.cgColor)
        
        if activityButton == firstColorButton {
            firstColorLabel.text = activityButton?.backgroundColor?.accessibilityName
        }
        
        if activityButton == secondColorButton {
            secondColorLabel.text = activityButton?.backgroundColor?.accessibilityName
        }
        
//        смешивание цвета
        guard let color1 = firstColorButton.backgroundColor else { return }
        guard let color2 = secondColorButton.backgroundColor else { return }
        let blendedColor = UIColor.blend(color1: color1, with: color2)
        resultColor.backgroundColor = blendedColor
    }
}

extension UIColor {
    static func blend(color1: UIColor, with color2: UIColor) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        color1.getRed(&r1, green: &g1, blue: &b2, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 + r2
        let g = g1 + g2
        let b = b1 + b2
        let a = a1 + a2
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
