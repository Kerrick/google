require 'spec_helper'
require_relative '../lib/google'

describe "Pasting link to clipboard manual spec" do
  before :each do
    @google = Google.new "github spork",
                         {
                                 page: 1,
                                 size: 4,
                                 markdown: true,
                         }
    @google.stub!(:exit)
  end


  it "copies the first search result link to the clipboard" do
    @google.should_receive(:clipboard_copy).with("https://github.com/sporkrb/spork")

    @google.search

    # press Return manually ;)
  end

end