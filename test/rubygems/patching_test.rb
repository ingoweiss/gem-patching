require File.expand_path('../../test_helper', __FILE__)

class RubygemsPatchingTest < Test::Unit::TestCase

  def setup
  end

  def test_should_run_code_if_gem_loaded_and_requirement_satisfied
    some_object = mock()
    mock_gem_spec = mock(:version => '1.2.9')
    Gem.expects(:loaded_specs).returns({'some-gem' => mock_gem_spec})
    mock_gem_requirement = mock()
    mock_gem_dependency = mock(:requirement => mock_gem_requirement)
    Gem::Dependency.expects('new').with('some-gem', '1.2.9').returns(mock_gem_dependency)
    mock_gem_requirement.expects(:'satisfied_by?').with('1.2.9').returns(true)
    some_object.expects('some_method')
    
    Gem.patching('some-gem', '1.2.9') do
      some_object.some_method
    end
  end
  
  def test_should_not_run_code_but_raise_exception_if_gem_not_loaded
    some_object = mock()
    mock_gem_spec = stub(:version => '0.0.9')
    Gem.expects(:loaded_specs).returns({'not-our-gem' => mock_gem_spec})
    mock_gem_requirement = stub()
    mock_gem_dependency = stub(:requirement => mock_gem_requirement)
    Gem::Dependency.expects('new').with('some-gem', '1.2.9').returns(mock_gem_dependency)
    some_object.expects('some_method').never
    
    assert_raise RuntimeError do
      Gem.patching('some-gem', '1.2.9') do
        some_object.some_method
      end
    end
  end
  
  def test_should_not_run_code_but_raise_exception_if_gem_loaded_but_requirement_not_satisfied
    some_object = mock()
    mock_gem_spec = stub(:version => '1.2.9')
    Gem.expects(:loaded_specs).returns({'some-gem' => mock_gem_spec})
    mock_gem_requirement = mock()
    mock_gem_dependency = stub(:requirement => mock_gem_requirement)
    mock_gem_requirement.expects(:'satisfied_by?').with('1.2.9').returns(false)
    Gem::Dependency.expects('new').with('some-gem', '1.2.9').returns(mock_gem_dependency)
    some_object.expects('some_method').never
    
    assert_raise RuntimeError do
      Gem.patching('some-gem', '1.2.9') do
        some_object.some_method
      end
    end
  end

end