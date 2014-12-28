require 'spec_helper'
require_relative '../lib/yaml-lint'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'YamlLint' do
  describe '.do_lint' do
    it 'accepts a good yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to be true
    end 
    
    it 'refuses a bad yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad.yaml')
      expect(lint.do_lint).to be false
    end 
  end
end
