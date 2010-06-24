require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

Expectations do
 
  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :nothing
    instance = stub(:nothing => nil)
    validation.valid?(instance)
  end

  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int
    instance = stub(:some_int => 50)
    validation.valid?(instance)
  end  
 
  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int
    instance = stub(:some_int => 0, :some_int_before_typecast => 'string')
    validation.valid?(instance)
  end  
  
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int
    instance = stub(:some_int => 21, :some_int_before_typecast => '21')
    validation.valid?(instance)
  end  
 
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int, :allow_nil => true
    instance = stub(:some_int => nil)
    validation.valid?(instance)
  end  
 
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int, :allow_blank => true
    instance = stub(:some_int => '')
    validation.valid?(instance)
  end  
 
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_decimal
    instance = stub(:some_decimal => 1.23)
    validation.valid?(instance)
  end

  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_decimal, :only_integer => true
    instance = stub(:some_decimal => 1.23)
    validation.valid?(instance)
  end
  
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_negative_number, :only_integer => true
    instance = stub(:some_negative_number => "-1")
    validation.valid?(instance)
  end
  
  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_non_numeric
    instance = stub(:some_non_numeric => "50F")
    validation.valid?(instance)
  end

  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :multiple_dots
    instance = stub(:multiple_dots => "50.0.0")
    validation.valid?(instance)
  end
  
  #tests for greater_than
  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_negative_number, :only_integer => true, :greater_than => 0
    instance = stub(:some_negative_number => "-1")
    validation.valid?(instance)
  end
  
  expect false do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_decimal, :only_integer => true, :greater_than => 0
    instance = stub(:some_decimal => 1.23)
    validation.valid?(instance)
  end
  
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_int, :only_integer => true, :greater_than => 0
    instance = stub(:some_int => 1)
    validation.valid?(instance)
  end
  
  expect true do
    validation = Validatable::ValidatesNumericalityOf.new stub_everything, :some_decimal, :greater_than => 0
    instance = stub(:some_decimal => 1.23)
    validation.valid?(instance)
  end
  
  expect true do
    options = [:message, :if, :times, :level, :groups, :only_integer, :greater_than]
    Validatable::ValidatesNumericalityOf.new(stub_everything, :test).must_understand(options.to_blank_options_hash)
  end
  
end
