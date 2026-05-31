import Foundation

let marathi = "श्री स्वामी समर्थ"
let mutableString = NSMutableString(string: marathi)
CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
print(mutableString)
