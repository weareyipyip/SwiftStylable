//
//  StyleComponentBase.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation


public class StyleSetBase : StyleSet {
    
    static let didChangeNotification = Notification.Name(rawValue: "styleSetDidChange")
    
    internal let name:String
    
    private let _parent:StyleSet?
    private let _colorCollection:ColorCollection
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(name:String, parent:StyleSet?, colorCollection:ColorCollection) {
        self.name = name
        self._parent = parent
        self._colorCollection = colorCollection
        if let parent = self._parent {
            NotificationCenter.default.addObserver(self, selector: #selector(StyleSetBase.parentDidChange), name: StyleSetBase.didChangeNotification, object: parent)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal final func applyData(_ data:[String:Any]) {
        self._applyData(data)
        self.update()
        NotificationCenter.default.post(name: StyleSetBase.didChangeNotification, object: self)
    }
    
    internal func _applyData(_ data:[String:Any]) {
        
    }
    
    internal func update() {
        
    }
    
    // -----------------------------------------------------------
    // MARK: -- Events
    // -----------------------------------------------------------
    
    @objc func parentDidChange() {
        
    }
    
    internal func colorFromString(_ string:String?)->UIColor? {
        var color:UIColor?
        
        guard let string = string else {
            return nil
        }
        
        if let namedColor = self._colorCollection.colorHolderNamed(string)?.color {
            color = namedColor
        } else {
            color = UIColor(hexString: string)
            // If the hexString color is not valid, could be wrong name or invalid hexString
            if color == nil {
                print("WARNING: Color named \(string) could not be found/parsed")
            }
        }
        return color
    }
    
    internal func parseFont(data:[String:Any]?)->UIFont? {
        var font:UIFont?
        if let name = data?["name"] as? String {
            let newSize = data?["size"]
            if newSize != nil && !(newSize is CGFloat) {
                print("WARNING: Style definition for '\(self.name)' has a font size of type String, change to a Number in the styles.plist")
            }
            if let size = newSize as? CGFloat {
                switch name {
                case "systemFont":
                    font = UIFont.systemFont(ofSize: size)
                    
                case "boldSystemFont":
                    font = UIFont.boldSystemFont(ofSize: size)
                    
                case "italicSystemFont":
                    font = UIFont.italicSystemFont(ofSize: size)
                    
                case "thinSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
                    
                case "blackSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.black)
                    
                case "heavySystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.heavy)
                    
                case "lightSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
                    
                case "mediumSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
                    
                case "semiboldSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
                    
                case "ultraLightSystemFont":
                    font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.ultraLight)
                    
                default:
                    font = UIFont(name: name, size: size)
                }
            }
        }
        return font
    }
    
    internal func stringAttributesFromDictionary(_ data:[String:Any]?)->[NSAttributedString.Key:Any]? {
        guard let data = data else {
            return nil
        }
        
        var attributes = [NSAttributedString.Key:Any]()
        
        var paragraphStyleNeeded = false
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Line spacing
        if let lineSpacing = data["lineSpacing"] as? CGFloat {
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyleNeeded = true
        }
        
        // Line height multiple
        if let lineHeightMultiple = data["lineHeightMultiple"] as? CGFloat {
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            paragraphStyleNeeded = true
        }
        
        // Underline style
        if let underlineStyleString = data["underlineStyle"] as? String {
            let underlineStyle:Int
            switch underlineStyleString {
            case "byWord":
                underlineStyle = NSUnderlineStyle.byWord.rawValue
                
            case "patternDash":
                underlineStyle = NSUnderlineStyle.patternDash.rawValue
                
            case "patternDashDot":
                underlineStyle = NSUnderlineStyle.patternDashDot.rawValue
                
            case "patternDashDotDot":
                underlineStyle = NSUnderlineStyle.patternDashDotDot.rawValue
                
            case "patternDot":
                underlineStyle = NSUnderlineStyle.patternDot.rawValue
                
            case "double":
                underlineStyle = NSUnderlineStyle.double.rawValue
                
            case "single":
                underlineStyle = NSUnderlineStyle.single.rawValue
                
            case "thick":
                underlineStyle = NSUnderlineStyle.thick.rawValue
                
            case "none":
                fallthrough
            default:
                underlineStyle = 0
            }
            attributes[NSAttributedString.Key.underlineStyle] = underlineStyle
        }
        
        // Underline color
        if let underlineColorString = data["underlineColor"] as? String, let color = self.colorFromString(underlineColorString) {
            attributes[NSAttributedString.Key.underlineColor] = color
        }
        
        // Font
        if let font = self.parseFont(data: data["font"] as? [String:Any]) {
            attributes[NSAttributedString.Key.font] = font
        }
        
        // ForegroundColor
        if let foregroundColorString = data["foregroundColor"] as? String, let color = self.colorFromString(foregroundColorString) {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        
        // Kern
        if let kern = data["kern"] as? CGFloat {
            attributes[NSAttributedString.Key.kern] = kern
        }
        
        if paragraphStyleNeeded {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        return attributes
    }
}
