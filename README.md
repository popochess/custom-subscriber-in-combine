# custom-subscriber-in-combine
Here's an example of how to create a custom subscriber in Combine



<img width="750" alt="Screen Shot 2023-03-06 at 11 19 12 AM" src="https://user-images.githubusercontent.com/236130/223012052-f72226a7-16bc-4a3a-9538-376cb30aa8d2.png">


# SegmentSink

In this project, you could replace the term `sink` with `segmentSink` to see how it affects the user interface.

```
(1...50000).publisher.sink(
    receiveCompletion: { completion in
        print("Completion: \(completion)")
        _ = self.cancellables.map { $0.cancel() }
    },
    receiveValue: { value in
        print("Receive value: \(value)")
        DispatchQueue.main.async {
            self.textLabel.text = String(value)
            self.progressBar.progress = Float(value)/50000.0
        }
    }
).store(in: &cancellables)
```

### Using `publisher.sink`
<img src="https://user-images.githubusercontent.com/236130/223008278-d98a6590-71c2-4144-8055-f2a4379e4cfb.gif" width="320">

### Using `publisher.segmentSink`
<img src="https://user-images.githubusercontent.com/236130/223008632-3328f6a1-cd44-4590-a0cf-69d56cf12f3a.gif" width="320">

### Memory profiling
<img width="836" alt="Screen Shot 2023-03-06 at 10 31 33 PM" src="https://user-images.githubusercontent.com/236130/223139738-26d2d04b-3c21-454a-a4bb-f21f879649ba.png">


