class window.Hand extends Backbone.Collection #window.Hand = Backbone.Collection.extend

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'hit', @checkIfBust

  stand: ->
    @trigger 'stand'
  hit: ->
    @add(@deck.pop()).last()
    @trigger 'hit'

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  checkIfBust: ->
    if @scores()[0] > 21
      if !@scores()[1] or @scores()[1] > 21
        @trigger 'bust'

  hasCovered: ->
    !@at(0).get 'revealed'

  trueScore: ->
    if @scores()[1] < 22 then @scores()[1] else @scores()[0]