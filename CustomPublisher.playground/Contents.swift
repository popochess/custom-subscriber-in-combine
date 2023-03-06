import UIKit
import Combine


class IntPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never

    private let values: [Int]

    init(_ values: [Int]) {
        self.values = values
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = IntSubscription(subscriber: subscriber, values: values)
        subscriber.receive(subscription: subscription)
    }
}

class IntSubscription<S: Subscriber>: Subscription where S.Input == Int {
    private var subscriber: S?
    private let values: [Int]
    private var currentIndex = 0
    private var demand: Subscribers.Demand = .none

    init(subscriber: S, values: [Int]) {
        self.subscriber = subscriber
        self.values = values
    }

    func request(_ demand: Subscribers.Demand) {
        self.demand += demand

        while self.demand > 0, currentIndex < values.count {
            self.demand -= 1
            let value = values[currentIndex]
            _ = subscriber?.receive(value)
            currentIndex += 1
        }

        if currentIndex == values.count {
            subscriber?.receive(completion: .finished)
        }
    }

    func cancel() {
        subscriber = nil
    }
}

let publisher = IntPublisher([1,2,3,4,5])
publisher.sink { completion in

} receiveValue: { value in
    print("receive value: \(value)")
}

