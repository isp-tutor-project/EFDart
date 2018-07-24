
part of chat.chatService;

// Calculate the rate of events over a given time range. The time
// range is split over a number of buckets where each bucket collects
// the number of events happening in that time sub-range. The first
// constructor arument specifies the time range in milliseconds. The
// buckets are in the list _buckets organized at a circular buffer
// with _currentBucket marking the bucket where an event was last
// recorded. A current sum of the content of all buckets except the
// one pointed a by _currentBucket is kept in _sum.

class chatRate 
{
  int _timeRange;
  List<int> _buckets;
  int _currentBucket;
  int _currentBucketTime;
  num _bucketTimeRange;
  int _sum;
  
  chatRate([int timeRange = 1000, int buckets = 10])
      : _timeRange = timeRange,
        _buckets = new List(buckets + 1),  // Current bucket is not in the sum.
        _currentBucket = 0,
        _currentBucketTime = new DateTime.now().millisecondsSinceEpoch,
        _sum = 0 {
    _bucketTimeRange = (_timeRange / buckets).toInt();
    for (int i = 0; i < _buckets.length; i++) {
      _buckets[i] = 0;
    }
  }

  // Record the specified number of events.
  void record(int count) {
    _timePassed();
    _buckets[_currentBucket] = _buckets[_currentBucket] + count;
  }

  // Returns the current rate of events for the time range.
  num get rate {
    _timePassed();
    return _sum;
  }

  // Update the current sum as time passes. If time has passed by the
  // current bucket add it to the sum and move forward to the bucket
  // matching the current time. Subtract all buckets vacated from the
  // sum as bucket for current time is located.
  void _timePassed() {
    int time = new DateTime.now().millisecondsSinceEpoch;
    if (time < _currentBucketTime + _bucketTimeRange) {
      // Still same bucket.
      return;
    }

    // Add collected bucket to the sum.
    _sum += _buckets[_currentBucket];

    // Find the bucket for the current time. Subtract all buckets
    // reused from the sum.
    while (time >= _currentBucketTime + _bucketTimeRange) {
      _currentBucket = (_currentBucket + 1) % _buckets.length;
      _sum -= _buckets[_currentBucket];
      _buckets[_currentBucket] = 0;
      _currentBucketTime += _bucketTimeRange;
    }
    
  }
  
}
