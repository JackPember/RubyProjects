require './caesarCipher.rb'

describe "caesar_cipher" do
    it "returns the string shifted n letters forward" do
        expect(caesar_cipher("I fucking did it!!", 5)).to eql("N kzhpnsl ini ny!!")        
    end

    it "returns the string shifted n letters forward while wrapping around to the start of the alphabet" do
        expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
end

