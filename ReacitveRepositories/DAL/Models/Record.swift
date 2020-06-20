//
//  Record.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation

public struct Record
{
    private(set) var name: String?
       
    init(_ stringName: String?) {
       self.name = stringName
    }
}
