//
//  RecordRepository.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation

public class RecordRepository : BaseRepository<Record>
{
    fileprivate var memoryDatas : [Record] = []
    
    override public func create(_ entity: Record) {
        super.create(entity)
        
        memoryDatas.append(entity)
        publishData()
    }
    
    override public func read(_ dataPredicate: @escaping (Record) -> Bool) -> [Record] {
        
        return memoryDatas.filter({ dataPredicate($0) })
    }
}
