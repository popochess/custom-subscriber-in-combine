import UIKit
import Combine

let publisher = [1,2,3].publisher

var subscriptions = Set<AnyCancellable>()
publisher.sink { completion in
    print("completion: ", completion)
} receiveValue: { value in
    print("value:", value)
}.store(in: &subscriptions)


let subscriber = Subscribers.Sink<Int, Never> { completion in
    print("completion: ", completion)
} receiveValue: { value in
    print("value:", value)
}
