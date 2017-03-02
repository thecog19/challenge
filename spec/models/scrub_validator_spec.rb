require 'rails_helper'

RSpec.describe ScrubValidator, type: :model do

  describe "#validate" do
    before do 
      @params = {image: {"uri" => "www.validurl.com", "source" => "validsource", "callback" => "valid callback"}}
      allow(ScrubValidator).to receive(:source_valid?).and_return(true)
      allow(ScrubValidator).to receive(:callback_valid?).and_return(true)
      allow(ScrubValidator).to receive(:uri_valid?).and_return(true)
    end

    context "given a valid set of parameters" do
      it "returns true" do 
        expect(ScrubValidator.validate(@params[:image])).to be true 
      end
    end


    context "source was invalid"do 
      it "returns an error message" do
        allow(ScrubValidator).to receive(:source_valid?).and_return(false)
        expect(ScrubValidator.validate(@params[:image])).to eq("Source not on list of approved sources")
      end
    end

    context "callback was invalid"do 
      it "returns an error message" do
        allow(ScrubValidator).to receive(:callback_valid?).and_return(false)
        expect(ScrubValidator.validate(@params[:image])).to eq("A callback must be provided")
      end
    end

    context "uri was invalid"do 
      it "returns an error message" do
        allow(ScrubValidator).to receive(:uri_valid?).and_return(false)
        expect(ScrubValidator.validate(@params[:image])).to eq("An url for the image must be provided")
      end
    end
 end

  describe "#source_valid?" do 
    before do
      @excluded_source = "fake_source"
      @included_source = "test_source"
      @list = [@included_source]
      stub_const("ScrubValidator::LIST_OF_SOURCES", @list) 
    end
    context "source is in the list of sources" do
      it "returns true" do 
        expect(ScrubValidator.source_valid?(@included_source)).to be true
      end
    end

    context "source is not on the list of sources" do 
      it "returns false" do 
        expect(ScrubValidator.source_valid?(@excluded_source)).to be false
      end
    end

    context "no source was provided" do 
      it "returns false" do 
        expect(ScrubValidator.source_valid?(nil)).to be false
      end
    end
  end

  describe "#callback_valid?" do 
    context "it is given a vaild callback" do
      it "returns true" do 
        @callback = "wheee!"
        expect(ScrubValidator.callback_valid?(@callback)).to be true
      end
    end

    context "it is given an invalid callback" do 
      it "returns false" do 
        expect(ScrubValidator.callback_valid?(nil)).to be false
      end
    end
  end

  describe "#uri_valid?" do 
    context "it is given a vaild uri" do
      it "returns true" do 
        @uri = "www.example_picture.com/eieie"
        expect(ScrubValidator.uri_valid?(@uri)).to be true
      end
    end

    context "it is given an invalid uri" do 
      it "returns false" do 
        expect(ScrubValidator.uri_valid?(nil)).to be false
      end
    end
  end




  # describe source_valid?
   #   context source valid
   #   context source invalid


end
