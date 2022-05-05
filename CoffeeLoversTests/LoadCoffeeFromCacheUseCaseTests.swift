//
//  LoadCoffeeFromCacheUseCaseTests.swift
//  CoffeeLoversTests
//
//  Created by Valeria Chub on 05.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import XCTest
import CoffeeLovers

class LoadCoffeeFromCacheUseCaseTests: XCTestCase {

    func test_init_doesNotReceiveAnyMessages() {
        let (_, store) = makeSUT()

        XCTAssertEqual(store.messages, [])
    }

    private func makeSUT() -> (sut: LocalDataLoader, store: CoffeeStoreSpy) {
        let store = CoffeeStoreSpy()
        let sut = LocalDataLoader(store: store)
        trackForMemoryLeaks(store)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }

    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {

        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak", file: file, line: line)
        }
    }

    private class CoffeeStoreSpy: CoffeeStore {
        
        enum Message {
            case retrieve
            case cache
            case update
        }

        var messages: [Message] = []

        func retrieve(completion: @escaping (Result<[ManagedCoffee], Error>) -> Void) {
            messages.append(Message.retrieve)
        }
        
        func cache(models: [CoffeeModel]) {
            messages.append(Message.cache)
        }
        
        func update(_ coffee: Coffee, completionSuccess: @escaping () -> Void) {
            messages.append(Message.update)
        }
    }
}
