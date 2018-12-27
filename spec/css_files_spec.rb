require "w3c_rspec_validators"

describe "css_files" do
  describe "self.compiled" do

    before(:each) do
      expect(Object).to receive(:system).with("rake -q assets:precompile")
      expect(Rails).to receive(:root).and_return(Pathname.new("railsroot"))
      expect(FileUtils).to receive(:rm_rf).with("railsroot/public/assets/")
    end

    it "should read css files from a directory" do
      directory = File.dirname(__FILE__)

      compiled = W3cRspecValidators::CssFiles.compiled(["#{directory}/fixtures/*.css"])

      expect(compiled).to eq <<~CSS
      body {
      }
      #home {}
      CSS
    end
  end
end
