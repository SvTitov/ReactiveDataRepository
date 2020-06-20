//
//  CrudRepository.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation

public protocol CrudRepository {
    associatedtype entityType
    
    func create(_ entity: entityType)
    
    func read(_ dataPredicate: @escaping (_ enity: entityType) -> Bool) -> [entityType]
    
    func update(_ entity: entityType)
    
    func delete(_ entity: entityType) -> Bool
}
