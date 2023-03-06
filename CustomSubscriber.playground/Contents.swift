import UIKit
import Combine


class CustomSubscriber: Subscriber, Cancellable {

    typealias Input = String
    typealias Failure = Never
    var subscription: Subscription?

    func receive(subscription: Subscription) {
        self.subscription = subscription
        subscription.request(.unlimited) // Subscribers.Demand.unlimited
    }

    func receive(_ input: String) -> Subscribers.Demand {
        print("Value:", input)
        return .none
    }
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completion: \(completion)")
        cancel()
    }

    func cancel() {
        print("cancel!")
        subscription?.cancel()
        subscription = nil
    }

    // .max(2) -> .max(3)
    //return (input == "b") ? .max(2) : .none
    //return (input == "d") ? .max(2) : .none
}

let subscriber = CustomSubscriber()
let publisher = ["a","b","c","d","e","f","g"].publisher

publisher.subscribe(subscriber)


// Demand
let demand1 = Subscribers.Demand.max(10)
let demand2 = Subscribers.Demand.max(5)

let sum = demand1 + demand2 // sum = max(15)
let difference = demand1 - demand2 // difference = max(5)
let product = demand1 * 2 // product = max(20)
//let quotient = demand1 / Subscribers.Demand.max(2) // quotient = max(5)

