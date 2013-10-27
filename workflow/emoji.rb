class Emoji

  # Emoji list of emoji
  def emojis
    @emojis
  end

  # Items formatted for Alfred
  def alfred_items
    @alfred_items
  end

  # Emoji constructor
  def initialize(query = '')
    @emojis = load_emojis
    @alfred_items = []
    select!(query.split)
  end
  
  # Load Emojis from emoji folder
  def load_emojis
    Dir.glob("./emoji/*.png").map do |path|
      File.basename(path, ".png")
    end.compact.uniq.sort
  end
  
  # Filter with arguments
  def select!(queries, emojis = @emojis)
    queries.each do |q|
      # use reject! for ruby 1.8 compatible
      emojis.reject! do |i|
        i.index(q.downcase) ? false : true
      end
    end
  end
  
  # Get Alfred items
  def get_items(alfred_items = @alfred_items, emojis = @emojis)
    emojis.each do |emoji|
      alfred_items.push(item_hash(emoji))
    end
    alfred_items   
  end

  # Alfred item format
  def item_hash(emoji)
    {
      :uid      => "",
      :title    => emoji,
      :subtitle => "Copy to clipboard :#{emoji}:",
      :arg      => emoji,
      :icon     => { :type => "default", :name => "./emoji/#{emoji}.png" },
      :valid    => "yes",
    }
  end

end