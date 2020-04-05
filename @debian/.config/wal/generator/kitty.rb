#!/usr/bin/env ruby
# frozen_string_literal: true

# Generate a custom palette for kitty diff
# Credits: https://github.com/spejamchr/cfg


THEME = File.read(
  File.join(ENV['XDG_CACHE_HOME'], 'wal', "colors.sh")
).freeze

KITTY_DIR = File.join(ENV['XDG_CONFIG_HOME'], 'kitty').freeze

KITTY_COLORS_PATH = File.join(KITTY_DIR, 'colors.conf').freeze

DIFF_COLORS_PATH = File.join(ENV['XDG_CACHE_HOME'], 'wal', 'colors-kitty-diff.conf').freeze

# Represent a possibly present value
class Maybe
  def self.nothing
    new(nil)
  end

  def self.just(val)
    new(val)
  end

  def initialize(val)
    @val = val.nil? ? { kind: :nothing } : { kind: :just, val: val }
  end

  def map
    thing = just? ? yield(val[:val]) : self
    thing.is_a?(Maybe) ? thing : Maybe.new(thing)
  end

  def effect
    just? && yield(val[:val])
    self
  end

  def assign(name)
    return self unless just?
    return self.class.nothing unless val[:val].is_a?(Hash)

    other = yield(val[:val])
    other = other.is_a?(Maybe) ? other : Maybe.new(other)
    other.map { |ov| val[:val].merge(name => ov) }
  end

  private

  attr_reader :val

  def just?
    val[:kind] == :just
  end
end

def get_color(color)
  rgb_matches = THEME.scan(/#{color}='(.*)'/)
  if rgb_matches.empty?
    puts "Can't find color '#{color}'"
    Maybe.nothing
  else
    Maybe.just(rgb_matches.first.first.split('/').join)
  end
end

# Take an rgb hex string "#RRGGBB" and convert to hsl array [h, s, l]
def rgb_to_hsl(rgb)
  hex_pair = /[\da-f]{2}/i

  r, g, b = rgb.scan(hex_pair).map { |n| n.to_i(16) / 255.0 }
  max = [r, g, b].max
  min = [r, g, b].min
  c = max - min

  h_prime =
    if c.zero?
      0.0
    elsif max == r
      ((g - b) / c) % 6
    elsif max == g
      (b - r) / c + 2
    elsif max == b
      (r - g) / c + 4
    end

  h = (60 * h_prime)
  l = (max + min) / 2
  s = [0, 1].include?(l) ? 0.0 : (c / (1 - (2 * l - 1).abs))

  [h, s, l]
end

# Convert an hsl array [h, s, l] to rgb hex string "#RRGGBB"
def hsl_to_rgb(hsl)
  h, s, l = hsl
  a = s * [l, 1 - l].min
  f = lambda do |n|
    k = (n + h / 30.0) % 12
    l - a * [[k - 3, 9 - k, 1].min, -1].max
  end

  '#' +
    [0, 8, 4]
    .map(&f)
    .map { |n| (n * 255).round.to_s(16) }
    .map { |c| c.length == 1 ? "0#{c}" : c }
    .join
end

def clamp(num, min, max)
  [[num, min].max, max].min
end

def adjust_hsl(color, diffs)
  h, s, l = rgb_to_hsl(color)

  h = (h + diffs[0]) % 360
  s = clamp(s * diffs[1], 0, 1)
  l = clamp(l * diffs[2], 0, 1)

  hsl_to_rgb([h, s, l])
end

# See https://github.com/chriskempson/base16/blob/master/styling.md
palette =
  Maybe
  .just({})
  .assign(:base00) { get_color('color0') } # black
  .assign(:base01) { get_color('color8') }
  .assign(:base02) { get_color('color9') }
  .assign(:base03) { get_color('color8') } # bright black
  .assign(:base04) { get_color('color10') }
  .assign(:base05) { get_color('color7') } # white
  .assign(:base06) { get_color('color11') }
  .assign(:base07) { get_color('color15') } # bright white
  .assign(:base08) { get_color('color1') } # red
  .assign(:base09) { get_color('color13') } # orange?
  .assign(:base0A) { get_color('color3') } # yellow
  .assign(:base0B) { get_color('color2') } # green
  .assign(:base0C) { get_color('color6') } # cyan
  .assign(:base0D) { get_color('color4') } # blue
  .assign(:base0E) { get_color('color5') } # magenta
  .assign(:base0F) { get_color('color14') } # brown?

kitty_colors = palette.map do |p|
  {
    foreground: p[:base05],
    background: p[:base00],

    selection_foreground: p[:base05],
    selection_background: p[:base02],

    color0: p[:base00], # black
    color8: p[:base03], # bright black

    color1: p[:base08], # red
    color9: p[:base08],

    color2: p[:base0B], # green
    color10: p[:base0B],

    color3: p[:base0A], # yellow
    color11: p[:base0A],

    color4: p[:base0D], # blue
    color12: p[:base0D],

    color5: p[:base0E], # magenta
    color13: p[:base0E],

    color6: p[:base0C], # cyan
    color14: p[:base0C],

    color7: p[:base05], # white
    color15: p[:base07], # bright white
  }
end

kitty_diff_colors = palette.map do |p|
  {
    foreground:           p[:base05],
    background:           p[:base00],

    title_fg:             p[:base04],
    title_bg:             p[:base00],

    margin_fg:            p[:base04],
    margin_bg:            p[:base00],

    removed_bg:           adjust_hsl(p[:base08], [0, 0.5, 0.5]),
    highlight_removed_bg: adjust_hsl(p[:base08], [0, 0.8, 0.6]),
    removed_margin_bg:    adjust_hsl(p[:base08], [0, 0.5, 0.5]),

    added_bg:             adjust_hsl(p[:base0B], [0, 0.5, 0.5]),
    highlight_added_bg:   adjust_hsl(p[:base0B], [0, 0.8, 0.6]),
    added_margin_bg:      adjust_hsl(p[:base0B], [0, 0.5, 0.5]),

    filler_bg:            p[:base00],

    hunk_margin_bg:       adjust_hsl(p[:base0D], [0, 0.5, 0.5]),
    hunk_bg:              adjust_hsl(p[:base0D], [0, 0.5, 0.5]),

    search_fg:            p[:base05],
    search_bg:            p[:base02],

    select_fg:            p[:base05],
    select_bg:            p[:base02],
  }
end

# kitty_colors.effect do |colors|
#   File.open(KITTY_COLORS_PATH, 'w') do |f|
#     f.puts '# Autogenerated by a base16-shell hook in'
#     f.puts "# #{__FILE__}"
#     f.puts colors.map { |kv| kv.join(' ') }.join("\n")
#   end
# end

kitty_diff_colors.effect do |colors|
  File.open(DIFF_COLORS_PATH, 'w') do |f|
    f.puts '# Autogenerated by a base16-shell hook in'
    f.puts "# #{__FILE__}"
    f.puts colors.map { |kv| kv.join(' ') }.join("\n")
  end
end
