class Queue
  constructor: () ->
    @front = []
    @back = []

  enqueue: (x) ->
    @enqueueBack(x)

  dequeue: (x) ->
    @dequeueFront(x)

  enqueueFront: (x) ->
    @front.push(x)

  enqueueBack: (x) ->
    @back.push(x)

  dequeueFront: (x) ->
    if @length != 0
      @populateFront()
      @front.pop()
    else
      null

  dequeueBack: (x) ->
    if @length != 0
      @populateBack()
      @back.pop()
    else
      null

  populateFront: () ->
    if @front.length = 0
      @front = @back.reverse()
      @back = []
      null

  populateBack: () ->
    if @back.length = 0
      @back = @front.reverse()
      @back = []
      null
