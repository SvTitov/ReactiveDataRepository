//
//  DataConnection.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation
import Combine


public protocol DataConnection
{
    associatedtype entity
    
    func connect(predicate dataPredicate: @escaping (_ entity: entity)->Bool) -> PassthroughSubject<[entity], Error>
}
