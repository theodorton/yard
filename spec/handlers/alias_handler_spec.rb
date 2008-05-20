require File.dirname(__FILE__) + '/spec_helper'

describe YARD::Handlers::AliasHandler do
  before do
    Registry.clear 
    parse_file :alias_handler_001, __FILE__
  end

  it "should throw alias into namespace object list" do
    P(:A).aliases[P("A#b")].should == :a
  end
  
  it "should create a new method object for the alias" do
    P("A#b").should be_instance_of(MethodObject)
  end
  
  it "should pull the method into the current class if it's from another one" do
    P(:B).aliases[P("B#q")].should == :x
    P(:B).aliases[P("B#r?")].should == :x
  end
  
  it "should gracefully fail to pull a method in if the original method cannot be found" do
    P(:B).aliases[P("B#s")].should == :to_s
  end
  
  it "should allow complex Ruby expressions after the alias parameters" do
    P(:B).aliases[P("B#t")].should == :inspect
  end
  
  it "should show up in #is_alias? for method" do
    P("B#t").is_alias?.should == true 
    P('B#r?').is_alias?.should == true
  end
end