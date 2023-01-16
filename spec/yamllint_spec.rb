require 'spec_helper'
require_relative '../lib/yaml-lint'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'YamlLint' do
  describe '.do_lint' do
    it 'accepts a good yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to eq 0
    end

    it 'refuses a bad yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad.yaml')
      expect(lint.do_lint).to eq 1
    end

    it 'checks both files in a dir' do
      lint = YamlLint.new(FIXTURES_PATH)
      expect(lint.do_lint).to be > 0
    end
  end

  describe 'the logging' do
    it 'writes OK and error when not quiet' do
      lint = YamlLint.new(FIXTURES_PATH)
      expect { lint.do_lint }.to output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to output(/should be .yaml or .yml/).to_stdout
    end

    it 'does write only errors when quiet' do
      lint = YamlLint.new(FIXTURES_PATH, {:quiet => true})
      expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to output(/should be .yaml or .yml/).to_stdout
    end

    it 'does not write anything when very quiet' do
      lint = YamlLint.new(FIXTURES_PATH, {:veryquiet => true})
      expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to_not output(/should be .yaml or .yml/).to_stdout
    end
  end

  describe 'with different file extensions' do

    it 'is okay with known extensions' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to eq 0
      lint = YamlLint.new(FIXTURES_PATH + 'good.yml')
      expect(lint.do_lint).to eq 0
    end

    it 'is not okay with an unknown extensions' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.lmay')
      expect { lint.do_lint }.to output(/should be .yaml or .yml/).to_stdout
      expect(lint.do_lint).to eq 1
    end

    it 'is okay with an unknown extensions when the extension is not checked' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.lmay', {:nocheckfileext => true})
      expect(lint.do_lint).to eq 0
    end
  end
end
