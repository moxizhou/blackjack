    #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    playerHand = @get ('playerHand')
    dealerHand = @get ('dealerHand')
    playerHand.on 'bust', =>
      @declareWinner('Dealer Wins!')
    playerHand.on 'stand', =>
      @dealerPlay()
    dealerHand.on 'bust', =>
      @declareWinner('Player Wins!')
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
    setTimeout (->
      window.location.reload()  unless alert(winner)
    ), 100
