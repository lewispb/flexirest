class Entry < Flexirest::Base
end

class Result < Flexirest::Base
  has_many :entries
end

class Finder < Flexirest::Base
  has_many :results

  hash = {
    results: [
      {
        entries: [
          {
            items: [
              "item one",
              "item two"
            ]
          }
        ]
      },
      {
        entries: [
          {
            items: [
              "item three",
              "item four"
            ]
          }
        ]
      }
    ]
  }

  get :find, "/iterate", fake: hash.to_json

end

# Uncomment the following lines to resolve issue
# module Flexirest
#   class ResultIterator
#     def []=(key, value)
#       @items[key] = value
#     end
#   end
# end

RSpec.describe Finder do

  let(:finder) { subject.find }
  describe "#find" do
    it { expect(finder.results.count).to eq(2) }
  end

end
