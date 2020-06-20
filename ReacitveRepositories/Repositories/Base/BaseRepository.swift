//
//  BaseRepository.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation
import Combine

public class BaseRepository<TEntity> : CrudRepository
{
    public typealias entityType = TEntity
    
    fileprivate var subscriptions: [SubscriptionWrapper<TEntity>]? = []
    
    //MARK: CrudRepository
    public func create(_ entity: TEntity) {}
    
    public func read(_ dataPredicate: @escaping (_ enity: TEntity) -> Bool) -> [TEntity]
    {
        return []
    }
    
    public func update(_ entity: TEntity) {}
    
    public func delete(_ entity: TEntity) -> Bool { true }
    
    internal func publishData() {
        DispatchQueue.global(qos: .background).async {
            self.subscriptions?.forEach({ (item) in
                let data = self.read(item.predicate)
                _ = item.subscription?.send(data)
            })
        }
    }
}

extension BaseRepository : DataConnection
{
    public typealias entity = TEntity
    
    public func connect(predicate dataPredicate: @escaping (_ enity: TEntity) -> Bool) -> PassthroughSubject<[TEntity], Error> {
        let anysubscriber = PassthroughSubject<[TEntity], Error>()
        
        subscriptions?.append(SubscriptionWrapper(dataPredicate, anysubscriber))
        
        return anysubscriber
    }
}
