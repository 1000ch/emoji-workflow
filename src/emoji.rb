module Emoji
  def self.emojis
    Dir.glob('./emoji/*.png').map do |path|
      File.basename(path, ".png")
    end.compact.uniq.sort
  end

  def self.select!(emojis, queries)
    queries.each do |q|
      # use reject! for ruby 1.8 compatible
      emojis.reject! do |i|
        i.index(q.downcase) ? false : true
      end
    end
  end

  def self.item_hash(emoji)
    {
      :uid      => '',
      :title    => emoji,
      :subtitle => "Copy to clipboard :#{emoji}:",
      :arg      => emoji,
      :icon     => { :type => 'default', :name => "./emoji/#{emoji}.png" },
      :valid    => 'yes',
    }
  end
end