require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gibak do
  before( :each ) do
    @gibak = Gibak::Base.new
  end

  describe "ignore checker" do
    it "should exist" do
      @gibak.should respond_to(:ignore_path_with?)
    end

    def ignore_path(path)
      be_ignore_path_with(path, @filter)
    end

    describe "with 'foo/'" do
      before( :each ) do
        @filter = 'foo/'
      end
      it "should ignore directories named 'foo'" do 
        @gibak.should ignore_path 'a/foo/'
        @gibak.should ignore_path 'foo/'
      end
      it "should not ignore files named foo" do 
        @gibak.should_not ignore_path 'a/foo'
        @gibak.should_not ignore_path 'foo'
      end
      it "should not break on nil path" do
        lambda { @gibak.should_not ignore_path(nil) }.should_not raise_error
      end
    end

    describe "with 'foo/*.jpg'" do
      before( :each ) do
        @filter = 'foo/*.jpg'
      end
      it "should ignore jpgs in directory foo/" do
        @gibak.should ignore_path 'foo/01.jpg'
        @gibak.should ignore_path 'foo/02 my holidays.jpg'
      end

      it "should not ignore jpegs in other directories" do
        @gibak.should_not ignore_path 'otherfoo/01.jpg'
        @gibak.should_not ignore_path 'otherfoo/02 my holidays.jpg'
      end

      it "should not ignore other files in foo/" do
        @gibak.should_not ignore_path 'foo/01.txt'
        @gibak.should_not ignore_path 'foo/02 my holidays.txt'
      end
    end

    describe "with '*.avi'" do
      before( :each ) do
        @filter = '*.avi'
      end
      it "should ignore all avis" do
        @gibak.should ignore_path 'movie.avi'
        @gibak.should ignore_path 'a/movie.avi'
        @gibak.should ignore_path 'an/other/movie.avi'
      end

      it "should not ignore other files" do
        @gibak.should_not ignore_path 'subtitle.avi.txt'
      end
      it "should not break on nil path" do
        lambda { @gibak.should_not ignore_path(nil) }.should_not raise_error
      end
    end

    describe "without filter" do
      before( :each ) do
        @filter = nil
      end
      it "should not ignore anything" do
        @gibak.should_not ignore_path 'foo'
        @gibak.should_not ignore_path 'bar/foo'
        @gibak.should_not ignore_path ''
      end
      it "should not break on nil path" do
        lambda { @gibak.should_not ignore_path(nil) }.should_not raise_error
      end
    end

  end
end

