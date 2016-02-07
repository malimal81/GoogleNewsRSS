//
//  DictionaryExt.swift
//  GoogleRSS
//
//  Created by Jamal Jones on 2/6/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import Foundation
import Haneke

extension NSDictionary : DataConvertible, DataRepresentable {
    
    public typealias Result = NSDictionary
    
    public class func convertFromData(data:NSData) -> Result? {
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSDictionary
    }
    
    public func asData() -> NSData! {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
}