require 'spec_helper'

describe Flexirest::LazyLoader do
  let(:request) { double("Request") }
  let(:response) { double("Response") }

  it "should not #call the passed in request during initialisation" do
    expect(request).not_to receive(:call)
    Flexirest::LazyLoader.new(request)
  end

  it "should #call the passed in request if you check for response to a message" do
    expect(request).to receive(:call)
    loader = Flexirest::LazyLoader.new(request)
    loader.respond_to?(:each)
  end

  it "should #call the passed in request if you call a method and pass through the method" do
    expect(request).to receive(:call).and_return(response)
    expect(response).to receive(:valid).and_return(true)
    loader = Flexirest::LazyLoader.new(request)
    expect(loader.valid).to be_truthy
  end

end
