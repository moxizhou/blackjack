class window.Deck extends Backbone.Collection #window.Deck = Backbone.Collection.extend

  model: Card

  initialize: -> 
    @add _([0...52]).shuffle().map (card) -> # function(){array of 0 to 52, shuffle
      new Card 
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [ @pop(), @pop() ], @ #function return new Hand

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
