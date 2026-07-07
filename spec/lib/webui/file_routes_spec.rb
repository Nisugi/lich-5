# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/file_routes'

RSpec.describe Lich::WebUI::FileRoutes do
  around do |example|
    Dir.mktmpdir('webui-files') do |dir|
      @root = File.realpath(dir)
      File.binwrite(File.join(@root, 'map1.png'), 'PNGDATA')
      FileUtils.mkdir_p(File.join(@root, 'sub'))
      File.binwrite(File.join(@root, 'sub', 'town.jpg'), 'JPGDATA')
      File.binwrite(File.join(@root, 'secrets.txt'), 'nope')
      example.run
    end
  ensure
    described_class.clear!
  end

  describe '.register' do
    it 'accepts existing directories and rejects bad aliases and paths' do
      expect(described_class.register('maps', @root)).to be(true)
      expect(described_class.register('bad alias', @root)).to be(false)
      expect(described_class.register('../evil', @root)).to be(false)
      expect(described_class.register('missing', File.join(@root, 'nope'))).to be(false)
    end
  end

  describe '.resolve' do
    before do
      described_class.register('maps', @root)
    end

    it 'serves whitelisted image files with content types' do
      path, type = described_class.resolve('maps', 'map1.png')
      expect(path).to eq(File.join(@root, 'map1.png'))
      expect(type).to eq('image/png')

      _, type = described_class.resolve('maps', 'sub/town.jpg')
      expect(type).to eq('image/jpeg')
    end

    it 'decodes percent-encoded names' do
      File.binwrite(File.join(@root, 'two words.png'), 'PNG')
      path, = described_class.resolve('maps', 'two%20words.png')
      expect(path).to end_with('two words.png')
    end

    it 'refuses non-image extensions' do
      expect(described_class.resolve('maps', 'secrets.txt')).to be_nil
    end

    it 'refuses unknown aliases and missing files' do
      expect(described_class.resolve('other', 'map1.png')).to be_nil
      expect(described_class.resolve('maps', 'ghost.png')).to be_nil
    end

    it 'refuses every traversal shape' do
      outside = File.join(File.dirname(@root), 'outside.png')
      File.binwrite(outside, 'PNG')
      begin
        expect(described_class.resolve('maps', '../outside.png')).to be_nil
        expect(described_class.resolve('maps', '%2e%2e/outside.png')).to be_nil
        expect(described_class.resolve('maps', '..%2foutside.png')).to be_nil
        expect(described_class.resolve('maps', 'sub/../../outside.png')).to be_nil
        expect(described_class.resolve('maps', outside)).to be_nil # absolute path
        expect(described_class.resolve('maps', "..\\outside.png")).to be_nil
      ensure
        File.delete(outside)
      end
    end

    it 'refuses NUL bytes and empty paths' do
      expect(described_class.resolve('maps', "map1.png\0.txt")).to be_nil
      expect(described_class.resolve('maps', '')).to be_nil
    end
  end

  describe 'ownership' do
    it 'removes a dying script routes and keeps others' do
      owner = Struct.new(:name).new('mapper')
      other = Struct.new(:name).new('other')
      described_class.register('mine', @root, owner: owner)
      described_class.register('theirs', @root, owner: other)
      described_class.register('core', @root) # no owner

      described_class.cleanup_for(owner)
      expect(described_class.resolve('mine', 'map1.png')).to be_nil
      expect(described_class.resolve('theirs', 'map1.png')).not_to be_nil
      expect(described_class.resolve('core', 'map1.png')).not_to be_nil
    end

    it 'unregisters by alias' do
      described_class.register('maps', @root)
      expect(described_class.unregister('maps')).to be(true)
      expect(described_class.resolve('maps', 'map1.png')).to be_nil
    end
  end
end
