// Generated by CoffeeScript 1.8.0
var assert;

assert = chai.assert;

describe("deck constructor", function() {
  return it("should create a card collection", function() {
    var collection;
    collection = new Deck();
    return assert.strictEqual(collection.length, 52);
  });
});