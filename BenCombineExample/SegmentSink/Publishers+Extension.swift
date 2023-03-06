//
//  Publishers+Extension.swift
//  BenCombineExample
//
//  Created by Ben Lee on 2023/2/24.
//

import Foundation
import Combine

extension Publisher {
    func segmentSink(
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (Output) -> Void
    ) -> Cancellable
    {
        let sink = Subscribers.SegmentSink<Output, Failure>(
            receiveCompletion: receiveCompletion,
            receiveValue: receiveValue
        )
        self.subscribe(sink)
        return sink
    }
}
