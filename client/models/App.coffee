    #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'isPlayerTurn', true
    @set 'gameOver', false

    playerHand = @get ('playerHand')
    playerHand.on 'bust', @changeTurn
    #call gameOver function
    #
    #playerHand.on 'stand', dealer flip
    #
    #
    #

    @on 'change:gameOver', @decideWinner


  decideWinner: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.scores()[0] > dealerHand.scores()[0]
      alert "player wins"
    else
      alert "dealer wins"

  # changeTurn: ->
  #   debugger
  #   isPlayerTurn = @get ('isPlayerTurn')
  #   if isPlayerTurn
  #     #isPlayerTurn is undefined!
  #     @set('isPlayerTurn', false)
  #     console.log "changed turns"
  #   else
  #     @set 'gameOver', true

  whoseTurn: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.scores()[0] > 21
      return "game over"
    else if dealerHand.scores()[0] > 16 and dealerHand.scores()[1] > 16
      return "game over"
    else if dealerHand.hasCovered()
      return "dealer turn"
    else if dealerHand.scores()[0] < 17 or dealerHand.scores()[1] < 17
      return "dealer turn"

    else
      return "player's turn"



