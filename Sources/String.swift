import Foundation

/*
 
 Erica Sadun, http://ericasadun.com
 Like a bridge over troubled Foundation, I will lay me down
 
 */

#if os(Linux)
#else
#endif

// --------------------------------------------------
// MARK: Character View
// --------------------------------------------------

public extension String.CharacterView {
    /// Converts character view back to String
    public var stringValue: String { return String(self) }
}

public extension String {
    /// Returns length in characters
    public var characterLength: Int { return characters.count }
}

// --------------------------------------------------
// MARK: Wackbards
// --------------------------------------------------

public extension String {
    /// Reverses a String instance by re-ordering its characters
    public var reversed: String { return String(characters.reversed()) }
}

// --------------------------------------------------
// MARK: Ranges
// --------------------------------------------------

infix operator ..+

/// Returns a CountableClosedRange using location and length
public func ..+ <Bound: Strideable>(location: Bound, length: Bound.Stride) -> CountableClosedRange<Bound> {
    return location ... location.advanced(by: length - 1)
}

public extension String {
    /// Converts an closed Int range into a CharacterView.Index range
    public func characterRange(_ range: CountableClosedRange<Int>) -> Range<CharacterView.Index> {
        let start = characters.index(characters.startIndex, offsetBy: range.lowerBound)
        let end   = characters.index(start, offsetBy: range.count)
        return start ..< end
    }
    
    /// Replaces a character-based range with a replacement string
    public func replacing(range: CountableClosedRange<Int>, with replacementString: String) -> String {
        return self.replacingCharacters(in: characterRange(range), with: replacementString)
    }
    
    /// Retrieves a ranged substring
    public func substring(_ range: CountableClosedRange<Int>) -> String {
        return String(self.characters[characterRange(range)])
    }
    
    /// Subscripts by closed Int range
    public subscript(_ range: CountableClosedRange<Int>) -> String {
        get { return substring(range) }
        set { self = replacing(range: range, with: newValue) }
    }
    
    /// Subscripts by index
    public subscript(index: Int) -> String {
        get { return substring(index ... index) }
        set { self[index ... index] = newValue }
    }
    
    /// Converts Range<Index> to CountableClosedRange<Int>
    public func closedRange(fromRange range: Range<Index>) -> CountableClosedRange<Int> {
        let start = distance(from: characters.startIndex, to: range.lowerBound)
        let end = distance(from: characters.startIndex, to: range.upperBound)
        return start ..+ (end - start)
    }
    
    /// Returns character-based range of substring
    public func characterRange(of substring: String) -> CountableClosedRange<Int>? {
        guard let range = range(of: substring) else { return nil }
        return closedRange(fromRange: range)
    }
}


// --------------------------------------------------
//  MARK: Decomposition
// --------------------------------------------------

public extension String {
    
    /// First character in the string
    public var first: String {
        return isEmpty ? "" : self[0]
    }
    
    /// All characters but the first
    public var butFirst: String {
        return String(characters.dropFirst())
    }
    
    /// first alias for Lispies
    public var car: String { return first }
    
    /// butFirst / rest alias for Lispies
    public var cdr: String { return butFirst }
    
    /// Last character in the string
    public var last: String {
        return isEmpty ? "" : self[characterLength - 1]
    }
    
    /// All characters but the last
    public var butLast: String { return String(characters.dropLast()) }
}

// --------------------------------------------------
// MARK: Trimming
// --------------------------------------------------

extension String {
    /// Trimming string whitespace
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns string's path extension. Like NSString but Swift
    public var pathExtension: String {
        let wackbard = self.reversed
        if let range = wackbard.range(of: ".") {
            return wackbard.substring(to: range.lowerBound).reversed
        } else { return "" }
    }
    
    /// Returns string's last path component. Like NSString but Swift
    public var lastPathComponent: String {
        let wackbard = self.reversed
        if let range = wackbard.range(of: "/") {
            return wackbard.substring(to: range.lowerBound).reversed
        } else { return "" }
    }
    
    /// Returns string by deleting last path component. Like NSString but Swift
    public var deletingLastPathComponent: String {
        let wackbard = self.reversed
        if let range = wackbard.range(of: "/") {
            return wackbard.substring(from: range.lowerBound).reversed
        } else { return "" }
    }
}
