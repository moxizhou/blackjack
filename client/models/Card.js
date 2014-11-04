// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.Card = (function(_super) {
  __extends(Card, _super);

  function Card() {
    return Card.__super__.constructor.apply(this, arguments);
  }

  Card.prototype.initialize = function(params) {
    return this.set({
      revealed: true,
      value: !params.rank || 10 < params.rank ? 10 : params.rank,
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit],
      rankName: (function() {
        switch (params.rank) {
          case 0:
            return 'King';
          case 1:
            return 'Ace';
          case 11:
            return 'Jack';
          case 12:
            return 'Queen';
          default:
            return params.rank;
        }
      })()
    });
  };

  Card.prototype.flip = function() {
    return this.set('revealed', !this.get('revealed'));
  };

  return Card;

})(Backbone.Model);