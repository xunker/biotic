# frozen_string_literal: true

require_relative 'world_state'
require_relative 'morphogen'

# class World
class World
  # @param width [Integer]
  # @param height [Integer]
  # @param init [String]
  def initialize(width:, height:, init: nil)
    @state = WorldState.new(width: width, height: height, init: init)
  end

  # reset the entire world state (all dead)
  def clear
    @state = WorldState.new(width: @state.width, height: @state.height)
  end

  # returns a frozen copy of the world's current state
  # @return [WorldState]
  def state
    @state.dup.freeze
  end

  # Set a player at a given position
  # @param player [String] a character representing a player, or space for dead cell
  # @param pos [Integer] the position it should be set at
  def set_player(player: ' ', pos:)
    @state[pos] = player
  end

  # get the current score for a given player
  # @param player [String] a character representing a player
  # @return [Integer]
  def player_score(player)
    @state.count(player)
  end

  # takes a morphogen seed and puts it (starting at) the given position
  # @param pos [Integer]
  # @param seed [Array<String>]
  # @param char [String]
  def seed_player(pos:, seed:, char:)
    return unless seed.length == 8
    seed.each do |string|
      return unless string.length == 8
      string.each_char do |c|
        set_player(player: char, pos: pos) if c == 'X'
        pos += 1
      end
      pos += @state.width - string.length
    end
  end

  # transition the world from the present state to its next state
  def iterate
    @state.each_char.each_with_index.each_with_object([]) do |(curr, pos), memo|
      nxt = @state.next(pos)
      curr == nxt ? memo : memo << [nxt, pos]
    end.each do |char, pos|
      set_player(player: char, pos: pos)
    end
  end
end
