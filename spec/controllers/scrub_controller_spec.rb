require 'rails_helper'

RSpec.describe ScrubController, type: :controller do

  describe "#create" do 
    
    context "given working params" do 
      before do 
        allow(ScrubValidator).to receive(:validate).and_return(true)
        @params = {img: {"uri" => "www.internet.com", "callback" => "this", "source" => "totally on the list"}}
      end 

      it "returns a json object" do 
        
        post :create, @params
        expect(response.content_type).to eq("application/json")

      end

      it "the json object has a success message" do
        post :create, @params
        expect(JSON.parse(response.body)).to eq({"response" => "Image added to queue"})
      end
    end

    context "given bad params" do 
      before do 
        allow(ScrubValidator).to receive(:validate).and_return("test error message")
      end 

       it "returns a json object" do   
        post :create, @params
        expect(response.content_type).to eq("application/json")
      end

      it "the json object has an error message" do
        post :create, @params
        expect(JSON.parse(response.body)).to include("error")
      end

       it "the error message should be returned from validate" do
        post :create, @params
        expect(JSON.parse(response.body)["error"]).to eq("test error message")
      end
    end

  end

end
