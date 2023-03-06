//
//  MySink.swift
//  BenCombineExample
//
//  Created by Ben Lee on 2023/2/21.
//

import Foundation
import Combine

extension Subscribers {

    class SegmentSink<Input, Failure: Error>: Subscriber, Cancellable {

        let receiveCompletion: (Subscribers.Completion<Failure>) -> Void
        let receiveValue: (Input) -> Void

        var subscription: Subscription?
        var shouldPullNewValue: Bool = false

        var pending = [Input]()
        var cancellables = Set<AnyCancellable>()

        init(
            receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
            receiveValue: @escaping (Input) -> Void
        ) {
            self.receiveCompletion = receiveCompletion
            self.receiveValue = receiveValue

            Timer.publish(every: 0.016, on: .main, in: .default)
                .autoconnect()
                .sink { value in
                    self.pending.removeAll()
                    self.resume()
                    print(value)
                }.store(in: &cancellables)
        }

        func receive(subscription: Subscription) {
            self.subscription = subscription
            subscription.request(.max(1))
        }

        func receive(_ input: Input) -> Subscribers.Demand {

            pending.append(input)
            receiveValue(input)
            return pending.count < 100 ? .max(1) : .none
        }

        func receive(completion: Subscribers.Completion<Failure>) {
            receiveCompletion(completion)
            subscription = nil
        }

        func cancel() {
            print("[SegmentSink] cancel")
            subscription?.cancel()
            subscription = nil
            _ = cancellables.map { $0.cancel() }
        }

        func resume() {
            subscription?.request(.max(1))
        }
    }
}
