class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @on 'remove', @checkSize, @
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: if card > 51 then 3 else Math.floor(card / 13)

  dealPlayer: (discard) -> hand = new Hand [ @pop(), @pop() ], @, false, discard

  dealDealer: (discard) -> new Hand [ @pop().flip(), @pop() ], @, true, discard

  checkSize: (deck) ->
    if @length < 15
      @trigger 'runningLow', @
