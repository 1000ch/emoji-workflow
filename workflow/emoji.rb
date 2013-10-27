class Emoji

  # Emojis
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
  
  # Filter with query
  def select!(queries, emojis = @emojis)
    queries.each do |query|
      emojis.reject! do |emoji|
        emoji.index(query.downcase) ? false : true
      end
    end
  end
  
  # Get Alfred items
  def get_items(alfred_items = @alfred_items, emojis = @emojis)
    emojis.each do |emoji|
      alfred_items.push(format_item(emoji))
    end
    alfred_items   
  end

  # Format for Alfred
  def format_item(emoji)
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