# class CircularQueue
#   attr_reader :size

#   def initialize(size)
#     @size = size
#     @buffer = Array.new(size)
#     @read_idx = 0
#     @write_idx = 0
#   end

#   def enqueue(element)
#     self.read_idx = increment(self.read_idx) if !buffer[write_idx].nil?

#     buffer[write_idx] = element
#     self.write_idx = increment(self.write_idx)

#     buffer
#   end

#   def dequeue
#     deleted_element = buffer[read_idx]
#     if !deleted_element.nil?
#       buffer[read_idx] = nil
#       self.read_idx = increment(self.read_idx)
#     end

#     deleted_element
#   end

#   def to_s
#     buffer.to_s
#   end

#   private

#   attr_accessor :buffer, :read_idx, :write_idx

#   def increment(idx)
#     (idx + 1) % size
#   end
# end

class CircularQueue
  def initialize(size)
    @size = size
    @buffer = Array.new
  end

  def dequeue
    @buffer.shift
  end

  def enqueue(x)
    dequeue if @buffer.size >= @size
    @buffer << x
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
