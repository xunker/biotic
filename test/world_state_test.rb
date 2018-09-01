# frozen_string_literal: true

require_relative 'test_helper'

describe WorldState do
  describe '#live?' do
    it 'must return true if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.live?(0).must_equal true
    end

    it 'must return false if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.live?(0).must_equal false
    end

    it 'must return nil for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.live?(1).must_be_nil
    end
  end

  describe '#dead?' do
    it 'must return true if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.dead?(0).must_equal true
    end

    it 'must return false if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.dead?(0).must_equal false
    end

    it 'must return nil for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.dead?(-1).must_be_nil
    end
  end

  describe '#team' do
    it 'must return the team character for a position' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.team(0).must_equal 'X'
    end

    it 'must return nil if there is no team character at position' do
      world = WorldState.new(width: 1, height: 1)
      world.team(0).must_be_nil
    end

    it 'must return nil if the position is outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.team(-1).must_be_nil
    end
  end

  describe '#neighbors' do
    it 'must return [] for a position before the beginning' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.neighbors(-1).must_equal []
    end

    it 'must return [] for a position beyond the end' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.neighbors(1).must_equal []
    end
  end
end