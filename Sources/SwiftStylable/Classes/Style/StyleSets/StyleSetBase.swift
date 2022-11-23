//
//  StyleComponentBase.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class StyleSetBase : StyleSet {
    
    static let didChangeNotification = Notification.Name(rawValue: "styleSetDidChange")
    
    internal let name:String
    
    private let _parent:StyleSet?
    private let _colorCollection:ColorCollection
    private let _dimensionCollection:DimensionCollection
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(name:String, parent:StyleSet?, colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self.name = name
        self._parent = parent
        self._colorCollection = colorCollection
        self._dimensionCollection = dimensionCollection
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
    
    internal func dimensionFromValue(_ value:Any?)->CGFloat? {
        var size:CGFloat?
        guard let value = value else {
            return nil
        }
        
        if let value = value as? String{
            if let dimensionHolder = self._dimensionCollection.dimensionHolderNamed(value){
                size = dimensionHolder.size
            } else {
                print("WARNING: Dimension named \(value) could not be found/parsed. HINT: Check if the type in the plist is of type number or the value is an dimentions string.")
            }
        }
        else if let value = value as? CGFloat{
            size = value
        }
        else {
            print("WARNING: Dimension named \(value) could not be found/parsed. HINT: Check if the type in the plist is of type number or the value is an dimensions string.")
        }
        
        return size
    }
    
    internal func parseFont(data:[String:Any]?, defaultName:String? = nil, defaultSize:CGFloat? = nil)->UIFont? {
        let name = data?["name"] as? String ?? defaultName
        let size = self.dimensionFromValue(data?["size"]) ?? defaultSize
        let font = self.createFont(
            name: name,
            size: size,
            defaultName: defaultName,
            defaultSize: defaultSize
        )
        return font
    }
    
    internal func createFont(name:String?, size:CGFloat?, defaultName:String? = nil, defaultSize:CGFloat? = nil)->UIFont? {
        var font:UIFont?
        if let name = name ?? defaultName,
            let size = size ?? defaultSize {
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
        if let lineSpacing = self.dimensionFromValue(data["lineSpacing"]) {
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyleNeeded = true
        }
        
        // Line height multiple
        if let lineHeightMultiple = self.dimensionFromValue(data["lineHeightMultiple"]) {
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            paragraphStyleNeeded = true
        }
        
        // Line break mode
        if let lineBreakModeString = data["lineBreakMode"] as? String {
            switch lineBreakModeString {
            case "byTruncatingTail":
                paragraphStyle.lineBreakMode = .byTruncatingTail
            case "byTruncatingMiddle":
                paragraphStyle.lineBreakMode = .byTruncatingMiddle
            case "byTruncatingHead":
                paragraphStyle.lineBreakMode = .byTruncatingHead
            case "byClipping":
                paragraphStyle.lineBreakMode = .byClipping
            case "byCharWrapping":
                paragraphStyle.lineBreakMode = .byCharWrapping
            case "byWordWrapping":
                paragraphStyle.lineBreakMode = .byWordWrapping
            default:
                paragraphStyle.lineBreakMode = .byTruncatingTail
            }
            paragraphStyleNeeded = true
        }
        
        // Alignment
        if let alignmentString = data["alignment"] as? String {
            let alignment:NSTextAlignment
            paragraphStyleNeeded = true
            switch alignmentString {
            case "center":
                alignment = NSTextAlignment.center
                
            case "justified":
                alignment = NSTextAlignment.justified
                
            case "left":
                alignment = NSTextAlignment.left
                
            case "natural":
                alignment = NSTextAlignment.natural
                
            case "right":
                alignment = NSTextAlignment.right
                
            default:
                alignment = NSTextAlignment.left
                
            }
            paragraphStyle.alignment = alignment
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
        
        // Strikethrough color
        if let strikethroughColorString = data["strikethroughColor"] as? String, let color = self.colorFromString(strikethroughColorString) {
            attributes[NSAttributedString.Key.strikethroughColor] = color
        }
        
        // Strikethrough style
        if let strikethroughStyleString = data["strikethroughStyle"] as? String {
            let strikethroughStyle:Int
            switch strikethroughStyleString {
            case "single":
                strikethroughStyle = NSUnderlineStyle.single.rawValue
                
            case "thick":
                strikethroughStyle = NSUnderlineStyle.thick.rawValue
                
            case "double":
                strikethroughStyle = NSUnderlineStyle.double.rawValue
                
            case "none":
                fallthrough
                
            default:
                strikethroughStyle = 0
            }
            attributes[NSAttributedString.Key.strikethroughStyle] = strikethroughStyle
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
        if let kern = self.dimensionFromValue(data["kern"]) {
            attributes[NSAttributedString.Key.kern] = kern
        }
        
        if paragraphStyleNeeded {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        return attributes
    }
}
