//
//  SubscriptionWrapper.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import Foundation
import Combine

public struct SubscriptionWrapper<TEntity>
{
    public var predicate: (TEntity) -> Bool
    
    public var subscription: PassthroughSubject<[TEntity], Error>?
    
    init(_ predicate: @escaping (TEntity) -> Bool, _ sub: PassthroughSubject<[TEntity], Error>?) {
        self.predicate = predicate
        self.subscription = sub
    }
}

