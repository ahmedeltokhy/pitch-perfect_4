//
//  RecordedAudio.swift
//  sound effects
//
//  Created by Ahmed Atyya Ali on 6/3/15.
//  Copyright (c) 2015 Ahmed Atyya Ali. All rights reserved.
//

import Foundation

class RecordedAudio{
    init(title:String,pathURL:NSURL){
        self.pathURL = pathURL
        self.title = title
    }
    var title:String!
    var pathURL:NSURL!
}
