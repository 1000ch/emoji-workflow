module Emoji
  def self.emojis
    Dir.glob(File.expand_path('./emoji/*.png')).map do |path|
      md = /\/(.+)\.png/.match(path)
      (md && md[1]) ? md[1] : nil
    end.compact.uniq.sort
  end

  def self.select!(emojis, queries)
    queries.each do |q|
      # use reject! for ruby 1.8 compatible
      emojis.reject! { |i| i.index(q.downcase) ? false : true }
    end
  end

  def self.item_hash(emoji)
    {
      :uid      => '',
      :title    => emoji,
      :subtitle => "Copy to clipboard: #{emoji}",
      :arg      => emoji,
      :emoji     => { :type => 'default', :name => "./emoji/#{emoji}.png" },
      :valid    => 'yes',
    }
  end
end