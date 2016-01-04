/*

Erica Sadun, http://ericasadun.com

*/

#if os(Linux)
    import Glibc
    import Foundation
#else
    import Darwin
#endif

// --------------------------------------------------
// MARK: Numbers
// --------------------------------------------------

// Support Swift prefixes (0b, 0o, 0x) and Unix (0, 0x / 0X)
public extension String {
    
    /// Expose integer value
    public var integerValue: Int {
        return strtol(self, nil, 10)
    }
    
    /// Expose UInteger value
    public var uintegerValue: UInt {
        return strtoul(self, nil, 10)
    }
    
    /// Boolean Value
    public var booleanValue: Bool {
        return integerValue != 0
    }

    /// Convert string to its binary value, ignoring any 0b prefix
    public var binaryValue: Int {
        return strtol(self.hasPrefix("0b") ? String(characters.dropFirst(2)) : self, nil, 2)
    }
    
    /// Convert string to its octal value, ignoring any 0o prefix, supporting 0 prefix
    public var octalValue: Int {
        return strtol(self.hasPrefix("0o") ? String(characters.dropFirst(2)) : self, nil, 8)
    }
    
    /// Convert string to hex value. This supports 0x, 0X prefix if present
    public var hexValue: Int {
        return strtol(self, nil, 16)
    }
    
    /// Convert string to its unsigned binary value, ignoring any 0b prefix
    public var uBinaryValue: UInt {
        return strtoul(self.hasPrefix("0b") ? String(characters.dropFirst(2)) : self, nil, 2)
    }

    /// Convert string to its unsigned octal value, ignoring any 0o prefix
    public var uOctalValue: UInt {
        return strtoul(self.hasPrefix("0o") ? String(characters.dropFirst(2)) : self, nil, 8)
    }
    
    /// Convert string to unsigned hex value. This supports 0x prefix if present
    public var uHexValue: UInt {
        return strtoul(self, nil, 16)
    }
    
    /// Prepend self with character padding
    public func leftPaddedToWidth(width: Int, withCharacter character: Character = "0") -> String {
        return String(count: width - Int(characters.count), repeatedValue: character) + self
    }
    
    /// Standard binary prefix
    public var binaryPrefix: String { return "0b" }
    
    /// Standard octal prefix
    public var octalPrefix: String { return "0o" }
    
    /// Standard hex prefix
    public var hexPrefix: String { return "0x" }
}

public extension Int {
    
    /// Convert to binary string, no prefix
    public var binaryString: String { return String(self, radix:2) }
    
    /// Convert to octal string, no prefix
    public var octalString: String { return String(self, radix:8) }
    
    /// Convert to hex string, no prefix
    public var hexString: String { return String(self, radix:16) }
}
