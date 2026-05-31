import Foundation
let marathi = "गणपती"
let mutableString = NSMutableString(string: marathi)
CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
print(mutableString)
