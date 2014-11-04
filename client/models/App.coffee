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
      winner = @decideWinner()
      @declareWinner(winner)

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

    if dealerHand.trueScore() < 22
      dealerHand.stand()

  decideWinner: ->
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    if playerHand.scores()[0] > dealerHand.scores()[0]
      return "Player Wins!"
    else if playerHand.scores()[0] < dealerHand.scores()[0]
      return "Dealer Wins!"
    else
      return "It's a tie!"

  declareWinner: (winner) ->
    window.location.reload() unless alert(winner)

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
