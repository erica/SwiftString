import Foundation

extension String {
    public func rexRange(_ pattern: String, caseInsensitive: Bool = true) -> Range<String.Index>? {
        var options: String.CompareOptions = [.literal, .diacriticInsensitive, .regularExpression ]
        if caseInsensitive { options.insert(.caseInsensitive) }
        
        return self.range(of: pattern, options: options)
    }
    
    public func rexIntRange(_ pattern: String, caseInsensitive: Bool = true) -> CountableClosedRange<Int>? {
        guard let range = rexRange(pattern, caseInsensitive: caseInsensitive) else { return nil }
        return closedRange(fromRange: range)
    }
    
    public func rexFind(_ pattern: String, caseInsensitive: Bool = true) -> Bool {
        return rexRange(pattern, caseInsensitive: caseInsensitive) != nil
    }
    
    public func rexReplace(_ pattern: String, with replacement: String, caseInsensitive: Bool = true) -> String {
        var options: String.CompareOptions = [.literal, .diacriticInsensitive, .regularExpression ]
        if caseInsensitive { options.insert(.caseInsensitive) }
        
        var copy = self
        while let range = copy.range(of: pattern, options: options)  {
            copy = copy.replacingCharacters(in: range, with: replacement)
        }
        
        return copy
    }
}
