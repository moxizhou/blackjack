    #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    playerHand = @get ('playerHand')
    dealerHand = @get ('dealerHand')
    playerHand.on 'bust', =>
      @declareWinner('dealer')
    playerHand.on 'stand', =>
      @dealerPlay()
    dealerHand.on 'bust', =>
      @declareWinner('player')
    dealerHand.on 'stand', =>
      debugger;
      #never happems :(
      winner = @decideWinner()
      @declareWinner(winner)

    # @on 'change:gameOver', @decideWinner

  dealerPlay: ->
    dealerHand = @get('dealerHand')
    dealerHand.at(0).flip()

    #always use highest score, if highest score busts,
    #then use lowest score
    while dealerHand.trueScore() < 17
      if dealerHand.trueScore() > 21
        dealerHand.bust()
      else if dealerHand.trueScore() < 17
        dealerHand.hit()
      else
        dealerHand.stand()

    # #while dealer score is less than 17
    # while dealerHand.scores()[0] < 17
    #   #check to see if there is a second score ("Ace"),
    #   #if there is and it's greater than 16, stand
    #   if dealerHand.scores()[1] > 16
    #     dealerHand.stand()
    #   #if there isn't a second score, there may/maynot ace, so...
    #   #check to see if the score is between 16 and 22
    #   #if so, stand
    #   else if dealerHand.scores()[0] < 22 and dealerHand.scores()[0] > 16
    #     dealerHand.stand()
    #   #all else cases, score is below 17, and hit
    #   #hit should trigger bust, if not then loop
    #   else
    #     dealerHand.hit()

  decideWinner: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.scores()[0] > dealerHand.scores()[0]
      return "player"
    else
      return "dealer"

  declareWinner: (winner) ->
    console.log winner + "WINS!"

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



