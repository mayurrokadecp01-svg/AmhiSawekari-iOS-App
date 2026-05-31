import Foundation

extension String {
    func transliteratedToEnglish() -> String {
        let mutableString = NSMutableString(string: self)
        
        // 1. Convert Devanagari (Marathi/Hindi) to Latin (e.g. श्री स्वामी समर्थ -> śrī svāmī samartha)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        
        // 2. Remove phonetic accents/diacritics (e.g. śrī svāmī samartha -> sri svami samartha)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        var result = String(mutableString).lowercased()
        
        // 3. Add common phonetic variants to the token so both strict and colloquial searches work
        let colloquialVariants: [String: String] = [
            "ganapati": "ganapati ganpati ganesh",
            "datta": "datta datt",
            "viththala": "viththala vitthal vithal",
            "sankara": "sankara shankar",
            "siva": "siva shiv",
            "krsna": "krsna krishna",
            "devi": "devi",
            "svami": "svami swami",
            "samartha": "samartha samarth",
            "maharaja": "maharaja maharaj"
        ]
        
        for (strict, variants) in colloquialVariants {
            result = result.replacingOccurrences(of: strict, with: variants)
        }
        
        return result
    }
}
